import 'package:isar/isar.dart';

part 'user_profile.g.dart';

@collection
class UserProfile {
  Id id = 1; // Singleton record (id always 1)

  String name = '';

  DateTime? dateOfBirth;
  String? sex; // 'male' | 'female' | 'both'
  bool isPregnant = false;
  bool isLactating = false;

  /// Computed age in years derived dynamically from dateOfBirth
  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int calculatedAge = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      calculatedAge--;
    }
    return calculatedAge;
  }

  /// User body metrics (unpopulated by default)
  double? weightKg;
  double? heightCm;

  /// User goal: 'bulk' | 'cut' | 'maintain'
  @Enumerated(EnumType.name)
  UserGoal goal = UserGoal.maintain;

  /// Multiplier applied to RDA (0.0 to 1.0, default 0.9)
  double strictness = 0.9;

  /// List of nutrient keys the user actively wants to track
  List<String> nutrientTargets = [
    'vitamin_c',
    'collagen',
    'total_fiber',
    'magnesium',
    'calcium',
    'potassium',
    'creatine',
    'total_protein',
    'vitamin_a',
    'vitamin_e',
    'vitamin_b12',
    'selenium',
    'zinc',
    'iron',
    'iodine',
    'vitamin_k',
    'folate',
    'vitamin_d',
    'linoleic_acid_omega_6',
    'alpha_linolenic_acid_omega_3',
    'omega_3_epa_dha',
  ];

  DateTime lastUpdated = DateTime.now();

  /// Computes target for a given nutrient taking into account weight-based RDA (e.g. protein)
  double calculateNutrientTarget({
    required String nutrientKey,
    required double? rawRdaOrAi,
    bool isWeekly = false,
  }) {
    final raw = rawRdaOrAi ?? 0.0;
    double baseTarget;

    if (nutrientKey == 'total_protein') {
      final effWeight = weightKg ?? 70.0;
      baseTarget = (raw < 2.0 ? raw * effWeight : raw) * strictness;
    } else {
      baseTarget = raw * strictness;
    }

    return isWeekly ? baseTarget * 7.0 : baseTarget;
  }
}

enum UserGoal { bulk, cut, maintain }
