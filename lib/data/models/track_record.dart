import 'package:isar/isar.dart';
import 'package:horizon/data/models/nutrient_info.dart';

part 'track_record.g.dart';

@collection
class TrackRecordDaily {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late DateTime date; // Normalized to YYYY-MM-DD midnight

  List<TrackedFoodEntry> loggedFoods = [];

  List<TrackNutrientSummary> nutrientSummaries = [];

  double routineAdherencePercent = 0.0;

  @Index()
  bool isSynced = false;
}

@collection
class TrackRecordWeekly {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late DateTime weekStartDate; // Normalized Monday midnight (YYYY-MM-DD)

  @Index()
  late String weekKey; // e.g. "2026-W35"

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

  @Enumerated(EnumType.name)
  TrackingFrequency frequency = TrackingFrequency.daily;
}

@embedded
class TrackNutrientSummary {
  late String nutrientKey;
  late double amountConsumed;
  late double targetAmount;
  late double percentageMet;
}
