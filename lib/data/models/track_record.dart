import 'package:isar/isar.dart';

part 'track_record.g.dart';

@collection
class TrackRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late DateTime date; // Normalized to YYYY-MM-DD midnight

  List<TrackedFoodEntry> loggedFoods = [];

  List<TrackNutrientSummary> nutrientSummaries = [];

  double routineAdherencePercent = 0.0;

  @Index()
  bool isSynced = false;
}

@embedded
class TrackedFoodEntry {
  late String foodId;
  late String foodTitle;
  late double amountConsumedGrams;
  late double plannedGrams;
  late bool isFromRoutine;
  late DateTime loggedAt;
}

@embedded
class TrackNutrientSummary {
  late String nutrientKey;
  late double amountConsumed;
  late double targetAmount;
  late double percentageMet;
}
