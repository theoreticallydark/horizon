import 'package:isar/isar.dart';
import 'package:horizon/data/models/nutrient_info.dart';

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
}

@embedded
class FoodNutrientValue {
  late String nutrientKey;
  late double amountPer100g;
}
