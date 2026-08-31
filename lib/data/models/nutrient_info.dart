import 'package:isar/isar.dart';
import 'package:horizon/data/models/user_profile.dart';

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

  /// Computed target taking into account user profile (weightKg for total_protein, strictness, and frequency)
  double calculateEffectiveTarget(dynamic profileOrStrictness) {
    if (profileOrStrictness is UserProfile) {
      return profileOrStrictness.calculateNutrientTarget(
        nutrientKey: nutrientKey,
        rawRdaOrAi: rdaOrAi,
        isWeekly: frequency == TrackingFrequency.weekly,
      );
    }

    final strictness = (profileOrStrictness as num?)?.toDouble() ?? 0.9;
    double raw = rdaOrAi ?? 0.0;
    if (nutrientKey == 'total_protein' && raw < 2.0) {
      raw = raw * 70.0; // fallback 70kg adult default
    }
    final base = raw * strictness;
    return frequency == TrackingFrequency.weekly ? base * 7 : base;
  }
}

enum TrackingFrequency { daily, weekly }

/// Centralized formatting extension for nutrient amounts and targets.
extension NutrientDisplayExtension on num {
  /// Formats nutrient number cleanly: whole number if >= 10, otherwise 1 decimal place.
  String toNutrientDisplayString() {
    if (this >= 10.0) {
      return round().toString();
    }
    // Remove trailing .0 if integer (e.g. 5.0 -> 5)
    final fixed = toStringAsFixed(1);
    return fixed.endsWith('.0') ? fixed.substring(0, fixed.length - 2) : fixed;
  }
}
