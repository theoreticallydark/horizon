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
}

@embedded
class FoodNutrientValue {
  late String nutrientKey; // Matches NutrientInfo.nutrientKey
  late double amountPer100g; // Amount in standard unit per 100g edible food
}
