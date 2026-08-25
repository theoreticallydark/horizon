import 'package:isar/isar.dart';

part 'nutrient_info.g.dart';

@collection
class NutrientInfo {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String nutrientKey; // e.g. "vitamin_a", "total_protein", "iron"

  String? shortKey; // e.g. "Vit A", "Vit C", "Mg", "Coll."
  late String displayName;
  String? category; // 'Vitamins', 'Minerals', 'Macronutrients', 'Lipids'
  late String unit; // 'mg/day', 'µg/day', 'g/day'

  @Index()
  bool isVisibleOnApp = true;

  @Index()
  bool isTracked = true; // Rule: Must be false if isVisibleOnApp is false

  @Enumerated(EnumType.name)
  TrackingFrequency frequency = TrackingFrequency.daily; // daily | weekly

  double? ear;
  double? rdaOrAi; // Raw RDA/AI from demographic lookup
  double? ul; // Tolerable Upper Intake Level

  /// Computed: (rdaOrAi ?? 0.0) * userStrictness
  double calculateEffectiveTarget(double userStrictness) {
    final base = (rdaOrAi ?? 0.0) * userStrictness;
    return frequency == TrackingFrequency.weekly ? base * 7 : base;
  }
}

enum TrackingFrequency { daily, weekly }
