import 'package:isar/isar.dart';

part 'daily_record.g.dart';

@collection
class DailyRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late DateTime date; // Normalized to YYYY-MM-DD midnight

  List<DailyFoodLogEntry> loggedFoods = [];

  List<DailyNutrientSummary> nutrientSummaries = [];

  double routineAdherencePercent = 0.0;

  @Index()
  bool isSynced = false;
}

@embedded
class DailyFoodLogEntry {
  late String foodId;
  late String foodTitle;
  late double amountConsumedGrams;
  late double plannedGrams;
  late bool isFromRoutine;
  late DateTime loggedAt;
}

@embedded
class DailyNutrientSummary {
  late String nutrientKey;
  late double amountConsumed;
  late double targetAmount;
  late double percentageMet;
}
