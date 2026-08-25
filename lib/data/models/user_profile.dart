import 'package:isar/isar.dart';

part 'user_profile.g.dart';

@collection
class UserProfile {
  Id id = 1; // Singleton record (id always 1)

  int age = 25; // Default age
  String sex = 'male'; // 'male' | 'female' | 'both'
  bool isPregnant = false;
  bool isLactating = false;

  /// Multiplier applied to RDA (0.0 to 1.0, default 0.9)
  double strictness = 0.9;

  DateTime lastUpdated = DateTime.now();
}
