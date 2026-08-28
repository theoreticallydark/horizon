import 'package:flutter/material.dart';
import '../alter/alter.dart';
import '../data/models/food_source_item.dart';
import '../data/models/nutrient_info.dart';
import '../data/models/track_record.dart';
import '../data/services/nutrition_tracking_service.dart';

class HorizonDebugModal extends StatefulWidget {
  final int initialTabIndex; // 0: Track Page, 2: Routine Page

  const HorizonDebugModal({
    super.key,
    this.initialTabIndex = 0,
  });

  static void show(BuildContext context, {int initialTabIndex = 0}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => HorizonDebugModal(initialTabIndex: initialTabIndex),
    );
  }

  @override
  State<HorizonDebugModal> createState() => _HorizonDebugModalState();
}

class _HorizonDebugModalState extends State<HorizonDebugModal> {
  final NutritionTrackingService _trackingService = NutritionTrackingService();
  late int _selectedViewIndex; // 0: Track View, 1: Routine View

  @override
  void initState() {
    super.initState();
    _selectedViewIndex = widget.initialTabIndex == 2 ? 1 : 0;
  }

  String _formatDate(DateTime dt) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${weekdays[dt.weekday - 1]}, ${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: AlterSemanticTokens.baseWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AlterSemanticTokens.stroke100,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header Title & Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.bug_report, size: 22, color: AlterSemanticTokens.textPrimary),
                    const SizedBox(width: 8),
                    Text(
                      'Horizon Debugger',
                      style: AlterTypography.bodyBold.copyWith(
                        color: AlterSemanticTokens.textPrimary,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Reset Consumption Data Button (0g intake)
                    TextButton.icon(
                      icon: const Icon(Icons.restart_alt, size: 16, color: AlterSemanticTokens.textDanger),
                      label: Text(
                        'Reset Tracking',
                        style: AlterTypography.captionBold.copyWith(
                          color: AlterSemanticTokens.textDanger,
                          fontSize: 11,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        visualDensity: VisualDensity.compact,
                        backgroundColor: AlterSemanticTokens.baseGray,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () async {
                        await _trackingService.resetAllTrackingConsumptionData();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('All tracking records reset to 0g consumed!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(width: 6),

                    // Reseed Demo Routine Button
                    TextButton.icon(
                      icon: const Icon(Icons.refresh, size: 16, color: AlterSemanticTokens.textCaution),
                      label: Text(
                        'Reset Routine',
                        style: AlterTypography.captionBold.copyWith(
                          color: AlterSemanticTokens.textCaution,
                          fontSize: 11,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        visualDensity: VisualDensity.compact,
                        backgroundColor: AlterSemanticTokens.baseGray,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () async {
                        await _trackingService.reseedDemoRoutine();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Demo routine reseeded successfully! (100%+ Coverage)'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(width: 6),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: AlterSemanticTokens.stroke100),

          // Date Simulator Toolbar
          ValueListenableBuilder<DateTime>(
            valueListenable: NutritionTrackingService.simulatedDateNotifier,
            builder: (context, simulatedDate, _) {
              final isToday = DateTime(simulatedDate.year, simulatedDate.month, simulatedDate.day) ==
                  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                color: AlterSemanticTokens.baseGray,
                child: Row(
                  children: [
                    // Step Back 1 Day
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 24),
                      visualDensity: VisualDensity.compact,
                      onPressed: () async {
                        await _trackingService.stepSimulatedDate(-1);
                      },
                    ),

                    // Date Display
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _formatDate(simulatedDate),
                            style: AlterTypography.captionBold.copyWith(
                              color: AlterSemanticTokens.textPrimary,
                            ),
                          ),
                          Text(
                            isToday ? 'Today (Real Time)' : 'Simulated Time Travel',
                            style: AlterTypography.caption.copyWith(
                              color: isToday ? AlterSemanticTokens.textSuccess : AlterSemanticTokens.textDanger,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Step Forward 1 Day
                    IconButton(
                      icon: const Icon(Icons.chevron_right, size: 24),
                      visualDensity: VisualDensity.compact,
                      onPressed: () async {
                        await _trackingService.stepSimulatedDate(1);
                      },
                    ),

                    // Reset to Today Button
                    if (!isToday)
                      TextButton(
                        onPressed: () async {
                          await _trackingService.resetSimulatedDateToToday();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          visualDensity: VisualDensity.compact,
                        ),
                        child: Text(
                          'Reset',
                          style: AlterTypography.captionBold.copyWith(
                            color: AlterSemanticTokens.textCaution,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),

          // Scope Switcher (Track vs Routine vs Foods)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AlterSemanticTokens.baseGray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _buildTabButton(index: 0, label: 'Track View'),
                  _buildTabButton(index: 1, label: 'Routine View'),
                  _buildTabButton(index: 2, label: 'Foods & Freq'),
                ],
              ),
            ),
          ),

          // StreamBuilder for Active Tab
          Expanded(
            child: _selectedViewIndex == 0
                ? _buildTrackViewAudit()
                : _selectedViewIndex == 1
                    ? _buildRoutineViewAudit()
                    : _buildFoodsFrequencyManager(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({required int index, required String label}) {
    final isSelected = _selectedViewIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedViewIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AlterSemanticTokens.baseWhite : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withAlpha(15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: isSelected
                ? AlterTypography.captionBold.copyWith(color: AlterSemanticTokens.textPrimary)
                : AlterTypography.caption.copyWith(color: AlterSemanticTokens.textSecondary),
          ),
        ),
      ),
    );
  }

  Widget _buildTrackViewAudit() {
    return StreamBuilder<TrackPageState>(
      stream: _trackingService.watchTrackPageState(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final nutrients = state.allNutrients
            .where((n) => n.isVisibleOnApp && n.isTracked)
            .toList();

        // Sort: Daily first, then Weekly
        final daily = nutrients.where((n) => n.frequency == TrackingFrequency.daily).toList();
        final weekly = nutrients.where((n) => n.frequency == TrackingFrequency.weekly).toList();
        final ordered = [...daily, ...weekly];

        final dailyRecord = state.dailyRecord;
        final weeklyRecord = state.weeklyRecord;
        final foodMap = state.foodMap;

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // Track Header Summary
            _buildTrackMacroHeader(),
            const SizedBox(height: 12),

            // Table Header
            _buildTableHeader(isRoutine: false),
            const SizedBox(height: 6),

            for (final nutrient in ordered) ...[
              _buildNutrientRow(
                nutrient: nutrient,
                targetAmount: state.targetMap[nutrient.nutrientKey] ?? 0.0,
                dailyRecord: dailyRecord,
                weeklyRecord: weeklyRecord,
                foodMap: foodMap,
              ),
              const Divider(height: 1, color: AlterSemanticTokens.stroke100),
            ],
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }

  Widget _buildRoutineViewAudit() {
    return StreamBuilder<RoutinePageState>(
      stream: _trackingService.watchRoutinePageState(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final nutrients = state.allNutrients
            .where((n) => n.isVisibleOnApp && n.isTracked)
            .toList();

        final daily = nutrients.where((n) => n.frequency == TrackingFrequency.daily).toList();
        final weekly = nutrients.where((n) => n.frequency == TrackingFrequency.weekly).toList();
        final ordered = [...daily, ...weekly];

        // Compute planned routine amounts and contributing foods
        final Map<String, double> plannedTotals = {};
        for (final food in state.routineFoods) {
          final portion = food.plannedDailyGrams;
          for (final nutr in food.nutrients) {
            if (nutr.nutrientKey == 'total_protein' && food.proteinIndex != 1) continue;
            final amount = (portion / 100.0) * nutr.amountPer100g;
            plannedTotals[nutr.nutrientKey] =
                (plannedTotals[nutr.nutrientKey] ?? 0.0) + amount;
          }
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // Routine Header Summary
            _buildRoutineMacroHeader(),
            const SizedBox(height: 12),

            // Table Header
            _buildTableHeader(isRoutine: true),
            const SizedBox(height: 6),

            for (final nutrient in ordered) ...[
              _buildRoutineNutrientRow(
                nutrient: nutrient,
                targetAmount: state.targetMap[nutrient.nutrientKey] ?? 0.0,
                plannedTotalDaily: plannedTotals[nutrient.nutrientKey] ?? 0.0,
                routineFoods: state.routineFoods,
              ),
              const Divider(height: 1, color: AlterSemanticTokens.stroke100),
            ],
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }

  Widget _buildTrackMacroHeader() {
    return StreamBuilder<({double consumedCalories, double plannedCalories, double consumedProtein, double plannedProtein})>(
      stream: _trackingService.watchTodayTrackHeaderEnergyAndProtein(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        final cCal = data?.consumedCalories.round() ?? 0;
        final pCal = data?.plannedCalories.round() ?? 0;
        final cProt = data?.consumedProtein.round() ?? 0;
        final pProt = data?.plannedProtein.round() ?? 0;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AlterSemanticTokens.baseGray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Calories (Today)', style: AlterTypography.caption.copyWith(color: AlterSemanticTokens.textSecondary)),
                  const SizedBox(height: 2),
                  Text('$cCal / $pCal kcal', style: AlterTypography.captionBold.copyWith(color: AlterSemanticTokens.textPrimary)),
                ],
              ),
              Container(width: 1, height: 28, color: AlterSemanticTokens.stroke100),
              Column(
                children: [
                  Text('Protein (Today)', style: AlterTypography.caption.copyWith(color: AlterSemanticTokens.textSecondary)),
                  const SizedBox(height: 2),
                  Text('$cProt / ${pProt}g', style: AlterTypography.captionBold.copyWith(color: AlterSemanticTokens.textPrimary)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRoutineMacroHeader() {
    return StreamBuilder<({double calories, double protein})>(
      stream: _trackingService.watchPlannedRoutineEnergyAndProtein(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        final cal = data?.calories.round() ?? 0;
        final prot = data?.protein.round() ?? 0;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AlterSemanticTokens.baseGray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Planned Daily Calories', style: AlterTypography.caption.copyWith(color: AlterSemanticTokens.textSecondary)),
                  const SizedBox(height: 2),
                  Text('$cal kcal', style: AlterTypography.captionBold.copyWith(color: AlterSemanticTokens.textPrimary)),
                ],
              ),
              Container(width: 1, height: 28, color: AlterSemanticTokens.stroke100),
              Column(
                children: [
                  Text('Planned Daily Protein', style: AlterTypography.caption.copyWith(color: AlterSemanticTokens.textSecondary)),
                  const SizedBox(height: 2),
                  Text('${prot}g', style: AlterTypography.captionBold.copyWith(color: AlterSemanticTokens.textPrimary)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTableHeader({required bool isRoutine}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text('Nutrient & Frequency', style: AlterTypography.captionBold.copyWith(color: AlterSemanticTokens.textSecondary, fontSize: 11)),
          ),
          Expanded(
            flex: 3,
            child: Text(isRoutine ? 'Planned / Target' : 'Consumed / Target', style: AlterTypography.captionBold.copyWith(color: AlterSemanticTokens.textSecondary, fontSize: 11)),
          ),
          Expanded(
            flex: 2,
            child: Text('Coverage', textAlign: TextAlign.right, style: AlterTypography.captionBold.copyWith(color: AlterSemanticTokens.textSecondary, fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientRow({
    required NutrientInfo nutrient,
    required double targetAmount,
    TrackRecordDaily? dailyRecord,
    TrackRecordWeekly? weeklyRecord,
    required Map<String, FoodSourceItem> foodMap,
  }) {
    final isDaily = nutrient.frequency == TrackingFrequency.daily;
    double consumed = 0.0;
    final List<({String title, double grams, double contribution})> contributors = [];

    final rawUnit = nutrient.unit.isNotEmpty ? nutrient.unit.split('/').first.trim() : '';
    final unit = rawUnit.replaceAll('RAE', '').trim();

    if (isDaily) {
      if (dailyRecord != null) {
        for (final s in dailyRecord.nutrientSummaries) {
          if (s.nutrientKey == nutrient.nutrientKey) {
            consumed = s.amountConsumed;
            break;
          }
        }
        for (final logged in dailyRecord.loggedFoods) {
          if (logged.amountConsumedGrams <= 0) continue;
          final food = foodMap[logged.foodId];
          if (food == null) continue;
          if (nutrient.nutrientKey == 'total_protein' && food.proteinIndex != 1) continue;
          FoodNutrientValue? n;
          for (final item in food.nutrients) {
            if (item.nutrientKey == nutrient.nutrientKey) {
              n = item;
              break;
            }
          }
          if (n != null && n.amountPer100g > 0) {
            final yieldVal = (logged.amountConsumedGrams / 100.0) * n.amountPer100g;
            contributors.add((
              title: food.title,
              grams: logged.amountConsumedGrams,
              contribution: yieldVal,
            ));
          }
        }
      }
    } else {
      if (weeklyRecord != null) {
        for (final s in weeklyRecord.nutrientSummaries) {
          if (s.nutrientKey == nutrient.nutrientKey) {
            consumed = s.amountConsumed;
            break;
          }
        }
        for (final logged in weeklyRecord.loggedFoods) {
          if (logged.amountConsumedGrams <= 0) continue;
          final food = foodMap[logged.foodId];
          if (food == null) continue;
          if (nutrient.nutrientKey == 'total_protein' && food.proteinIndex != 1) continue;
          FoodNutrientValue? n;
          for (final item in food.nutrients) {
            if (item.nutrientKey == nutrient.nutrientKey) {
              n = item;
              break;
            }
          }
          if (n != null && n.amountPer100g > 0) {
            final yieldVal = (logged.amountConsumedGrams / 100.0) * n.amountPer100g;
            contributors.add((
              title: food.title,
              grams: logged.amountConsumedGrams,
              contribution: yieldVal,
            ));
          }
        }
      }
    }

    final percent = targetAmount > 0 ? (consumed / targetAmount) * 100.0 : 0.0;
    final percentRound = percent.round();

    final Color statusColor;
    if (percentRound >= 100) {
      statusColor = AlterSemanticTokens.textSuccess;
    } else if (percentRound >= 75) {
      statusColor = AlterSemanticTokens.textCaution;
    } else {
      statusColor = AlterSemanticTokens.textDanger;
    }

    final formatConsumed = consumed >= 10 ? consumed.round().toString() : consumed.toStringAsFixed(1);
    final formatTarget = targetAmount >= 10 ? targetAmount.round().toString() : targetAmount.toStringAsFixed(1);

    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        childrenPadding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
        title: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${nutrient.displayName} (${nutrient.shortKey ?? ""})',
                    style: AlterTypography.captionBold.copyWith(color: AlterSemanticTokens.textPrimary),
                  ),
                  Text(
                    isDaily ? 'Daily 🔁' : 'Weekly 📆',
                    style: AlterTypography.caption.copyWith(
                      color: isDaily ? AlterSemanticTokens.textSecondary : AlterSemanticTokens.textCaution,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                '$formatConsumed / $formatTarget $unit',
                style: AlterTypography.caption.copyWith(color: AlterSemanticTokens.textPrimary),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '$percentRound%',
                textAlign: TextAlign.right,
                style: AlterTypography.captionBold.copyWith(color: statusColor),
              ),
            ),
          ],
        ),
        children: [
          if (contributors.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'No consumed foods contributed to this nutrient yet.',
                style: AlterTypography.caption.copyWith(color: AlterSemanticTokens.textSecondary, fontStyle: FontStyle.italic),
              ),
            )
          else ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AlterSemanticTokens.baseGray,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contributing Foods (${isDaily ? "Today" : "This Week"}):',
                    style: AlterTypography.captionBold.copyWith(color: AlterSemanticTokens.textSecondary, fontSize: 10),
                  ),
                  const SizedBox(height: 4),
                  for (final c in contributors) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '• ${c.title} (${c.grams.round()}g)',
                            style: AlterTypography.caption.copyWith(color: AlterSemanticTokens.textPrimary, fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '+${c.contribution >= 10 ? c.contribution.round() : c.contribution.toStringAsFixed(1)} $unit',
                          style: AlterTypography.captionBold.copyWith(color: AlterSemanticTokens.textPrimary, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRoutineNutrientRow({
    required NutrientInfo nutrient,
    required double targetAmount,
    required double plannedTotalDaily,
    required List<FoodSourceItem> routineFoods,
  }) {
    final isDaily = nutrient.frequency == TrackingFrequency.daily;
    final plannedYield = isDaily ? plannedTotalDaily : plannedTotalDaily * 7.0;
    final percent = targetAmount > 0 ? (plannedYield / targetAmount) * 100.0 : 0.0;
    final percentRound = percent.round();

    final rawUnit = nutrient.unit.isNotEmpty ? nutrient.unit.split('/').first.trim() : '';
    final unit = rawUnit.replaceAll('RAE', '').trim();

    final List<({String title, double grams, double contribution})> contributors = [];
    for (final food in routineFoods) {
      final portion = food.plannedDailyGrams;
      if (portion <= 0) continue;
      if (nutrient.nutrientKey == 'total_protein' && food.proteinIndex != 1) continue;
      FoodNutrientValue? n;
      for (final item in food.nutrients) {
        if (item.nutrientKey == nutrient.nutrientKey) {
          n = item;
          break;
        }
      }
      if (n != null && n.amountPer100g > 0) {
        final dailyContrib = (portion / 100.0) * n.amountPer100g;
        final totalContrib = isDaily ? dailyContrib : dailyContrib * 7.0;
        contributors.add((
          title: food.title,
          grams: isDaily ? portion : portion * 7.0,
          contribution: totalContrib,
        ));
      }
    }

    final Color statusColor;
    if (percentRound >= 100) {
      statusColor = AlterSemanticTokens.textSuccess;
    } else if (percentRound >= 75) {
      statusColor = AlterSemanticTokens.textCaution;
    } else {
      statusColor = AlterSemanticTokens.textDanger;
    }

    final formatPlanned = plannedYield >= 10 ? plannedYield.round().toString() : plannedYield.toStringAsFixed(1);
    final formatTarget = targetAmount >= 10 ? targetAmount.round().toString() : targetAmount.toStringAsFixed(1);

    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        childrenPadding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
        title: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${nutrient.displayName} (${nutrient.shortKey ?? ""})',
                    style: AlterTypography.captionBold.copyWith(color: AlterSemanticTokens.textPrimary),
                  ),
                  Text(
                    isDaily ? 'Daily 🔁' : 'Weekly 📆',
                    style: AlterTypography.caption.copyWith(
                      color: isDaily ? AlterSemanticTokens.textSecondary : AlterSemanticTokens.textCaution,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                '$formatPlanned / $formatTarget $unit',
                style: AlterTypography.caption.copyWith(color: AlterSemanticTokens.textPrimary),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '$percentRound%',
                textAlign: TextAlign.right,
                style: AlterTypography.captionBold.copyWith(color: statusColor),
              ),
            ),
          ],
        ),
        children: [
          if (contributors.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'No foods in routine provide this nutrient.',
                style: AlterTypography.caption.copyWith(color: AlterSemanticTokens.textSecondary, fontStyle: FontStyle.italic),
              ),
            )
          else ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AlterSemanticTokens.baseGray,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Routine Source Foods (${isDaily ? "Daily Portion" : "7-Day Protocol Total"}):',
                    style: AlterTypography.captionBold.copyWith(color: AlterSemanticTokens.textSecondary, fontSize: 10),
                  ),
                  const SizedBox(height: 4),
                  for (final c in contributors) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '• ${c.title} (${c.grams.round()}g)',
                            style: AlterTypography.caption.copyWith(color: AlterSemanticTokens.textPrimary, fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '+${c.contribution >= 10 ? c.contribution.round() : c.contribution.toStringAsFixed(1)} $unit',
                          style: AlterTypography.captionBold.copyWith(color: AlterSemanticTokens.textPrimary, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFoodsFrequencyManager() {
    return StreamBuilder<RoutinePageState>(
      stream: _trackingService.watchRoutinePageState(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final routineFoods = state.routineFoods;
        if (routineFoods.isEmpty) {
          return const Center(
            child: Text(
              'No active foods in routine.',
              style: AlterTypography.caption,
            ),
          );
        }

        // Split into Daily and Weekly
        final daily = routineFoods.where((f) => f.frequency == TrackingFrequency.daily).toList();
        final weekly = routineFoods.where((f) => f.frequency == TrackingFrequency.weekly).toList();

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // Info Header Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AlterSemanticTokens.baseGray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.swap_horiz, size: 20, color: AlterSemanticTokens.textPrimary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Toggle any active food between Daily and Weekly. Track & Routine views will update instantly.',
                      style: AlterTypography.caption.copyWith(
                        color: AlterSemanticTokens.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Daily Foods Section
            _buildSectionHeader(title: 'DAILY ROUTINE FOODS (${daily.length})', color: AlterSemanticTokens.textSuccess),
            const SizedBox(height: 6),
            for (final food in daily) ...[
              _buildFoodFrequencyRow(food),
              const Divider(height: 1, color: AlterSemanticTokens.stroke100),
            ],
            const SizedBox(height: 16),

            // Weekly Foods Section
            _buildSectionHeader(title: 'WEEKLY ROUTINE FOODS (${weekly.length})', color: AlterSemanticTokens.textCaution),
            const SizedBox(height: 6),
            for (final food in weekly) ...[
              _buildFoodFrequencyRow(food),
              const Divider(height: 1, color: AlterSemanticTokens.stroke100),
            ],
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader({required String title, required Color color}) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: AlterTypography.captionBold.copyWith(
            color: AlterSemanticTokens.textPrimary,
            fontSize: 11,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFoodFrequencyRow(FoodSourceItem food) {
    final isDaily = food.frequency == TrackingFrequency.daily;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        children: [
          // Food Title & Portion
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.title,
                  style: AlterTypography.captionBold.copyWith(
                    color: AlterSemanticTokens.textPrimary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isDaily
                      ? 'Target: ${food.plannedDailyGrams.round()}g / day'
                      : 'Target: ${food.plannedWeeklyGrams.round()}g / week (${food.plannedDailyGrams.round()}g daily base)',
                  style: AlterTypography.caption.copyWith(
                    color: AlterSemanticTokens.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          // Frequency Toggle Segmented Control
          Container(
            decoration: BoxDecoration(
              color: AlterSemanticTokens.baseGray,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AlterSemanticTokens.stroke100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Daily Button
                InkWell(
                  onTap: isDaily
                      ? null
                      : () async {
                          await _trackingService.setFoodFrequencyOverride(
                            foodId: food.foodId,
                            frequency: TrackingFrequency.daily,
                          );
                        },
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(7)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDaily ? AlterSemanticTokens.textSuccess.withAlpha(25) : Colors.transparent,
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(7)),
                    ),
                    child: Text(
                      'Daily',
                      style: AlterTypography.captionBold.copyWith(
                        color: isDaily ? AlterSemanticTokens.textSuccess : AlterSemanticTokens.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),

                // Weekly Button
                InkWell(
                  onTap: !isDaily
                      ? null
                      : () async {
                          await _trackingService.setFoodFrequencyOverride(
                            foodId: food.foodId,
                            frequency: TrackingFrequency.weekly,
                          );
                        },
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(7)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: !isDaily ? AlterSemanticTokens.textCaution.withAlpha(25) : Colors.transparent,
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(7)),
                    ),
                    child: Text(
                      'Weekly',
                      style: AlterTypography.captionBold.copyWith(
                        color: !isDaily ? AlterSemanticTokens.textCaution : AlterSemanticTokens.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

