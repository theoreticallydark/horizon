import 'package:isar/isar.dart';
import 'package:horizon/data/models/daily_record.dart';
import 'package:horizon/data/models/food_source_item.dart';
import 'package:horizon/data/models/nutrient_info.dart';
import 'package:horizon/data/models/user_profile.dart';
import 'package:horizon/data/services/isar_service.dart';

class NutritionTrackingService {
  final IsarService _isarService;

  NutritionTrackingService({IsarService? isarService})
      : _isarService = isarService ?? IsarService.instance;

  Isar get _isar => _isarService.isar;

  DateTime _normalizeDate(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  // --------------------------------------------------------------------------
  // ROUTINE COVERAGE CALCULATION
  // --------------------------------------------------------------------------

  /// Computes the planned coverage of the user's active routine against their targets.
  /// Returns a map of nutrientKey -> percentageMet (e.g., {'vitamin_c': 110.5, 'total_protein': 95.0})
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

    // Map to accumulate planned totals: nutrientKey -> plannedConsumed
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
      final target = nutrient.calculateEffectiveTarget(profile.strictness);
      final consumed = plannedTotals[nutrient.nutrientKey] ?? 0.0;
      final percent = target > 0 ? (consumed / target) * 100.0 : 0.0;
      coverageResults[nutrient.nutrientKey] = percent;
    }

    return coverageResults;
  }

  /// Watch stream of routine coverage map whenever tracked foods or nutrients change
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
  // DAILY LOGGING & AGGREGATION
  // --------------------------------------------------------------------------

  /// Logs or updates food consumption for a specific date and recalculates daily totals.
  Future<DailyRecord> logFoodIntake({
    required DateTime date,
    required String foodId,
    required double amountConsumedGrams,
  }) async {
    final normalized = _normalizeDate(date);

    return await _isar.writeTxn(() async {
      var record = await _isar.dailyRecords.getByDate(normalized);
      if (record == null) {
        record = DailyRecord()
          ..date = normalized
          ..isSynced = false;
      }

      final food = await _isar.foodSourceItems.getByFoodId(foodId);
      if (food == null) {
        throw ArgumentError('Food with ID $foodId not found.');
      }

      // Update or add the food entry in daily record
      final existingIndex =
          record.loggedFoods.indexWhere((e) => e.foodId == foodId);
      if (existingIndex >= 0) {
        record.loggedFoods[existingIndex].amountConsumedGrams =
            amountConsumedGrams;
        record.loggedFoods[existingIndex].loggedAt = DateTime.now();
      } else {
        record.loggedFoods.add(
          DailyFoodLogEntry()
            ..foodId = food.foodId
            ..foodTitle = food.title
            ..amountConsumedGrams = amountConsumedGrams
            ..plannedGrams = food.plannedDailyGrams
            ..isFromRoutine = food.isTracked
            ..loggedAt = DateTime.now(),
        );
      }

      // Recalculate daily nutrient summaries
      await _recalculateDailySummaries(record);

      await _isar.dailyRecords.put(record);
      return record;
    });
  }

  /// Recalculates nutrient amounts for a given daily record using the formula:
  /// amountConsumed = sum( (foodAmount / 100.0) * nutrientAmountPer100g )
  Future<void> _recalculateDailySummaries(DailyRecord record) async {
    final profile = await _isar.userProfiles.get(1) ?? UserProfile();
    final allNutrients = await _isar.nutrientInfos.where().findAll();

    // Map foodId to FoodSourceItem
    final foodIds = record.loggedFoods.map((f) => f.foodId).toList();
    final foods = await _isar.foodSourceItems
        .filter()
        .anyOf(foodIds, (q, String id) => q.foodIdEqualTo(id))
        .findAll();

    final foodMap = {for (var f in foods) f.foodId: f};

    // Calculate aggregated nutrient sums
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

    // Build summaries list
    final List<DailyNutrientSummary> summaries = [];
    for (final nutrient in allNutrients) {
      final target = nutrient.calculateEffectiveTarget(profile.strictness);
      final consumed = aggregatedNutrients[nutrient.nutrientKey] ?? 0.0;
      final percent = target > 0 ? (consumed / target) * 100.0 : 0.0;

      summaries.add(
        DailyNutrientSummary()
          ..nutrientKey = nutrient.nutrientKey
          ..amountConsumed = consumed
          ..targetAmount = target
          ..percentageMet = percent,
      );
    }

    record.nutrientSummaries = summaries;

    // Calculate routine adherence
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
