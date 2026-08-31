import 'dart:async';
import 'package:flutter/foundation.dart';
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

  /// Global simulated date notifier for time travel / debugging
  static final ValueNotifier<DateTime> simulatedDateNotifier =
      ValueNotifier<DateTime>(DateTime.now());

  /// Current normalized date according to the time simulator
  DateTime get currentDate => _normalizeDate(simulatedDateNotifier.value);

  /// Current week Monday according to the time simulator
  DateTime get currentWeekMonday => _normalizeWeekMonday(simulatedDateNotifier.value);

  /// Shifts the simulated date by deltaDays (e.g. +1 or -1) and triggers window sync
  Future<void> stepSimulatedDate(int deltaDays) async {
    final newDate = simulatedDateNotifier.value.add(Duration(days: deltaDays));
    simulatedDateNotifier.value = newDate;
    await syncTrackRecordsWindow();
  }

  /// Resets simulated date to real device DateTime.now()
  Future<void> resetSimulatedDateToToday() async {
    simulatedDateNotifier.value = DateTime.now();
    await syncTrackRecordsWindow();
  }

  /// Sets an explicit simulated date
  Future<void> setSimulatedDate(DateTime date) async {
    simulatedDateNotifier.value = date;
    await syncTrackRecordsWindow();
  }

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

  /// Evaluates food frequency (reads directly from food.frequency, or computes if needed)
  TrackingFrequency determineFoodFrequency({
    required FoodSourceItem food,
    required UserProfile profile,
    required List<NutrientInfo> allNutrients,
  }) {
    return food.calculateFrequency(profile: profile, allNutrients: allNutrients);
  }

  // --------------------------------------------------------------------------
  // ROUTINE COVERAGE CALCULATION
  // --------------------------------------------------------------------------

  /// Computes the planned coverage of the user's active routine against their targets.
  Future<Map<String, double>> calculatePlannedRoutineCoverage() async {
    final profile = await _isar.userProfiles.get(1) ?? UserProfile();
    final trackedNutrients = await _isar.nutrientInfos
        .filter()
        .isVisibleOnAppEqualTo(true)
        .and()
        .isTrackedEqualTo(true)
        .findAll();

    final routineFoods = await _isar.foodSourceItems
        .filter()
        .isVisibleOnAppEqualTo(true)
        .and()
        .isTrackedEqualTo(true)
        .findAll();

    final Map<String, double> plannedTotals = {};

    for (final food in routineFoods) {
      final portionGrams = food.plannedDailyGrams;
      for (final nutrient in food.nutrients) {
        if (nutrient.nutrientKey == 'total_protein' && food.proteinIndex != 1) continue;
        final contribution = (portionGrams / 100.0) * nutrient.amountPer100g;
        plannedTotals[nutrient.nutrientKey] =
            (plannedTotals[nutrient.nutrientKey] ?? 0.0) + contribution;
      }
    }

    final Map<String, double> coverageResults = {};
    for (final nutrient in trackedNutrients) {
      final target = nutrient.calculateEffectiveTarget(profile);
      final dailyConsumed = plannedTotals[nutrient.nutrientKey] ?? 0.0;
      // If nutrient target is weekly (7 days), compare planned weekly yield (dailyConsumed * 7) against weekly target
      final plannedYield = nutrient.frequency == TrackingFrequency.weekly
          ? dailyConsumed * 7.0
          : dailyConsumed;
      final percent = target > 0 ? (plannedYield / target) * 100.0 : 0.0;
      coverageResults[nutrient.nutrientKey] = percent;
    }

    return coverageResults;
  }

  /// Watch stream of routine coverage map whenever tracked foods change.
  /// Computed 100% in-memory from emitted stream objects without triggering redundant disk queries.
  Stream<Map<String, double>> watchPlannedRoutineCoverage() {
    return watchTrackedRoutineFoods().asyncMap((routineFoods) async {
      final profile = await _isar.userProfiles.get(1) ?? UserProfile();
      final trackedNutrients = await _isar.nutrientInfos
          .filter()
          .isTrackedEqualTo(true)
          .findAll();

      final Map<String, double> plannedTotals = {};
      for (final food in routineFoods) {
        final portionGrams = food.plannedDailyGrams;
        for (final nutrient in food.nutrients) {
          if (nutrient.nutrientKey == 'total_protein' && food.proteinIndex != 1) continue;
          final contribution = (portionGrams / 100.0) * nutrient.amountPer100g;
          plannedTotals[nutrient.nutrientKey] =
              (plannedTotals[nutrient.nutrientKey] ?? 0.0) + contribution;
        }
      }

      final Map<String, double> coverageResults = {};
      for (final nutrient in trackedNutrients) {
        final target = nutrient.calculateEffectiveTarget(profile);
        final dailyConsumed = plannedTotals[nutrient.nutrientKey] ?? 0.0;
        final plannedYield = nutrient.frequency == TrackingFrequency.weekly
            ? dailyConsumed * 7.0
            : dailyConsumed;
        final percent = target > 0 ? (plannedYield / target) * 100.0 : 0.0;
        coverageResults[nutrient.nutrientKey] = percent;
      }

      return coverageResults;
    });
  }

  // --------------------------------------------------------------------------
  // WINDOWED SYNCHRONIZATION (Backfill gaps + 3-Day lookahead: today, today+1, today+2)
  // --------------------------------------------------------------------------

  /// Synchronizes TrackRecordDaily across missed past dates & 3-day window, and current TrackRecordWeekly
  Future<void> syncTrackRecordsWindow() async {
    final today = currentDate;
    final thisWeekMonday = currentWeekMonday;

    final profile = await _isar.userProfiles.get(1) ?? UserProfile();
    final allNutrients = await _isar.nutrientInfos.where().findAll();
    final routineFoods = await _isar.foodSourceItems
        .filter()
        .isVisibleOnAppEqualTo(true)
        .and()
        .isTrackedEqualTo(true)
        .findAll();

    // Ensure all routine foods have their frequency up to date in the DB (respecting locked frequency)
    bool foodsUpdated = false;
    for (final food in routineFoods) {
      if (food.trackingFrequencyOverride != null && food.frequency != food.trackingFrequencyOverride) {
        food.frequency = food.trackingFrequencyOverride!;
        foodsUpdated = true;
      }
    }
    if (foodsUpdated) {
      await _isar.writeTxn(() async {
        await _isar.foodSourceItems.putAll(routineFoods);
      });
    }

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

    record.loggedFoods = List<TrackedFoodEntry>.from(record.loggedFoods);
    bool modified = false;
    final existingMap = {for (var f in record.loggedFoods) f.foodId: f};

    for (final food in routineFoods) {
      final freq = food.frequency;

      // Only daily foods belong as routine entries in TrackRecordDaily.
      // Non-daily foods with recorded consumption (>0g) must be preserved!
      if (freq != TrackingFrequency.daily) {
        if (existingMap.containsKey(food.foodId)) {
          final existing = existingMap[food.foodId]!;
          if (existing.amountConsumedGrams <= 0) {
            record.loggedFoods.removeWhere((f) => f.foodId == food.foodId);
            modified = true;
          }
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
        if (entry.foodTitle != food.title) {
          entry.foodTitle = food.title;
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

    record.loggedFoods = List<TrackedFoodEntry>.from(record.loggedFoods);
    bool modified = false;
    final existingMap = {for (var f in record.loggedFoods) f.foodId: f};

    for (final food in routineFoods) {
      final freq = food.frequency;

      // Only weekly foods require routine entries in TrackRecordWeekly
      if (freq != TrackingFrequency.weekly) {
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
        if (entry.foodTitle != food.title) {
          entry.foodTitle = food.title;
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

    final profile = await _isar.userProfiles.get(1) ?? UserProfile();
    final allNutrients = await _isar.nutrientInfos.where().findAll();

    food.isTracked = true;
    food.frequency = food.calculateFrequency(profile: profile, allNutrients: allNutrients);

    await _isar.writeTxn(() async {
      await _isar.foodSourceItems.put(food);
    });

    await syncTrackRecordsWindow();
  }

  /// Toggles favorite state for a food source
  Future<void> toggleFoodFavorite(String foodId) async {
    final food = await _isar.foodSourceItems.getByFoodId(foodId);
    if (food == null) return;

    food.isFavorite = !food.isFavorite;

    await _isar.writeTxn(() async {
      await _isar.foodSourceItems.put(food);
    });
  }

  /// Loads initial state for HorizonAddSource (all untracked foods + nutrient target maps)
  Future<AddSourceState> loadAddSourceState() async {
    final profile = await _isar.userProfiles.get(1) ?? UserProfile();
    final allNutrients = await _isar.nutrientInfos
        .filter()
        .isVisibleOnAppEqualTo(true)
        .findAll();

    final untrackedFoods = await _isar.foodSourceItems
        .filter()
        .isVisibleOnAppEqualTo(true)
        .and()
        .isTrackedEqualTo(false)
        .findAll();

    final targetMap = {
      for (final n in allNutrients)
        n.nutrientKey: n.calculateEffectiveTarget(profile)
    };
    final nutrientMap = {
      for (final n in allNutrients)
        n.nutrientKey: n
    };

    return AddSourceState(
      foods: untrackedFoods,
      profile: profile,
      allNutrients: allNutrients,
      targetMap: targetMap,
      nutrientMap: nutrientMap,
    );
  }

  /// Reseeds the demo routine and re-syncs all track record windows
  Future<void> reseedDemoRoutine() async {
    await _isarService.seedDemoRoutine();
    await syncTrackRecordsWindow();
  }

  /// Resets all tracking consumption data to 0g across all days and weeks
  Future<void> resetAllTrackingConsumptionData() async {
    final allDailies = await _isar.trackRecordDailys.where().findAll();
    final allWeeklies = await _isar.trackRecordWeeklys.where().findAll();

    await _isar.writeTxn(() async {
      for (final d in allDailies) {
        d.loggedFoods = List<TrackedFoodEntry>.from(d.loggedFoods);
        // Retain only routine foods with 0g consumed
        d.loggedFoods.removeWhere((f) => !f.isFromRoutine);
        for (final f in d.loggedFoods) {
          f.amountConsumedGrams = 0.0;
        }
        await _recalculateDailySummaries(d);
        await _isar.trackRecordDailys.put(d);
      }

      for (final w in allWeeklies) {
        w.loggedFoods = List<TrackedFoodEntry>.from(w.loggedFoods);
        w.loggedFoods.removeWhere((f) => !f.isFromRoutine);
        for (final f in w.loggedFoods) {
          f.amountConsumedGrams = 0.0;
        }
        await _recalculateWeeklySummaries(w);
        await _isar.trackRecordWeeklys.put(w);
      }
    });

    await syncTrackRecordsWindow();
  }

  Future<void> handleRoutineFoodRemoved(String foodId) async {
    final food = await _isar.foodSourceItems.getByFoodId(foodId);
    if (food == null) return;

    final profile = await _isar.userProfiles.get(1) ?? UserProfile();
    final allNutrients = await _isar.nutrientInfos.where().findAll();

    food.isTracked = false;
    food.trackingFrequencyOverride = null; // Automatically reset override back to default math
    food.frequency = food.calculateFrequency(profile: profile, allNutrients: allNutrients); // Reset frequency back to default math

    await _isar.writeTxn(() async {
      await _isar.foodSourceItems.put(food);
    });

    final today = currentDate;

    // Daily Record
    final todayDaily = await _isar.trackRecordDailys.getByDate(today);
    if (todayDaily != null) {
      todayDaily.loggedFoods = List<TrackedFoodEntry>.from(todayDaily.loggedFoods);
      final entryIndex = todayDaily.loggedFoods.indexWhere((f) => f.foodId == foodId);
      if (entryIndex >= 0) {
        if (todayDaily.loggedFoods[entryIndex].amountConsumedGrams <= 0) {
          todayDaily.loggedFoods.removeAt(entryIndex);
        } else {
          todayDaily.loggedFoods[entryIndex].isFromRoutine = false;
        }
        await _recalculateDailySummaries(todayDaily);
        await _isar.writeTxn(() async {
          await _isar.trackRecordDailys.put(todayDaily);
        });
      }
    }

    // Future daily records (clean up unconsumed placeholders)
    final futureDailies = await _isar.trackRecordDailys
        .filter()
        .dateGreaterThan(today)
        .findAll();
    if (futureDailies.isNotEmpty) {
      await _isar.writeTxn(() async {
        for (final r in futureDailies) {
          r.loggedFoods = List<TrackedFoodEntry>.from(r.loggedFoods);
          r.loggedFoods.removeWhere((f) => f.foodId == foodId && f.amountConsumedGrams <= 0);
          for (final f in r.loggedFoods) {
            if (f.foodId == foodId) f.isFromRoutine = false;
          }
          await _recalculateDailySummaries(r);
          await _isar.trackRecordDailys.put(r);
        }
      });
    }

    // Weekly record
    final thisWeekMonday = currentWeekMonday;
    final weekRecord = await _isar.trackRecordWeeklys.getByWeekStartDate(thisWeekMonday);
    if (weekRecord != null) {
      weekRecord.loggedFoods = List<TrackedFoodEntry>.from(weekRecord.loggedFoods);
      final entryIndex = weekRecord.loggedFoods.indexWhere((f) => f.foodId == foodId);
      if (entryIndex >= 0) {
        if (weekRecord.loggedFoods[entryIndex].amountConsumedGrams <= 0) {
          weekRecord.loggedFoods.removeAt(entryIndex);
        } else {
          weekRecord.loggedFoods[entryIndex].isFromRoutine = false;
        }
        await _recalculateWeeklySummaries(weekRecord);
        await _isar.writeTxn(() async {
          await _isar.trackRecordWeeklys.put(weekRecord);
        });
      }
    }

    await syncTrackRecordsWindow();
  }

  /// Updates a food's planned portion/target in routine and re-syncs track records
  Future<void> updateFoodPlannedTarget({
    required String foodId,
    required double newTargetGrams,
  }) async {
    final food = await _isar.foodSourceItems.getByFoodId(foodId);
    if (food == null) return;

    final clampedGrams = newTargetGrams.clamp(1.0, 99999.0);
    food.plannedDailyGrams = clampedGrams;

    // Lock frequency if food is already in routine to prevent accidental section flips while adjusting grams
    if (food.trackingFrequencyOverride != null) {
      food.frequency = food.trackingFrequencyOverride!;
    } else if (!food.isTracked) {
      final profile = await _isar.userProfiles.get(1) ?? UserProfile();
      final allNutrients = await _isar.nutrientInfos.where().findAll();
      food.frequency = food.calculateFrequency(profile: profile, allNutrients: allNutrients);
    }

    await _isar.writeTxn(() async {
      await _isar.foodSourceItems.put(food);
    });

    await syncTrackRecordsWindow();
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
    food.frequency = frequency;
    await _isar.writeTxn(() async {
      await _isar.foodSourceItems.put(food);
    });

    await syncTrackRecordsWindow();
  }

  // --------------------------------------------------------------------------
  // REACTIVE LOGGING & WATCHERS
  // --------------------------------------------------------------------------

  /// Watch stream of UserProfile
  Stream<UserProfile?> watchUserProfile() {
    return _isar.userProfiles
        .watchObject(1, fireImmediately: true);
  }

  /// Watch stream of all NutrientInfo entries
  Stream<List<NutrientInfo>> watchNutrientInfos() {
    return _isar.nutrientInfos
        .where()
        .watch(fireImmediately: true);
  }

  /// Consolidated Routine Page State Model
  Stream<RoutinePageState> watchRoutinePageState() {
    return _isar.foodSourceItems
        .filter()
        .isVisibleOnAppEqualTo(true)
        .and()
        .isTrackedEqualTo(true)
        .watch(fireImmediately: true)
        .asyncMap((routineFoods) async {
      final profile = await _isar.userProfiles.get(1) ?? UserProfile();
      final allNutrients = await _isar.nutrientInfos.where().findAll();

      final targetMap = <String, double>{};
      final nutrientMap = <String, NutrientInfo>{};
      for (final n in allNutrients) {
        nutrientMap[n.nutrientKey] = n;
        targetMap[n.nutrientKey] = n.calculateEffectiveTarget(profile);
      }

      return RoutinePageState(
        profile: profile,
        allNutrients: allNutrients,
        routineFoods: routineFoods,
        targetMap: targetMap,
        nutrientMap: nutrientMap,
      );
    });
  }

  /// Consolidated Track Page State Model
  Stream<TrackPageState> watchTrackPageState() {
    late StreamController<void> controller;
    StreamSubscription? dailySub;
    StreamSubscription? weeklySub;
    VoidCallback? dateListener;

    void updateSubscriptions(DateTime date) {
      dailySub?.cancel();
      weeklySub?.cancel();

      final today = _normalizeDate(date);
      final thisWeekMonday = _normalizeWeekMonday(date);

      dailySub = _isar.trackRecordDailys
          .filter()
          .dateEqualTo(today)
          .watch(fireImmediately: true)
          .listen((_) => controller.add(null));

      weeklySub = _isar.trackRecordWeeklys
          .filter()
          .weekStartDateEqualTo(thisWeekMonday)
          .watch(fireImmediately: true)
          .listen((_) => controller.add(null));
    }

    controller = StreamController<void>(
      onListen: () {
        updateSubscriptions(simulatedDateNotifier.value);
        dateListener = () {
          updateSubscriptions(simulatedDateNotifier.value);
          controller.add(null);
        };
        simulatedDateNotifier.addListener(dateListener!);
      },
      onCancel: () {
        dailySub?.cancel();
        weeklySub?.cancel();
        if (dateListener != null) {
          simulatedDateNotifier.removeListener(dateListener!);
        }
      },
    );

    return controller.stream.asyncMap((_) async {
      final today = currentDate;
      final thisWeekMonday = currentWeekMonday;

      final profile = await _isar.userProfiles.get(1) ?? UserProfile();
      final allNutrients = await _isar.nutrientInfos.where().findAll();

      final routineFoods = await _isar.foodSourceItems
          .filter()
          .isVisibleOnAppEqualTo(true)
          .and()
          .isTrackedEqualTo(true)
          .findAll();

      final dailyRecord = await _isar.trackRecordDailys
          .filter()
          .dateEqualTo(today)
          .findFirst();
      final weeklyRecord = await _isar.trackRecordWeeklys
          .filter()
          .weekStartDateEqualTo(thisWeekMonday)
          .findFirst();

      // Gather all referenced food IDs from routine + daily record + weekly record
      final allReferencedIds = <String>{
        ...routineFoods.map((f) => f.foodId),
        if (dailyRecord != null) ...dailyRecord.loggedFoods.map((f) => f.foodId),
        if (weeklyRecord != null) ...weeklyRecord.loggedFoods.map((f) => f.foodId),
      }.toList();

      final allFoods = await _isar.foodSourceItems
          .filter()
          .anyOf(allReferencedIds, (q, String id) => q.foodIdEqualTo(id))
          .findAll();

      final foodMap = {for (var f in allFoods) f.foodId: f};
      final targetMap = <String, double>{};
      final nutrientMap = <String, NutrientInfo>{};
      for (final n in allNutrients) {
        nutrientMap[n.nutrientKey] = n;
        targetMap[n.nutrientKey] = n.calculateEffectiveTarget(profile);
      }

      return TrackPageState(
        routineFoods: routineFoods,
        foodMap: foodMap,
        dailyRecord: dailyRecord,
        weeklyRecord: weeklyRecord,
        allNutrients: allNutrients,
        targetMap: targetMap,
        nutrientMap: nutrientMap,
      );
    });
  }

  /// Watch stream of all active routine foods (isTracked == true) sorted by title
  Stream<List<FoodSourceItem>> watchTrackedRoutineFoods() {
    return _isar.foodSourceItems
        .filter()
        .isVisibleOnAppEqualTo(true)
        .and()
        .isTrackedEqualTo(true)
        .watch(fireImmediately: true);
  }

  /// Watch stream of total planned routine daily calories and complete protein (proteinIndex == 1)
  Stream<({double calories, double protein})> watchPlannedRoutineEnergyAndProtein() {
    return watchTrackedRoutineFoods().map((routineFoods) {
      double totalEnergy = 0.0;
      double totalCompleteProtein = 0.0;

      for (final food in routineFoods) {
        final portionGrams = food.plannedDailyGrams;

        // Calories from food.energy, or fallback to nutrient 'energy'
        double energyPer100g = food.energy;
        if (energyPer100g <= 0) {
          for (final n in food.nutrients) {
            if (n.nutrientKey == 'energy') {
              energyPer100g = n.amountPer100g;
              break;
            }
          }
        }
        totalEnergy += (portionGrams / 100.0) * energyPer100g;

        // Complete protein from food.nutrients where proteinIndex == 1
        if (food.proteinIndex == 1) {
          for (final n in food.nutrients) {
            if (n.nutrientKey == 'total_protein') {
              totalCompleteProtein += (portionGrams / 100.0) * n.amountPer100g;
              break;
            }
          }
        }
      }

      return (calories: totalEnergy, protein: totalCompleteProtein);
    });
  }

  /// Watch stream for Track Page header: computes live consumed calories & complete protein vs planned routine targets
  Stream<({double consumedCalories, double plannedCalories, double consumedProtein, double plannedProtein})>
      watchTodayTrackHeaderEnergyAndProtein() {
    late StreamController<void> controller;
    StreamSubscription? dailySub;
    VoidCallback? dateListener;

    void updateSub(DateTime date) {
      dailySub?.cancel();
      final today = _normalizeDate(date);
      dailySub = _isar.trackRecordDailys
          .filter()
          .dateEqualTo(today)
          .watch(fireImmediately: true)
          .listen((_) => controller.add(null));
    }

    controller = StreamController<void>(
      onListen: () {
        updateSub(simulatedDateNotifier.value);
        dateListener = () {
          updateSub(simulatedDateNotifier.value);
          controller.add(null);
        };
        simulatedDateNotifier.addListener(dateListener!);
      },
      onCancel: () {
        dailySub?.cancel();
        if (dateListener != null) {
          simulatedDateNotifier.removeListener(dateListener!);
        }
      },
    );

    return controller.stream.asyncMap((_) async {
      final today = currentDate;
      final dailyList = await _isar.trackRecordDailys
          .filter()
          .dateEqualTo(today)
          .findAll();
      final routineFoods = await _isar.foodSourceItems
          .filter()
          .isVisibleOnAppEqualTo(true)
          .and()
          .isTrackedEqualTo(true)
          .findAll();

      final foodMap = {for (var f in routineFoods) f.foodId: f};

      double plannedCal = 0.0;
      double plannedProt = 0.0;
      for (final food in routineFoods) {
        final portionGrams = food.plannedDailyGrams;
        double energyPer100g = food.energy;
        if (energyPer100g <= 0) {
          for (final n in food.nutrients) {
            if (n.nutrientKey == 'energy') {
              energyPer100g = n.amountPer100g;
              break;
            }
          }
        }
        plannedCal += (portionGrams / 100.0) * energyPer100g;

        if (food.proteinIndex == 1) {
          for (final n in food.nutrients) {
            if (n.nutrientKey == 'total_protein') {
              plannedProt += (portionGrams / 100.0) * n.amountPer100g;
              break;
            }
          }
        }
      }

      double consumedCal = 0.0;
      double consumedProt = 0.0;
      if (dailyList.isNotEmpty) {
        final loggedFoodIds = dailyList.first.loggedFoods.map((f) => f.foodId).toList();
        final allLoggedFoods = await _isar.foodSourceItems
            .filter()
            .anyOf(loggedFoodIds, (q, String id) => q.foodIdEqualTo(id))
            .findAll();
        final allFoodMap = {for (var f in allLoggedFoods) f.foodId: f, ...foodMap};

        for (final logged in dailyList.first.loggedFoods) {
          if (logged.amountConsumedGrams <= 0) continue;
          final food = allFoodMap[logged.foodId];
          if (food == null) continue;

          double energyPer100g = food.energy;
          if (energyPer100g <= 0) {
            for (final n in food.nutrients) {
              if (n.nutrientKey == 'energy') {
                energyPer100g = n.amountPer100g;
                break;
              }
            }
          }
          consumedCal += (logged.amountConsumedGrams / 100.0) * energyPer100g;

          if (food.proteinIndex == 1) {
            for (final n in food.nutrients) {
              if (n.nutrientKey == 'total_protein') {
                consumedProt += (logged.amountConsumedGrams / 100.0) * n.amountPer100g;
                break;
              }
            }
          }
        }
      }

      return (
        consumedCalories: consumedCal,
        plannedCalories: plannedCal,
        consumedProtein: consumedProt,
        plannedProtein: plannedProt,
      );
    });
  }

  Stream<TrackRecordDaily?> watchTodayDailyRecord() {
    final today = currentDate;
    return _isar.trackRecordDailys
        .filter()
        .dateEqualTo(today)
        .watch(fireImmediately: true)
        .map((list) => list.isNotEmpty ? list.first : null);
  }

  Stream<TrackRecordWeekly?> watchCurrentWeeklyRecord() {
    final thisWeekMonday = currentWeekMonday;
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
    final targetDate = _normalizeDate(date ?? currentDate);
    final thisWeekMonday = _normalizeWeekMonday(targetDate);

    final dailyRecord = await _isar.trackRecordDailys.getByDate(targetDate) ??
        TrackRecordDaily()
          ..date = targetDate
          ..isSynced = false;

    final weeklyRecord = await _isar.trackRecordWeeklys.getByWeekStartDate(thisWeekMonday) ??
        TrackRecordWeekly()
          ..weekStartDate = thisWeekMonday
          ..weekKey = _formatWeekKey(thisWeekMonday)
          ..isSynced = false;

    dailyRecord.loggedFoods = List<TrackedFoodEntry>.from(dailyRecord.loggedFoods);
    weeklyRecord.loggedFoods = List<TrackedFoodEntry>.from(weeklyRecord.loggedFoods);

    final food = await _isar.foodSourceItems.getByFoodId(foodId);
    if (food == null) return;

    final dailyEntryIndex = dailyRecord.loggedFoods.indexWhere((f) => f.foodId == foodId);
    final consumedAmount = isChecked ? food.plannedDailyGrams : 0.0;

    if (dailyEntryIndex >= 0) {
      dailyRecord.loggedFoods[dailyEntryIndex].amountConsumedGrams = consumedAmount;
      dailyRecord.loggedFoods[dailyEntryIndex].loggedAt = DateTime.now();
    } else {
      dailyRecord.loggedFoods.add(
        TrackedFoodEntry()
          ..foodId = food.foodId
          ..foodTitle = food.title
          ..amountConsumedGrams = consumedAmount
          ..plannedGrams = food.plannedDailyGrams
          ..isFromRoutine = food.isTracked
          ..frequency = food.frequency
          ..loggedAt = DateTime.now(),
      );
    }

    // Synchronize daily checkbox into the weekly record as well
    final weeklyEntryIndex = weeklyRecord.loggedFoods.indexWhere((f) => f.foodId == foodId);
    if (weeklyEntryIndex >= 0) {
      // If food is present in weekly record, update its daily portion contribution
      final currentWeekly = weeklyRecord.loggedFoods[weeklyEntryIndex].amountConsumedGrams;
      final newWeekly = isChecked
          ? (currentWeekly + food.plannedDailyGrams).clamp(0.0, 99999.0)
          : (currentWeekly - food.plannedDailyGrams).clamp(0.0, 99999.0);
      weeklyRecord.loggedFoods[weeklyEntryIndex].amountConsumedGrams = newWeekly;
      weeklyRecord.loggedFoods[weeklyEntryIndex].loggedAt = DateTime.now();
    } else if (isChecked) {
      weeklyRecord.loggedFoods.add(
        TrackedFoodEntry()
          ..foodId = food.foodId
          ..foodTitle = food.title
          ..amountConsumedGrams = food.plannedDailyGrams
          ..plannedGrams = food.plannedWeeklyGrams
          ..isFromRoutine = food.isTracked
          ..frequency = food.frequency
          ..loggedAt = DateTime.now(),
      );
    }

    await _recalculateDailySummaries(dailyRecord);
    await _recalculateWeeklySummaries(weeklyRecord);

    await _isar.writeTxn(() async {
      await _isar.trackRecordDailys.put(dailyRecord);
      await _isar.trackRecordWeeklys.put(weeklyRecord);
    });
  }

  /// Increments or logs intake for a weekly food in the current week, also adding delta to today's daily record
  Future<void> updateWeeklyFoodIntake({
    required String foodId,
    required double deltaGrams,
    DateTime? date,
  }) async {
    final targetDate = _normalizeDate(date ?? currentDate);
    final thisWeekMonday = _normalizeWeekMonday(targetDate);

    final weeklyRecord = await _isar.trackRecordWeeklys.getByWeekStartDate(thisWeekMonday) ??
        TrackRecordWeekly()
          ..weekStartDate = thisWeekMonday
          ..weekKey = _formatWeekKey(thisWeekMonday)
          ..isSynced = false;

    final dailyRecord = await _isar.trackRecordDailys.getByDate(targetDate) ??
        TrackRecordDaily()
          ..date = targetDate
          ..isSynced = false;

    weeklyRecord.loggedFoods = List<TrackedFoodEntry>.from(weeklyRecord.loggedFoods);
    dailyRecord.loggedFoods = List<TrackedFoodEntry>.from(dailyRecord.loggedFoods);

    final food = await _isar.foodSourceItems.getByFoodId(foodId);
    if (food == null) return;

    // 1. Update Weekly Record
    final weeklyEntryIndex = weeklyRecord.loggedFoods.indexWhere((f) => f.foodId == foodId);
    if (weeklyEntryIndex >= 0) {
      final current = weeklyRecord.loggedFoods[weeklyEntryIndex].amountConsumedGrams;
      final updated = (current + deltaGrams).clamp(0.0, 99999.0);
      weeklyRecord.loggedFoods[weeklyEntryIndex].amountConsumedGrams = updated;
      weeklyRecord.loggedFoods[weeklyEntryIndex].loggedAt = DateTime.now();
    } else {
      weeklyRecord.loggedFoods.add(
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

    // 2. Also log the consumed delta in today's Daily Record
    final dailyEntryIndex = dailyRecord.loggedFoods.indexWhere((f) => f.foodId == foodId);
    if (dailyEntryIndex >= 0) {
      final currentDaily = dailyRecord.loggedFoods[dailyEntryIndex].amountConsumedGrams;
      final updatedDaily = (currentDaily + deltaGrams).clamp(0.0, 99999.0);
      dailyRecord.loggedFoods[dailyEntryIndex].amountConsumedGrams = updatedDaily;
      dailyRecord.loggedFoods[dailyEntryIndex].loggedAt = DateTime.now();
    } else if (deltaGrams > 0) {
      dailyRecord.loggedFoods.add(
        TrackedFoodEntry()
          ..foodId = food.foodId
          ..foodTitle = food.title
          ..amountConsumedGrams = deltaGrams.clamp(0.0, 99999.0)
          ..plannedGrams = food.plannedDailyGrams
          ..isFromRoutine = food.isTracked
          ..frequency = food.frequency
          ..loggedAt = DateTime.now(),
      );
    }

    await _recalculateWeeklySummaries(weeklyRecord);
    await _recalculateDailySummaries(dailyRecord);

    await _isar.writeTxn(() async {
      await _isar.trackRecordWeeklys.put(weeklyRecord);
      await _isar.trackRecordDailys.put(dailyRecord);
    });
  }

  /// Adds a food source directly to today's consumption without adding it to routine
  Future<void> addFoodToDay({
    required String foodId,
    double? grams,
    DateTime? date,
  }) async {
    final targetDate = _normalizeDate(date ?? currentDate);
    final thisWeekMonday = _normalizeWeekMonday(targetDate);

    final dailyRecord = await _isar.trackRecordDailys.getByDate(targetDate) ??
        TrackRecordDaily()
          ..date = targetDate
          ..isSynced = false;

    final weeklyRecord = await _isar.trackRecordWeeklys.getByWeekStartDate(thisWeekMonday) ??
        TrackRecordWeekly()
          ..weekStartDate = thisWeekMonday
          ..weekKey = _formatWeekKey(thisWeekMonday)
          ..isSynced = false;

    dailyRecord.loggedFoods = List<TrackedFoodEntry>.from(dailyRecord.loggedFoods);
    weeklyRecord.loggedFoods = List<TrackedFoodEntry>.from(weeklyRecord.loggedFoods);

    final food = await _isar.foodSourceItems.getByFoodId(foodId);
    if (food == null) return;

    final portion = grams ?? (food.defaultPortionGrams > 0 ? food.defaultPortionGrams : 100.0);

    final dailyEntryIndex = dailyRecord.loggedFoods.indexWhere((f) => f.foodId == foodId);
    if (dailyEntryIndex >= 0) {
      dailyRecord.loggedFoods[dailyEntryIndex].amountConsumedGrams += portion;
      dailyRecord.loggedFoods[dailyEntryIndex].plannedGrams = portion;
      dailyRecord.loggedFoods[dailyEntryIndex].loggedAt = DateTime.now();
    } else {
      dailyRecord.loggedFoods.add(
        TrackedFoodEntry()
          ..foodId = food.foodId
          ..foodTitle = food.title
          ..amountConsumedGrams = portion
          ..plannedGrams = portion
          ..isFromRoutine = false
          ..frequency = TrackingFrequency.daily
          ..loggedAt = DateTime.now(),
      );
    }

    final weeklyEntryIndex = weeklyRecord.loggedFoods.indexWhere((f) => f.foodId == foodId);
    if (weeklyEntryIndex >= 0) {
      weeklyRecord.loggedFoods[weeklyEntryIndex].amountConsumedGrams += portion;
      weeklyRecord.loggedFoods[weeklyEntryIndex].plannedGrams = portion;
      weeklyRecord.loggedFoods[weeklyEntryIndex].loggedAt = DateTime.now();
    } else {
      weeklyRecord.loggedFoods.add(
        TrackedFoodEntry()
          ..foodId = food.foodId
          ..foodTitle = food.title
          ..amountConsumedGrams = portion
          ..plannedGrams = portion
          ..isFromRoutine = false
          ..frequency = TrackingFrequency.daily
          ..loggedAt = DateTime.now(),
      );
    }

    await _recalculateWeeklySummaries(weeklyRecord);
    await _recalculateDailySummaries(dailyRecord);

    await _isar.writeTxn(() async {
      await _isar.trackRecordWeeklys.put(weeklyRecord);
      await _isar.trackRecordDailys.put(dailyRecord);
    });
  }

  /// Sets the exact amountConsumed for a food on a specific day without modifying routine planned targets
  Future<void> setDailyFoodConsumedGrams({
    required String foodId,
    required double consumedGrams,
    DateTime? date,
  }) async {
    final targetDate = _normalizeDate(date ?? currentDate);
    final thisWeekMonday = _normalizeWeekMonday(targetDate);

    final dailyRecord = await _isar.trackRecordDailys.getByDate(targetDate) ??
        TrackRecordDaily()
          ..date = targetDate
          ..isSynced = false;

    final weeklyRecord = await _isar.trackRecordWeeklys.getByWeekStartDate(thisWeekMonday) ??
        TrackRecordWeekly()
          ..weekStartDate = thisWeekMonday
          ..weekKey = _formatWeekKey(thisWeekMonday)
          ..isSynced = false;

    dailyRecord.loggedFoods = List<TrackedFoodEntry>.from(dailyRecord.loggedFoods);
    weeklyRecord.loggedFoods = List<TrackedFoodEntry>.from(weeklyRecord.loggedFoods);

    final food = await _isar.foodSourceItems.getByFoodId(foodId);
    if (food == null) return;

    final grams = consumedGrams.clamp(0.0, 99999.0);

    // 1. Update Daily Record
    final dailyEntryIndex = dailyRecord.loggedFoods.indexWhere((f) => f.foodId == foodId);
    double oldDailyConsumed = 0.0;
    if (dailyEntryIndex >= 0) {
      oldDailyConsumed = dailyRecord.loggedFoods[dailyEntryIndex].amountConsumedGrams;
      dailyRecord.loggedFoods[dailyEntryIndex].amountConsumedGrams = grams;
      dailyRecord.loggedFoods[dailyEntryIndex].loggedAt = DateTime.now();
    } else {
      dailyRecord.loggedFoods.add(
        TrackedFoodEntry()
          ..foodId = food.foodId
          ..foodTitle = food.title
          ..amountConsumedGrams = grams
          ..plannedGrams = food.plannedDailyGrams
          ..isFromRoutine = food.isTracked
          ..frequency = food.frequency
          ..loggedAt = DateTime.now(),
      );
    }

    // 2. Synchronize delta into Weekly Record
    final delta = grams - oldDailyConsumed;
    final weeklyEntryIndex = weeklyRecord.loggedFoods.indexWhere((f) => f.foodId == foodId);
    if (weeklyEntryIndex >= 0) {
      final currentWeekly = weeklyRecord.loggedFoods[weeklyEntryIndex].amountConsumedGrams;
      weeklyRecord.loggedFoods[weeklyEntryIndex].amountConsumedGrams =
          (currentWeekly + delta).clamp(0.0, 99999.0);
      weeklyRecord.loggedFoods[weeklyEntryIndex].loggedAt = DateTime.now();
    } else if (grams > 0) {
      weeklyRecord.loggedFoods.add(
        TrackedFoodEntry()
          ..foodId = food.foodId
          ..foodTitle = food.title
          ..amountConsumedGrams = grams
          ..plannedGrams = food.plannedWeeklyGrams
          ..isFromRoutine = food.isTracked
          ..frequency = food.frequency
          ..loggedAt = DateTime.now(),
      );
    }

    await _recalculateDailySummaries(dailyRecord);
    await _recalculateWeeklySummaries(weeklyRecord);

    await _isar.writeTxn(() async {
      await _isar.trackRecordWeeklys.put(weeklyRecord);
      await _isar.trackRecordDailys.put(dailyRecord);
    });
  }

  /// Consolidated NutrientMap State Model stream
  Stream<NutrientMapState> watchNutrientMapState(bool isTrackView) {
    if (isTrackView) {
      late StreamController<void> controller;
      StreamSubscription? dailySub;
      StreamSubscription? weeklySub;
      VoidCallback? dateListener;

      void updateSubscriptions(DateTime date) {
        dailySub?.cancel();
        weeklySub?.cancel();

        final today = _normalizeDate(date);
        final thisWeekMonday = _normalizeWeekMonday(date);

        dailySub = _isar.trackRecordDailys
            .filter()
            .dateEqualTo(today)
            .watch(fireImmediately: true)
            .listen((_) => controller.add(null));

        weeklySub = _isar.trackRecordWeeklys
            .filter()
            .weekStartDateEqualTo(thisWeekMonday)
            .watch(fireImmediately: true)
            .listen((_) => controller.add(null));
      }

      controller = StreamController<void>(
        onListen: () {
          updateSubscriptions(simulatedDateNotifier.value);
          dateListener = () {
            updateSubscriptions(simulatedDateNotifier.value);
            controller.add(null);
          };
          simulatedDateNotifier.addListener(dateListener!);
        },
        onCancel: () {
          dailySub?.cancel();
          weeklySub?.cancel();
          if (dateListener != null) {
            simulatedDateNotifier.removeListener(dateListener!);
          }
        },
      );

      return controller.stream.asyncMap((_) async {
        final today = currentDate;
        final thisWeekMonday = currentWeekMonday;

        final nutrients = await _isar.nutrientInfos
            .filter()
            .isVisibleOnAppEqualTo(true)
            .and()
            .isTrackedEqualTo(true)
            .findAll();

        final dailyRecord = await _isar.trackRecordDailys
            .filter()
            .dateEqualTo(today)
            .findFirst();

        final weeklyRecord = await _isar.trackRecordWeeklys
            .filter()
            .weekStartDateEqualTo(thisWeekMonday)
            .findFirst();

        final Map<String, double> dailySummariesMap = {};
        if (dailyRecord != null) {
          for (final s in dailyRecord.nutrientSummaries) {
            dailySummariesMap[s.nutrientKey] = s.percentageMet;
          }
        }

        final Map<String, double> weeklySummariesMap = {};
        if (weeklyRecord != null) {
          for (final s in weeklyRecord.nutrientSummaries) {
            weeklySummariesMap[s.nutrientKey] = s.percentageMet;
          }
        }

        final Map<String, double> coverageResults = {};
        for (final nutrient in nutrients) {
          if (nutrient.frequency == TrackingFrequency.daily) {
            // Daily Pill: direct percentage met from today's daily record
            coverageResults[nutrient.nutrientKey] = dailySummariesMap[nutrient.nutrientKey] ?? 0.0;
          } else {
            // Weekly Pill: direct percentage met from this week's cumulative record
            coverageResults[nutrient.nutrientKey] = weeklySummariesMap[nutrient.nutrientKey] ?? 0.0;
          }
        }

        return NutrientMapState(
          nutrients: nutrients,
          coverageMap: coverageResults,
        );
      });
    } else {
      return watchTrackedRoutineFoods().asyncMap((routineFoods) async {
        final profile = await _isar.userProfiles.get(1) ?? UserProfile();
        final nutrients = await _isar.nutrientInfos
            .filter()
            .isVisibleOnAppEqualTo(true)
            .and()
            .isTrackedEqualTo(true)
            .findAll();

        final Map<String, double> plannedTotals = {};
        for (final food in routineFoods) {
          final portionGrams = food.plannedDailyGrams;
          for (final nutrient in food.nutrients) {
            if (nutrient.nutrientKey == 'total_protein' && food.proteinIndex != 1) continue;
            final contribution = (portionGrams / 100.0) * nutrient.amountPer100g;
            plannedTotals[nutrient.nutrientKey] =
                (plannedTotals[nutrient.nutrientKey] ?? 0.0) + contribution;
          }
        }

        final Map<String, double> coverageResults = {};
        for (final nutrient in nutrients) {
          final target = nutrient.calculateEffectiveTarget(profile);
          final dailyConsumed = plannedTotals[nutrient.nutrientKey] ?? 0.0;
          final plannedYield = nutrient.frequency == TrackingFrequency.weekly
              ? dailyConsumed * 7.0
              : dailyConsumed;
          final percent = target > 0 ? (plannedYield / target) * 100.0 : 0.0;
          coverageResults[nutrient.nutrientKey] = percent;
        }

        return NutrientMapState(
          nutrients: nutrients,
          coverageMap: coverageResults,
        );
      });
    }
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
        if (nutrient.nutrientKey == 'total_protein' && food.proteinIndex != 1) continue;
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
        if (nutrient.nutrientKey == 'total_protein' && food.proteinIndex != 1) continue;
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
}

/// Consolidated state model for RoutinePage
class RoutinePageState {
  final UserProfile profile;
  final List<NutrientInfo> allNutrients;
  final List<FoodSourceItem> routineFoods;
  final Map<String, double> targetMap;
  final Map<String, NutrientInfo> nutrientMap;

  const RoutinePageState({
    required this.profile,
    required this.allNutrients,
    required this.routineFoods,
    required this.targetMap,
    required this.nutrientMap,
  });
}

/// Consolidated state model for TrackPage
class TrackPageState {
  final List<FoodSourceItem> routineFoods;
  final Map<String, FoodSourceItem> foodMap;
  final TrackRecordDaily? dailyRecord;
  final TrackRecordWeekly? weeklyRecord;
  final List<NutrientInfo> allNutrients;
  final Map<String, double> targetMap;
  final Map<String, NutrientInfo> nutrientMap;

  const TrackPageState({
    required this.routineFoods,
    required this.foodMap,
    this.dailyRecord,
    this.weeklyRecord,
    required this.allNutrients,
    required this.targetMap,
    required this.nutrientMap,
  });
}

/// Consolidated state model for NutrientMap
class NutrientMapState {
  final List<NutrientInfo> nutrients;
  final Map<String, double> coverageMap;

  const NutrientMapState({
    required this.nutrients,
    required this.coverageMap,
  });
}

/// Consolidated state model for HorizonAddSource
class AddSourceState {
  final List<FoodSourceItem> foods;
  final UserProfile profile;
  final List<NutrientInfo> allNutrients;
  final Map<String, double> targetMap;
  final Map<String, NutrientInfo> nutrientMap;

  const AddSourceState({
    required this.foods,
    required this.profile,
    required this.allNutrients,
    required this.targetMap,
    required this.nutrientMap,
  });
}
