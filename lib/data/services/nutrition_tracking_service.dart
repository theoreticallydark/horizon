import 'package:isar/isar.dart';
import 'package:horizon/data/models/food_source_item.dart';
import 'package:horizon/data/models/nutrient_info.dart';
import 'package:horizon/data/models/track_record.dart';
import 'package:horizon/data/models/user_profile.dart';
import 'package:horizon/data/services/isar_service.dart';

class NutritionTrackingService {
  final IsarService _isarService;

  NutritionTrackingService({IsarService? isarService})
      : _isarService = isarService ?? IsarService.instance;

  Isar get _isar => _isarService.isar;

  DateTime _normalizeDate(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  /// Normalizes date to the Monday midnight of that calendar week
  DateTime _normalizeWeekMonday(DateTime dt) {
    final normalized = _normalizeDate(dt);
    final daysToSubtract = (normalized.weekday - DateTime.monday) % 7;
    return normalized.subtract(Duration(days: daysToSubtract));
  }

  String _formatWeekKey(DateTime weekMonday) {
    return '${weekMonday.year}-W${((weekMonday.difference(DateTime(weekMonday.year, 1, 1)).inDays) / 7).ceil()}';
  }

  // --------------------------------------------------------------------------
  // 8 TRIGGER NUTRIENTS FOR FOOD FREQUENCY DETERMINATION (10% RULE)
  // --------------------------------------------------------------------------
  static const Set<String> triggerNutrientKeys = {
    'vitamin_c',     // Vit C
    'collagen',      // Coll.
    'total_fiber',   // Fiber
    'magnesium',     // Mg
    'calcium',       // Ca
    'potassium',     // K
    'creatine',      // Creat.
    'total_protein', // Protein
  };

  /// Evaluates food frequency:
  /// 1. If user set an explicit override while food is tracked, respects the override.
  /// 2. Otherwise computes dynamically: returns daily if any 1 of the 8 trigger nutrients
  ///    provides > 10.0% of the daily target for the given planned portion, else weekly.
  TrackingFrequency determineFoodFrequency({
    required FoodSourceItem food,
    required UserProfile profile,
    required List<NutrientInfo> allNutrients,
  }) {
    // Check for user manual override while tracked
    if (food.isTracked && food.trackingFrequencyOverride != null) {
      return food.trackingFrequencyOverride!;
    }

    final portionGrams = food.plannedDailyGrams;
    final nutrientMap = {for (var n in allNutrients) n.nutrientKey: n};

    for (final nutrientVal in food.nutrients) {
      if (!triggerNutrientKeys.contains(nutrientVal.nutrientKey)) continue;

      final nutrientInfo = nutrientMap[nutrientVal.nutrientKey];
      if (nutrientInfo == null) continue;

      final target = nutrientInfo.calculateEffectiveTarget(profile);
      if (target <= 0) continue;

      final yieldAmount = (portionGrams / 100.0) * nutrientVal.amountPer100g;
      final coveragePercent = (yieldAmount / target) * 100.0;

      if (coveragePercent > 10.0) {
        return TrackingFrequency.daily;
      }
    }

    return TrackingFrequency.weekly;
  }

  // --------------------------------------------------------------------------
  // ROUTINE COVERAGE CALCULATION
  // --------------------------------------------------------------------------

  /// Computes the planned coverage of the user's active routine against their targets.
  Future<Map<String, double>> calculatePlannedRoutineCoverage() async {
    final profile = await _isar.userProfiles.get(1) ?? UserProfile();
    final routineFoods = await _isar.foodSourceItems
        .filter()
        .isVisibleOnAppEqualTo(true)
        .and()
        .isTrackedEqualTo(true)
        .findAll();

    final trackedNutrients = await _isar.nutrientInfos
        .filter()
        .isVisibleOnAppEqualTo(true)
        .and()
        .isTrackedEqualTo(true)
        .findAll();

    final Map<String, double> plannedTotals = {};

    for (final food in routineFoods) {
      final portionGrams = food.plannedDailyGrams;
      for (final nutrient in food.nutrients) {
        final contribution = (portionGrams / 100.0) * nutrient.amountPer100g;
        plannedTotals[nutrient.nutrientKey] =
            (plannedTotals[nutrient.nutrientKey] ?? 0.0) + contribution;
      }
    }

    final Map<String, double> coverageResults = {};
    for (final nutrient in trackedNutrients) {
      final target = nutrient.calculateEffectiveTarget(profile);
      final consumed = plannedTotals[nutrient.nutrientKey] ?? 0.0;
      final percent = target > 0 ? (consumed / target) * 100.0 : 0.0;
      coverageResults[nutrient.nutrientKey] = percent;
    }

    return coverageResults;
  }

  /// Watch stream of routine coverage map whenever tracked foods change
  Stream<Map<String, double>> watchPlannedRoutineCoverage() async* {
    yield await calculatePlannedRoutineCoverage();
    final foodStream = _isar.foodSourceItems
        .filter()
        .isTrackedEqualTo(true)
        .watch(fireImmediately: false);

    await for (final _ in foodStream) {
      yield await calculatePlannedRoutineCoverage();
    }
  }

  // --------------------------------------------------------------------------
  // WINDOWED SYNCHRONIZATION (Backfill gaps + 3-Day lookahead: today, today+1, today+2)
  // --------------------------------------------------------------------------

  /// Synchronizes TrackRecordDaily across missed past dates & 3-day window, and current TrackRecordWeekly
  Future<void> syncTrackRecordsWindow() async {
    final now = DateTime.now();
    final today = _normalizeDate(now);
    final thisWeekMonday = _normalizeWeekMonday(now);

    final profile = await _isar.userProfiles.get(1) ?? UserProfile();
    final allNutrients = await _isar.nutrientInfos.where().findAll();
    final routineFoods = await _isar.foodSourceItems
        .filter()
        .isVisibleOnAppEqualTo(true)
        .and()
        .isTrackedEqualTo(true)
        .findAll();

    // 1. Backfill any missed past gap dates for Daily records
    final oldestRecord = await _isar.trackRecordDailys.where().sortByDate().findFirst();
    if (oldestRecord != null) {
      var runner = oldestRecord.date.add(const Duration(days: 1));
      while (runner.isBefore(today)) {
        final existing = await _isar.trackRecordDailys.getByDate(runner);
        if (existing == null) {
          final missingRecord = TrackRecordDaily()
            ..date = runner
            ..isSynced = false
            ..routineAdherencePercent = 0.0;
          await _populateRoutineFoodsDaily(missingRecord, routineFoods, profile, allNutrients);
          await _isar.writeTxn(() async {
            await _isar.trackRecordDailys.put(missingRecord);
          });
        }
        runner = runner.add(const Duration(days: 1));
      }
    }

    // 2. Synchronize 3-day Daily window (today, today+1, today+2)
    for (int offset = 0; offset <= 2; offset++) {
      final targetDate = today.add(Duration(days: offset));
      await _syncDateRecordDaily(targetDate, routineFoods, profile, allNutrients);
    }

    // 3. Synchronize current Weekly Record
    await _syncWeekRecordWeekly(thisWeekMonday, routineFoods, profile, allNutrients);
  }

  Future<void> _syncDateRecordDaily(
    DateTime date,
    List<FoodSourceItem> routineFoods,
    UserProfile profile,
    List<NutrientInfo> allNutrients,
  ) async {
    final record = await _isar.trackRecordDailys.getByDate(date) ?? TrackRecordDaily()
      ..date = date
      ..isSynced = false;

    bool modified = false;
    final existingMap = {for (var f in record.loggedFoods) f.foodId: f};

    for (final food in routineFoods) {
      final freq = determineFoodFrequency(
        food: food,
        profile: profile,
        allNutrients: allNutrients,
      );

      // Only daily foods go into TrackRecordDaily
      if (freq != TrackingFrequency.daily) {
        if (existingMap.containsKey(food.foodId)) {
          record.loggedFoods.removeWhere((f) => f.foodId == food.foodId);
          modified = true;
        }
        continue;
      }

      if (!existingMap.containsKey(food.foodId)) {
        record.loggedFoods.add(
          TrackedFoodEntry()
            ..foodId = food.foodId
            ..foodTitle = food.title
            ..amountConsumedGrams = 0.0
            ..plannedGrams = food.plannedDailyGrams
            ..isFromRoutine = true
            ..frequency = TrackingFrequency.daily
            ..loggedAt = DateTime.now(),
        );
        modified = true;
      } else {
        final entry = existingMap[food.foodId]!;
        if (entry.plannedGrams != food.plannedDailyGrams) {
          entry.plannedGrams = food.plannedDailyGrams;
          modified = true;
        }
      }
    }

    if (modified || record.id == Isar.autoIncrement) {
      await _recalculateDailySummaries(record);
      await _isar.writeTxn(() async {
        await _isar.trackRecordDailys.put(record);
      });
    }
  }

  Future<void> _syncWeekRecordWeekly(
    DateTime weekMonday,
    List<FoodSourceItem> routineFoods,
    UserProfile profile,
    List<NutrientInfo> allNutrients,
  ) async {
    final record = await _isar.trackRecordWeeklys.getByWeekStartDate(weekMonday) ??
        TrackRecordWeekly()
          ..weekStartDate = weekMonday
          ..weekKey = _formatWeekKey(weekMonday)
          ..isSynced = false;

    bool modified = false;
    final existingMap = {for (var f in record.loggedFoods) f.foodId: f};

    for (final food in routineFoods) {
      final freq = determineFoodFrequency(
        food: food,
        profile: profile,
        allNutrients: allNutrients,
      );

      // Only weekly foods go into TrackRecordWeekly
      if (freq != TrackingFrequency.weekly) {
        if (existingMap.containsKey(food.foodId)) {
          record.loggedFoods.removeWhere((f) => f.foodId == food.foodId);
          modified = true;
        }
        continue;
      }

      if (!existingMap.containsKey(food.foodId)) {
        record.loggedFoods.add(
          TrackedFoodEntry()
            ..foodId = food.foodId
            ..foodTitle = food.title
            ..amountConsumedGrams = 0.0
            ..plannedGrams = food.plannedWeeklyGrams
            ..isFromRoutine = true
            ..frequency = TrackingFrequency.weekly
            ..loggedAt = DateTime.now(),
        );
        modified = true;
      } else {
        final entry = existingMap[food.foodId]!;
        if (entry.plannedGrams != food.plannedWeeklyGrams) {
          entry.plannedGrams = food.plannedWeeklyGrams;
          modified = true;
        }
      }
    }

    if (modified || record.id == Isar.autoIncrement) {
      await _recalculateWeeklySummaries(record);
      await _isar.writeTxn(() async {
        await _isar.trackRecordWeeklys.put(record);
      });
    }
  }

  Future<void> _populateRoutineFoodsDaily(
    TrackRecordDaily record,
    List<FoodSourceItem> routineFoods,
    UserProfile profile,
    List<NutrientInfo> allNutrients,
  ) async {
    for (final food in routineFoods) {
      final freq = determineFoodFrequency(
        food: food,
        profile: profile,
        allNutrients: allNutrients,
      );
      if (freq == TrackingFrequency.daily) {
        record.loggedFoods.add(
          TrackedFoodEntry()
            ..foodId = food.foodId
            ..foodTitle = food.title
            ..amountConsumedGrams = 0.0
            ..plannedGrams = food.plannedDailyGrams
            ..isFromRoutine = true
            ..frequency = freq
            ..loggedAt = record.date,
        );
      }
    }
    await _recalculateDailySummaries(record);
  }

  // --------------------------------------------------------------------------
  // ROUTINE MUTATION HANDLERS
  // --------------------------------------------------------------------------

  Future<void> handleRoutineFoodAdded(String foodId) async {
    final food = await _isar.foodSourceItems.getByFoodId(foodId);
    if (food == null) return;

    food.isTracked = true;
    await _isar.writeTxn(() async {
      await _isar.foodSourceItems.put(food);
    });

    await syncTrackRecordsWindow();
  }

  Future<void> handleRoutineFoodRemoved(String foodId) async {
    final food = await _isar.foodSourceItems.getByFoodId(foodId);
    if (food == null) return;

    food.isTracked = false;
    food.trackingFrequencyOverride = null; // Automatically reset override back to default math
    await _isar.writeTxn(() async {
      await _isar.foodSourceItems.put(food);
    });

    final today = _normalizeDate(DateTime.now());

    // Daily Record
    final todayDaily = await _isar.trackRecordDailys.getByDate(today);
    if (todayDaily != null) {
      final entryIndex = todayDaily.loggedFoods.indexWhere((f) => f.foodId == foodId);
      if (entryIndex >= 0 && todayDaily.loggedFoods[entryIndex].amountConsumedGrams <= 0) {
        todayDaily.loggedFoods.removeAt(entryIndex);
        await _recalculateDailySummaries(todayDaily);
        await _isar.writeTxn(() async {
          await _isar.trackRecordDailys.put(todayDaily);
        });
      }
    }

    // Future daily records
    final futureDailies = await _isar.trackRecordDailys
        .filter()
        .dateGreaterThan(today)
        .findAll();
    if (futureDailies.isNotEmpty) {
      await _isar.writeTxn(() async {
        for (final r in futureDailies) {
          r.loggedFoods.removeWhere((f) => f.foodId == foodId);
          await _recalculateDailySummaries(r);
          await _isar.trackRecordDailys.put(r);
        }
      });
    }

    // Weekly record
    final thisWeekMonday = _normalizeWeekMonday(today);
    final weekRecord = await _isar.trackRecordWeeklys.getByWeekStartDate(thisWeekMonday);
    if (weekRecord != null) {
      final entryIndex = weekRecord.loggedFoods.indexWhere((f) => f.foodId == foodId);
      if (entryIndex >= 0 && weekRecord.loggedFoods[entryIndex].amountConsumedGrams <= 0) {
        weekRecord.loggedFoods.removeAt(entryIndex);
        await _recalculateWeeklySummaries(weekRecord);
        await _isar.writeTxn(() async {
          await _isar.trackRecordWeeklys.put(weekRecord);
        });
      }
    }
  }

  /// Sets or updates a manual frequency override for an active routine food,
  /// and immediately re-syncs the daily and weekly tracking records.
  Future<void> setFoodFrequencyOverride({
    required String foodId,
    required TrackingFrequency frequency,
  }) async {
    final food = await _isar.foodSourceItems.getByFoodId(foodId);
    if (food == null || !food.isTracked) return;

    food.trackingFrequencyOverride = frequency;
    await _isar.writeTxn(() async {
      await _isar.foodSourceItems.put(food);
    });

    await syncTrackRecordsWindow();
  }

  // --------------------------------------------------------------------------
  // REACTIVE LOGGING & WATCHERS
  // --------------------------------------------------------------------------

  Stream<TrackRecordDaily?> watchTodayDailyRecord() {
    final today = _normalizeDate(DateTime.now());
    return _isar.trackRecordDailys
        .filter()
        .dateEqualTo(today)
        .watch(fireImmediately: true)
        .map((list) => list.isNotEmpty ? list.first : null);
  }

  Stream<TrackRecordWeekly?> watchCurrentWeeklyRecord() {
    final thisWeekMonday = _normalizeWeekMonday(DateTime.now());
    return _isar.trackRecordWeeklys
        .filter()
        .weekStartDateEqualTo(thisWeekMonday)
        .watch(fireImmediately: true)
        .map((list) => list.isNotEmpty ? list.first : null);
  }

  Future<void> toggleDailyFoodChecked({
    required String foodId,
    required bool isChecked,
    DateTime? date,
  }) async {
    final targetDate = _normalizeDate(date ?? DateTime.now());
    final record = await _isar.trackRecordDailys.getByDate(targetDate) ??
        TrackRecordDaily()
          ..date = targetDate
          ..isSynced = false;

    final food = await _isar.foodSourceItems.getByFoodId(foodId);
    if (food == null) return;

    final entryIndex = record.loggedFoods.indexWhere((f) => f.foodId == foodId);
    final consumedAmount = isChecked ? food.plannedDailyGrams : 0.0;

    if (entryIndex >= 0) {
      record.loggedFoods[entryIndex].amountConsumedGrams = consumedAmount;
      record.loggedFoods[entryIndex].loggedAt = DateTime.now();
    } else {
      record.loggedFoods.add(
        TrackedFoodEntry()
          ..foodId = food.foodId
          ..foodTitle = food.title
          ..amountConsumedGrams = consumedAmount
          ..plannedGrams = food.plannedDailyGrams
          ..isFromRoutine = food.isTracked
          ..frequency = TrackingFrequency.daily
          ..loggedAt = DateTime.now(),
      );
    }

    await _recalculateDailySummaries(record);
    await _isar.writeTxn(() async {
      await _isar.trackRecordDailys.put(record);
    });
  }

  /// Increments or logs intake for a weekly food in the current week
  Future<void> updateWeeklyFoodIntake({
    required String foodId,
    required double deltaGrams,
    DateTime? date,
  }) async {
    final thisWeekMonday = _normalizeWeekMonday(date ?? DateTime.now());
    final record = await _isar.trackRecordWeeklys.getByWeekStartDate(thisWeekMonday) ??
        TrackRecordWeekly()
          ..weekStartDate = thisWeekMonday
          ..weekKey = _formatWeekKey(thisWeekMonday)
          ..isSynced = false;

    final food = await _isar.foodSourceItems.getByFoodId(foodId);
    if (food == null) return;

    final entryIndex = record.loggedFoods.indexWhere((f) => f.foodId == foodId);
    if (entryIndex >= 0) {
      final current = record.loggedFoods[entryIndex].amountConsumedGrams;
      final updated = (current + deltaGrams).clamp(0.0, 99999.0);
      record.loggedFoods[entryIndex].amountConsumedGrams = updated;
      record.loggedFoods[entryIndex].loggedAt = DateTime.now();
    } else {
      record.loggedFoods.add(
        TrackedFoodEntry()
          ..foodId = food.foodId
          ..foodTitle = food.title
          ..amountConsumedGrams = deltaGrams.clamp(0.0, 99999.0)
          ..plannedGrams = food.plannedWeeklyGrams
          ..isFromRoutine = food.isTracked
          ..frequency = TrackingFrequency.weekly
          ..loggedAt = DateTime.now(),
      );
    }

    await _recalculateWeeklySummaries(record);
    await _isar.writeTxn(() async {
      await _isar.trackRecordWeeklys.put(record);
    });
  }

  /// Watch consumed nutrient coverage map for today (Daily consumed + Weekly consumed/7)
  Stream<Map<String, double>> watchTodayConsumedCoverage() {
    final today = _normalizeDate(DateTime.now());
    final thisWeekMonday = _normalizeWeekMonday(today);

    final dailyStream = _isar.trackRecordDailys
        .filter()
        .dateEqualTo(today)
        .watch(fireImmediately: true);

    return dailyStream.asyncMap((dailyList) async {
      final weekList = await _isar.trackRecordWeeklys
          .filter()
          .weekStartDateEqualTo(thisWeekMonday)
          .findAll();

      final Map<String, double> coverage = {};

      if (dailyList.isNotEmpty) {
        for (final s in dailyList.first.nutrientSummaries) {
          coverage[s.nutrientKey] = s.percentageMet;
        }
      }

      if (weekList.isNotEmpty) {
        for (final s in weekList.first.nutrientSummaries) {
          // Add weekly nutrient contribution normalized to daily (percentage / 7)
          coverage[s.nutrientKey] =
              (coverage[s.nutrientKey] ?? 0.0) + (s.percentageMet / 7.0);
        }
      }

      return coverage;
    });
  }

  Future<void> _recalculateDailySummaries(TrackRecordDaily record) async {
    final profile = await _isar.userProfiles.get(1) ?? UserProfile();
    final allNutrients = await _isar.nutrientInfos.where().findAll();

    final foodIds = record.loggedFoods.map((f) => f.foodId).toList();
    final foods = await _isar.foodSourceItems
        .filter()
        .anyOf(foodIds, (q, String id) => q.foodIdEqualTo(id))
        .findAll();

    final foodMap = {for (var f in foods) f.foodId: f};

    final Map<String, double> aggregatedNutrients = {};
    for (final logged in record.loggedFoods) {
      if (logged.amountConsumedGrams <= 0) continue;
      final food = foodMap[logged.foodId];
      if (food == null) continue;

      for (final nutrient in food.nutrients) {
        final consumed =
            (logged.amountConsumedGrams / 100.0) * nutrient.amountPer100g;
        aggregatedNutrients[nutrient.nutrientKey] =
            (aggregatedNutrients[nutrient.nutrientKey] ?? 0.0) + consumed;
      }
    }

    final List<TrackNutrientSummary> summaries = [];
    for (final nutrient in allNutrients) {
      final target = nutrient.calculateEffectiveTarget(profile);
      final consumed = aggregatedNutrients[nutrient.nutrientKey] ?? 0.0;
      final percent = target > 0 ? (consumed / target) * 100.0 : 0.0;

      summaries.add(
        TrackNutrientSummary()
          ..nutrientKey = nutrient.nutrientKey
          ..amountConsumed = consumed
          ..targetAmount = target
          ..percentageMet = percent,
      );
    }

    record.nutrientSummaries = summaries;

    final routineEntries =
        record.loggedFoods.where((f) => f.isFromRoutine).toList();
    if (routineEntries.isNotEmpty) {
      double adherenceSum = 0.0;
      for (final entry in routineEntries) {
        final ratio = entry.plannedGrams > 0
            ? (entry.amountConsumedGrams / entry.plannedGrams)
            : 0.0;
        adherenceSum += ratio.clamp(0.0, 1.0);
      }
      record.routineAdherencePercent =
          (adherenceSum / routineEntries.length) * 100.0;
    }
  }

  Future<void> _recalculateWeeklySummaries(TrackRecordWeekly record) async {
    final profile = await _isar.userProfiles.get(1) ?? UserProfile();
    final allNutrients = await _isar.nutrientInfos.where().findAll();

    final foodIds = record.loggedFoods.map((f) => f.foodId).toList();
    final foods = await _isar.foodSourceItems
        .filter()
        .anyOf(foodIds, (q, String id) => q.foodIdEqualTo(id))
        .findAll();

    final foodMap = {for (var f in foods) f.foodId: f};

    final Map<String, double> aggregatedNutrients = {};
    for (final logged in record.loggedFoods) {
      if (logged.amountConsumedGrams <= 0) continue;
      final food = foodMap[logged.foodId];
      if (food == null) continue;

      for (final nutrient in food.nutrients) {
        final consumed =
            (logged.amountConsumedGrams / 100.0) * nutrient.amountPer100g;
        aggregatedNutrients[nutrient.nutrientKey] =
            (aggregatedNutrients[nutrient.nutrientKey] ?? 0.0) + consumed;
      }
    }

    final List<TrackNutrientSummary> summaries = [];
    for (final nutrient in allNutrients) {
      final target = nutrient.calculateEffectiveTarget(profile) * 7.0;
      final consumed = aggregatedNutrients[nutrient.nutrientKey] ?? 0.0;
      final percent = target > 0 ? (consumed / target) * 100.0 : 0.0;

      summaries.add(
        TrackNutrientSummary()
          ..nutrientKey = nutrient.nutrientKey
          ..amountConsumed = consumed
          ..targetAmount = target
          ..percentageMet = percent,
      );
    }

    record.nutrientSummaries = summaries;

    final routineEntries =
        record.loggedFoods.where((f) => f.isFromRoutine).toList();
    if (routineEntries.isNotEmpty) {
      double adherenceSum = 0.0;
      for (final entry in routineEntries) {
        final ratio = entry.plannedGrams > 0
            ? (entry.amountConsumedGrams / entry.plannedGrams)
            : 0.0;
        adherenceSum += ratio.clamp(0.0, 1.0);
      }
      record.routineAdherencePercent =
          (adherenceSum / routineEntries.length) * 100.0;
    }
  }
}
