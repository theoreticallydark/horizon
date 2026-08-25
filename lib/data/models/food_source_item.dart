import 'package:isar/isar.dart';

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

  @Index()
  bool isFavorite = false;

  // Portion configuration
  String? defaultPortionLabel; // e.g. "1 piece", "1 cup"
  double defaultPortionGrams = 100.0;

  /// Planned Daily Grams in Routine (defaults to defaultPortionGrams when isTracked is toggled on)
  double plannedDailyGrams = 100.0;

  /// Nutrients per 100g of edible portion
  List<FoodNutrientValue> nutrients = [];
}

@embedded
class FoodNutrientValue {
  late String nutrientKey;
  late double amountPer100g;
}
