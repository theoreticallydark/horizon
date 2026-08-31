import 'package:isar/isar.dart';
import 'package:horizon/data/models/nutrient_info.dart';
import 'package:horizon/data/models/user_profile.dart';

part 'food_source_item.g.dart';

@collection
class FoodSourceItem {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String foodId; // e.g. "fdc_167927"

  @Index(type: IndexType.value, caseSensitive: false)
  late String name;

  @Index(type: IndexType.value, caseSensitive: false)
  late String title;

  @Index()
  late String category;

  String? foodState;

  @Index()
  bool isVisibleOnApp = true;

  /// Routine indicator: True if this food is currently part of the user's daily/weekly routine
  @Index()
  bool isTracked = false; // Constraint: Must be false if isVisibleOnApp == false

  /// Tracking frequency: Evaluated dynamically based on the 10% trigger nutrient coverage rule,
  /// or set by user manual override when isTracked = true.
  @Index()
  @Enumerated(EnumType.name)
  TrackingFrequency frequency = TrackingFrequency.daily;

  /// User manual override for tracking frequency (daily or weekly).
  /// Null indicates that default math-derived frequency should be used.
  /// Automatically reset to null when isTracked is set to false.
  @Enumerated(EnumType.name)
  TrackingFrequency? trackingFrequencyOverride;

  @Index()
  bool isFavorite = false;

  // Portion configuration
  String? defaultPortionLabel; // e.g. "1 piece", "1 cup"
  double defaultPortionGrams = 100.0;

  /// Planned Daily Grams in Routine (defaults to defaultPortionGrams when isTracked is toggled on)
  double plannedDailyGrams = 100.0;

  /// Planned Weekly target (daily target * 7)
  double get plannedWeeklyGrams => plannedDailyGrams * 7.0;

  /// Dynamic step grams for incrementing/decrementing portions:
  /// - defaultPortionGrams < 30g -> 5g
  /// - 30g <= defaultPortionGrams <= 100g -> 10g
  /// - defaultPortionGrams > 100g -> 25g
  double get stepGrams {
    if (defaultPortionGrams < 30.0) {
      return 5.0;
    } else if (defaultPortionGrams <= 100.0) {
      return 10.0;
    } else {
      return 25.0;
    }
  }

  /// Clean, user-friendly initial portion snapped to the food's step size:
  /// - <30g -> rounded to nearest 5g (e.g. 14g -> 15g, 28g -> 30g)
  /// - 30-100g -> rounded to nearest 10g (e.g. 52g -> 50g)
  /// - >100g -> rounded to nearest 25g (e.g. 246g -> 250g)
  double get snappedPortionGrams {
    if (defaultPortionGrams <= 0) return 100.0;
    final step = stepGrams;
    final snapped = (defaultPortionGrams / step).round() * step;
    return snapped < step ? step : snapped;
  }

  /// Energy in kcal per 100g edible portion
  double energy = 0.0;

  /// Binary complete protein index (1 = complete/high-quality protein source, 0 = other)
  int proteinIndex = 0;

  /// Nutrients per 100g of edible portion
  List<FoodNutrientValue> nutrients = [];

  /// 8 Trigger Nutrients for the 10% Coverage Qualification Rule
  static const Set<String> triggerNutrientKeys = {
    'vitamin_c', // Vit C
    'collagen', // Coll.
    'total_fiber', // Fiber
    'magnesium', // Mg
    'calcium', // Ca
    'potassium', // K
    'creatine', // Creat.
    'total_protein', // Protein
  };

  /// Computes the mathematical tracking frequency based on the 10% trigger nutrient coverage rule
  TrackingFrequency calculateFrequency({
    required UserProfile profile,
    required List<NutrientInfo> allNutrients,
  }) {
    if (isTracked && trackingFrequencyOverride != null) {
      return trackingFrequencyOverride!;
    }

    final nutrientMap = {for (var n in allNutrients) n.nutrientKey: n};

    for (final nutrientVal in nutrients) {
      if (!triggerNutrientKeys.contains(nutrientVal.nutrientKey)) continue;

      // Protein qualification requires food to be a complete protein source (proteinIndex == 1)
      if (nutrientVal.nutrientKey == 'total_protein' && proteinIndex != 1) continue;

      final nutrientInfo = nutrientMap[nutrientVal.nutrientKey];
      if (nutrientInfo == null) continue;

      final target = nutrientInfo.calculateEffectiveTarget(profile);
      if (target <= 0) continue;

      final yieldAmount = (plannedDailyGrams / 100.0) * nutrientVal.amountPer100g;
      final coveragePercent = (yieldAmount / target) * 100.0;

      if (coveragePercent > 10.0) {
        return TrackingFrequency.daily;
      }
    }

    return TrackingFrequency.weekly;
  }

  /// Checks whether this food item provides non-zero coverage for the selected nutrient
  bool providesNutrient(String? nutrientKey) {
    if (nutrientKey == null) return true;
    return nutrients.any((n) =>
        n.amountPer100g > 0 &&
        (n.nutrientKey != 'total_protein' || proteinIndex == 1) &&
        n.nutrientKey == nutrientKey);
  }

  /// Calculates nutrient contributions (% coverage of targets) for this food item.
  /// Ignores energy, ignores un-tracked nutrients, and requires complete protein (proteinIndex == 1).
  List<({NutrientInfo info, double coveragePercent, bool isDaily})> calculateNutrientContributions({
    required double portionGrams,
    required Map<String, double> targetMap,
    required Map<String, NutrientInfo> nutrientMap,
    double minCoveragePercent = 0.0,
  }) {
    final List<({NutrientInfo info, double coveragePercent, bool isDaily})> results = [];

    for (final nutrientVal in nutrients) {
      if (nutrientVal.nutrientKey == 'energy') continue;
      if (nutrientVal.nutrientKey == 'total_protein' && proteinIndex != 1) continue;

      final nutrientInfo = nutrientMap[nutrientVal.nutrientKey];
      if (nutrientInfo == null || !nutrientInfo.isTracked) continue;

      final target = targetMap[nutrientVal.nutrientKey] ?? 0.0;
      if (target <= 0) continue;

      final yieldAmount = (portionGrams / 100.0) * nutrientVal.amountPer100g;
      final isWeeklyNutrient = nutrientInfo.frequency == TrackingFrequency.weekly;
      final isDailyRoutineFood = isTracked && frequency == TrackingFrequency.daily;

      // For daily nutrients: compares single portion yield against daily target.
      // For weekly nutrients: if the food is part of daily routine, 7 daily portions are projected;
      // otherwise, this single portion's contribution against the weekly target is calculated.
      final effectiveYield = (isWeeklyNutrient && isDailyRoutineFood)
          ? yieldAmount * 7.0
          : (isWeeklyNutrient && !isTracked ? yieldAmount * 7.0 : yieldAmount);

      final coveragePercent = (effectiveYield / target) * 100.0;

      if (coveragePercent >= minCoveragePercent && coveragePercent > 0.0) {
        results.add((
          info: nutrientInfo,
          coveragePercent: coveragePercent,
          isDaily: nutrientInfo.frequency == TrackingFrequency.daily,
        ));
      }
    }

    results.sort((a, b) => b.coveragePercent.compareTo(a.coveragePercent));
    return results;
  }

  /// Computes top nutrient contribution subtitle string: "'Key' 'coverage%' • ..."
  String buildNutrientCoverageSubtitle({
    required double portionGrams,
    required Map<String, double> targetMap,
    required Map<String, NutrientInfo> nutrientMap,
    int topCount = 3,
  }) {
    final list = calculateNutrientContributions(
      portionGrams: portionGrams,
      targetMap: targetMap,
      nutrientMap: nutrientMap,
    );

    final selected = list.take(topCount).toList();
    if (selected.isEmpty) return '';

    return selected.map((e) {
      final keyLabel = e.info.shortKey ?? e.info.displayName;
      return '$keyLabel ${e.coveragePercent.round()}%';
    }).join(' • ');
  }
}

@embedded
class FoodNutrientValue {
  late String nutrientKey; // Matches NutrientInfo.nutrientKey
  late double amountPer100g; // Amount in standard unit per 100g edible food
}
