import 'dart:async';
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

    // Ensure all routine foods have their frequency up to date in the DB
    bool foodsUpdated = false;
    for (final food in routineFoods) {
      final computedFreq = food.calculateFrequency(profile: profile, allNutrients: allNutrients);
      if (food.frequency != computedFreq) {
        food.frequency = computedFreq;
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

  /// Updates a food's planned portion/target in routine and re-syncs track records
  Future<void> updateFoodPlannedTarget({
    required String foodId,
    required double newTargetGrams,
  }) async {
    final food = await _isar.foodSourceItems.getByFoodId(foodId);
    if (food == null) return;

    final clampedGrams = newTargetGrams.clamp(1.0, 99999.0);
    food.plannedDailyGrams = clampedGrams;

    final profile = await _isar.userProfiles.get(1) ?? UserProfile();
    final allNutrients = await _isar.nutrientInfos.where().findAll();
    food.frequency = food.calculateFrequency(profile: profile, allNutrients: allNutrients);

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

      // Pre-compute effective targets for fast O(1) in-memory lookup
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
    final today = _normalizeDate(DateTime.now());
    final thisWeekMonday = _normalizeWeekMonday(today);

    // Watch both daily and weekly records simultaneously so checkboxes & steppers react immediately
    final dailyStream = _isar.trackRecordDailys
        .filter()
        .dateEqualTo(today)
        .watch(fireImmediately: true);

    final weeklyStream = _isar.trackRecordWeeklys
        .filter()
        .weekStartDateEqualTo(thisWeekMonday)
        .watch(fireImmediately: true);

    late StreamController<void> controller;
    StreamSubscription? dailySub;
    StreamSubscription? weeklySub;

    controller = StreamController<void>(
      onListen: () {
        dailySub = dailyStream.listen((_) => controller.add(null));
        weeklySub = weeklyStream.listen((_) => controller.add(null));
      },
      onCancel: () {
        dailySub?.cancel();
        weeklySub?.cancel();
      },
    );

    return controller.stream.asyncMap((_) async {
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

      final foodMap = {for (var f in routineFoods) f.foodId: f};
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
          final energyNutr = food.nutrients.where((n) => n.nutrientKey == 'energy').firstOrNull;
          energyPer100g = energyNutr?.amountPer100g ?? 0.0;
        }
        totalEnergy += (portionGrams / 100.0) * energyPer100g;

        // Complete protein from food.nutrients where proteinIndex == 1
        if (food.proteinIndex == 1) {
          final proteinNutrient = food.nutrients
              .where((n) => n.nutrientKey == 'total_protein')
              .firstOrNull;
          if (proteinNutrient != null) {
            totalCompleteProtein += (portionGrams / 100.0) * proteinNutrient.amountPer100g;
          }
        }
      }

      return (calories: totalEnergy, protein: totalCompleteProtein);
    });
  }

  /// Watch stream for Track Page header: computes live consumed calories & complete protein vs planned routine targets
  Stream<({double consumedCalories, double plannedCalories, double consumedProtein, double plannedProtein})>
      watchTodayTrackHeaderEnergyAndProtein() {
    final today = _normalizeDate(DateTime.now());

    return _isar.trackRecordDailys
        .filter()
        .dateEqualTo(today)
        .watch(fireImmediately: true)
        .asyncMap((dailyList) async {
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
          final energyNutr = food.nutrients.where((n) => n.nutrientKey == 'energy').firstOrNull;
          energyPer100g = energyNutr?.amountPer100g ?? 0.0;
        }
        plannedCal += (portionGrams / 100.0) * energyPer100g;

        if (food.proteinIndex == 1) {
          final proteinNutrient = food.nutrients
              .where((n) => n.nutrientKey == 'total_protein')
              .firstOrNull;
          if (proteinNutrient != null) {
            plannedProt += (portionGrams / 100.0) * proteinNutrient.amountPer100g;
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
            final energyNutr = food.nutrients.where((n) => n.nutrientKey == 'energy').firstOrNull;
            energyPer100g = energyNutr?.amountPer100g ?? 0.0;
          }
          consumedCal += (logged.amountConsumedGrams / 100.0) * energyPer100g;

          if (food.proteinIndex == 1) {
            final proteinNutrient = food.nutrients
                .where((n) => n.nutrientKey == 'total_protein')
                .firstOrNull;
            if (proteinNutrient != null) {
              consumedProt += (logged.amountConsumedGrams / 100.0) * proteinNutrient.amountPer100g;
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
      // If food is tracked in weekly record, update its daily portion contribution
      final currentWeekly = weeklyRecord.loggedFoods[weeklyEntryIndex].amountConsumedGrams;
      final newWeekly = isChecked
          ? (currentWeekly + food.plannedDailyGrams).clamp(0.0, 99999.0)
          : (currentWeekly - food.plannedDailyGrams).clamp(0.0, 99999.0);
      weeklyRecord.loggedFoods[weeklyEntryIndex].amountConsumedGrams = newWeekly;
      weeklyRecord.loggedFoods[weeklyEntryIndex].loggedAt = DateTime.now();
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
    final targetDate = _normalizeDate(date ?? DateTime.now());
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

  /// Consolidated NutrientMap State Model stream
  Stream<NutrientMapState> watchNutrientMapState(bool isTrackView) {
    if (isTrackView) {
      final today = _normalizeDate(DateTime.now());
      final thisWeekMonday = _normalizeWeekMonday(today);

      // Watch both daily and weekly records simultaneously
      final dailyStream = _isar.trackRecordDailys
          .filter()
          .dateEqualTo(today)
          .watch(fireImmediately: true);

      final weeklyStream = _isar.trackRecordWeeklys
          .filter()
          .weekStartDateEqualTo(thisWeekMonday)
          .watch(fireImmediately: true);

      late StreamController<void> controller;
      StreamSubscription? dailySub;
      StreamSubscription? weeklySub;

      controller = StreamController<void>(
        onListen: () {
          dailySub = dailyStream.listen((_) => controller.add(null));
          weeklySub = weeklyStream.listen((_) => controller.add(null));
        },
        onCancel: () {
          dailySub?.cancel();
          weeklySub?.cancel();
        },
      );

      return controller.stream.asyncMap((_) async {
        final profile = await _isar.userProfiles.get(1) ?? UserProfile();
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

        // Collect all consumed foods from both daily record and weekly record
        final foodIds = <String>{};
        if (dailyRecord != null) {
          foodIds.addAll(dailyRecord.loggedFoods.map((f) => f.foodId));
        }
        if (weeklyRecord != null) {
          foodIds.addAll(weeklyRecord.loggedFoods.map((f) => f.foodId));
        }

        final foods = foodIds.isNotEmpty
            ? await _isar.foodSourceItems
                .filter()
                .anyOf(foodIds.toList(), (q, String id) => q.foodIdEqualTo(id))
                .findAll()
            : <FoodSourceItem>[];
        final foodMap = {for (var f in foods) f.foodId: f};

        final Map<String, double> dailyConsumedTotals = {};
        final Map<String, double> weeklyConsumedTotals = {};

        if (dailyRecord != null) {
          for (final logged in dailyRecord.loggedFoods) {
            if (logged.amountConsumedGrams <= 0) continue;
            final food = foodMap[logged.foodId];
            if (food == null) continue;
            for (final nutrient in food.nutrients) {
              if (nutrient.nutrientKey == 'total_protein' && food.proteinIndex != 1) continue;
              final consumed = (logged.amountConsumedGrams / 100.0) * nutrient.amountPer100g;
              dailyConsumedTotals[nutrient.nutrientKey] =
                  (dailyConsumedTotals[nutrient.nutrientKey] ?? 0.0) + consumed;
            }
          }
        }

        if (weeklyRecord != null) {
          for (final logged in weeklyRecord.loggedFoods) {
            if (logged.amountConsumedGrams <= 0) continue;
            final food = foodMap[logged.foodId];
            if (food == null) continue;
            for (final nutrient in food.nutrients) {
              if (nutrient.nutrientKey == 'total_protein' && food.proteinIndex != 1) continue;
              final consumed = (logged.amountConsumedGrams / 100.0) * nutrient.amountPer100g;
              weeklyConsumedTotals[nutrient.nutrientKey] =
                  (weeklyConsumedTotals[nutrient.nutrientKey] ?? 0.0) + consumed;
            }
          }
        }

        final Map<String, double> coverageResults = {};
        for (final nutrient in nutrients) {
          final target = nutrient.calculateEffectiveTarget(profile);
          if (target <= 0) {
            coverageResults[nutrient.nutrientKey] = 0.0;
            continue;
          }

          if (nutrient.frequency == TrackingFrequency.weekly) {
            // Weekly nutrient: daily logged foods contribute (dailyConsumed * 7) towards weekly target,
            // plus any actual weekly goal foods consumed this week.
            final dailyContribution = (dailyConsumedTotals[nutrient.nutrientKey] ?? 0.0) * 7.0;
            final weeklyContribution = weeklyConsumedTotals[nutrient.nutrientKey] ?? 0.0;
            final totalWeeklyYield = dailyContribution + weeklyContribution;
            coverageResults[nutrient.nutrientKey] = (totalWeeklyYield / target) * 100.0;
          } else {
            // Daily nutrient: daily consumed towards daily target
            final dailyConsumed = dailyConsumedTotals[nutrient.nutrientKey] ?? 0.0;
            coverageResults[nutrient.nutrientKey] = (dailyConsumed / target) * 100.0;
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
