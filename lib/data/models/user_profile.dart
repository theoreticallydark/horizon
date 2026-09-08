import 'package:isar/isar.dart';

part 'user_profile.g.dart';

@collection
class UserProfile {
  Id id = 1; // Singleton record (id always 1)

  String name = 'User';

  int age = 25; // Default age
  String sex = 'male'; // 'male' | 'female' | 'both'
  bool isPregnant = false;
  bool isLactating = false;

  /// User body metrics
  double weightKg = 70.0; // Default reference weight: 70kg
  double heightCm = 175.0; // Default reference height in cm

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
      // If raw RDA is in g/kg/d (e.g. 0.8), multiply by user body weight in kg
      baseTarget = (raw < 2.0 ? raw * weightKg : raw) * strictness;
    } else {
      baseTarget = raw * strictness;
    }

    return isWeekly ? baseTarget * 7.0 : baseTarget;
  }
}

enum UserGoal { bulk, cut, maintain }
