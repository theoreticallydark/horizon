import 'package:flutter/material.dart';
import '../alter/alter.dart';
import '../data/models/food_source_item.dart';
import '../data/models/nutrient_info.dart';
import '../data/services/nutrition_tracking_service.dart';
import '../data/utils/continuous_step_controller.dart';
import '../horizon/horizon_add_source.dart';
import '../horizon/horizon_list_item.dart';
import '../horizon/horizon_title_bar.dart';

class RoutinePage extends StatefulWidget {
  final String? selectedNutrientKey;
  final bool isAddSourceOpen;
  final VoidCallback? onAddSourceClose;
  final ValueChanged<bool>? onSearchActiveChanged;

  const RoutinePage({
    super.key,
    this.selectedNutrientKey,
    this.isAddSourceOpen = false,
    this.onAddSourceClose,
    this.onSearchActiveChanged,
  });

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  final NutritionTrackingService _trackingService = NutritionTrackingService();

  late final ContinuousStepController _stepController;
  String? _activeFoodId;
  double? _activeTargetGrams;

  @override
  void initState() {
    super.initState();
    _stepController = ContinuousStepController(
      minValue: 1.0,
      onStep: (newVal) {
        setState(() {
          _activeTargetGrams = newVal;
        });
      },
      onHoldEnd: () {
        if (_activeFoodId != null && _activeTargetGrams != null) {
          _trackingService.updateFoodPlannedTarget(
            foodId: _activeFoodId!,
            newTargetGrams: _activeTargetGrams!,
          );
        }
        _activeFoodId = null;
        _activeTargetGrams = null;
      },
    );
  }

  void _startContinuousChange({
    required String foodId,
    required double currentPlannedGrams,
    required double delta,
  }) {
    _activeFoodId = foodId;
    _activeTargetGrams = currentPlannedGrams;
    _stepController.start(
      currentDelta: delta,
      currentValue: currentPlannedGrams,
    );
  }

  void _stopContinuousChange() {
    _stepController.stop();
  }

  @override
  void dispose() {
    _stepController.dispose();
    super.dispose();
  }

  Widget _buildRoutineItem({
    required FoodSourceItem food,
    required Map<String, double> targetMap,
    required Map<String, NutrientInfo> nutrientMap,
  }) {
    final currentGrams = (_activeFoodId == food.foodId && _activeTargetGrams != null)
        ? _activeTargetGrams!
        : food.plannedDailyGrams;

    final isDaily = food.frequency == TrackingFrequency.daily;
    final displayGrams = isDaily ? currentGrams : currentGrams * 7.0;
    final targetLabel = '${displayGrams.round()}g';
    final itemTitle = '${food.title}, $targetLabel';
    final subtitleText = food.buildNutrientCoverageSubtitle(
      portionGrams: displayGrams,
      targetMap: targetMap,
      nutrientMap: nutrientMap,
    );

    final isMinima = currentGrams <= 1.0;
    final hostVariant = isMinima
        ? HorizonListItemHost.routineRemove
        : HorizonListItemHost.routine;

    // For daily foods: step directly changes plannedDailyGrams by stepGrams.
    // For weekly foods: displayGrams represents weekly planned quota (currentGrams * 7).
    // Stepping weekly foods by stepGrams shifts daily quota by (stepGrams / 7.0).
    final dailyDelta = isDaily ? food.stepGrams : (food.stepGrams / 7.0);

    return HorizonListItem(
      title: itemTitle,
      subtitle: subtitleText,
      host: hostVariant,

      // LEFT ACTION (Decrement / Remove)
      onLeftActionTap: () {
        if (isMinima) {
          // Click on Red button removes food from routine
          _trackingService.handleRoutineFoodRemoved(food.foodId);
        } else {
          final updated = (currentGrams - dailyDelta).clamp(1.0, 99999.0);
          _trackingService.updateFoodPlannedTarget(
            foodId: food.foodId,
            newTargetGrams: updated,
          );
        }
      },
      onLeftTapDown: (_) {
        if (!isMinima) {
          _startContinuousChange(
            foodId: food.foodId,
            currentPlannedGrams: currentGrams,
            delta: -dailyDelta,
          );
        }
      },
      onLeftTapUp: (_) => _stopContinuousChange(),
      onLeftTapCancel: () => _stopContinuousChange(),

      // RIGHT ACTION (Increment)
      onRightActionTap: () {
        final updated = (currentGrams + dailyDelta).clamp(1.0, 99999.0);
        _trackingService.updateFoodPlannedTarget(
          foodId: food.foodId,
          newTargetGrams: updated,
        );
      },
      onRightTapDown: (_) {
        _startContinuousChange(
          foodId: food.foodId,
          currentPlannedGrams: currentGrams,
          delta: dailyDelta,
        );
      },
      onRightTapUp: (_) => _stopContinuousChange(),
      onRightTapCancel: () => _stopContinuousChange(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AlterSemanticTokens.baseWhite,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: StreamBuilder<RoutinePageState>(
                stream: _trackingService.watchRoutinePageState(),
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state == null) {
            return const SizedBox.shrink();
          }

          final routineFoods = state.routineFoods;
          final filteredFoods = routineFoods
              .where((f) => f.providesNutrient(widget.selectedNutrientKey))
              .toList();

          if (routineFoods.isEmpty && widget.selectedNutrientKey == null) {
            return const Center(
              child: Text(
                'No foods in your routine yet.\nAdd foods to build your daily & weekly routine.',
                textAlign: TextAlign.center,
                style: AlterTypography.caption,
              ),
            );
          }

          final dailyFoods = filteredFoods
              .where((f) => f.frequency == TrackingFrequency.daily)
              .toList();
          final weeklyFoods = filteredFoods
              .where((f) => f.frequency == TrackingFrequency.weekly)
              .toList();

          return ListView(
            children: [
              // Filter Header if a nutrient pill is selected
              if (widget.selectedNutrientKey != null &&
                  state.nutrientMap.containsKey(widget.selectedNutrientKey)) ...[
                Builder(
                  builder: (context) {
                    final nutrient = state.nutrientMap[widget.selectedNutrientKey]!;
                    final isWeekly = nutrient.frequency == TrackingFrequency.weekly;
                    final targetVal = state.targetMap[widget.selectedNutrientKey] ?? 0.0;

                    // Calculate total planned contribution for this nutrient
                    double plannedTotal = 0.0;
                    for (final food in routineFoods) {
                      if (nutrient.nutrientKey == 'total_protein' && food.proteinIndex != 1) continue;
                      FoodNutrientValue? foodNutr;
                      for (final n in food.nutrients) {
                        if (n.nutrientKey == nutrient.nutrientKey) {
                          foodNutr = n;
                          break;
                        }
                      }
                      if (foodNutr != null) {
                        plannedTotal += (food.plannedDailyGrams / 100.0) * foodNutr.amountPer100g;
                      }
                    }
                    final plannedYield = isWeekly ? plannedTotal * 7.0 : plannedTotal;
                    final rawUnit = nutrient.unit.isNotEmpty ? nutrient.unit.split('/').first.trim() : '';
                    final unit = rawUnit.replaceAll('RAE', '').trim();

                    final String formatYield = plannedYield >= 10
                        ? plannedYield.round().toString()
                        : plannedYield.toStringAsFixed(1);
                    final String formatTarget = targetVal >= 10
                        ? targetVal.round().toString()
                        : targetVal.toStringAsFixed(1);

                    final percent = targetVal > 0 ? (plannedYield / targetVal) * 100.0 : 0.0;
                    final Color amountColor;
                    if (percent < 75.0) {
                      amountColor = AlterSemanticTokens.textDanger;
                    } else if (percent < 100.0) {
                      amountColor = AlterSemanticTokens.textCaution;
                    } else {
                      amountColor = AlterSemanticTokens.textSuccess;
                    }

                    final title = nutrient.displayName;
                    final prefixText = isWeekly ? 'Tracked Weekly 📆 • ' : 'Tracked Daily 🔁 • ';
                    final amountText = '$formatYield/$formatTarget$unit';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HorizonTitleBar(
                          title: title,
                          subtitleWidget: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: prefixText,
                                  style: AlterTypography.caption.copyWith(
                                    color: AlterSemanticTokens.textSecondary,
                                    height: 16.0 / 12.0,
                                  ),
                                ),
                                TextSpan(
                                  text: amountText,
                                  style: AlterTypography.captionBold.copyWith(
                                    color: amountColor,
                                    height: 16.0 / 12.0,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ],

              // Daily Targets Section
              if (dailyFoods.isNotEmpty) ...[
                if (widget.selectedNutrientKey == null) ...[
                  const HorizonTitleBar(
                    title: 'Daily targets',
                    subtitle:
                        'Supports nutrients with faster biological turnover.',
                  ),
                  const SizedBox(height: 16),
                ],
                for (int i = 0; i < dailyFoods.length; i++) ...[
                  if (i > 0) const SizedBox(height: 8),
                  _buildRoutineItem(
                    food: dailyFoods[i],
                    targetMap: state.targetMap,
                    nutrientMap: state.nutrientMap,
                  ),
                ],
              ],

              // Divider between Daily and Weekly sections
              if (dailyFoods.isNotEmpty && weeklyFoods.isNotEmpty) ...[
                const SizedBox(height: 24),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: AlterSemanticTokens.stroke100,
                ),
                const SizedBox(height: 24),
              ],

              // Weekly Targets Section
              if (weeklyFoods.isNotEmpty) ...[
                const HorizonTitleBar(
                  title: 'Weekly targets',
                  subtitle:
                      'Supports nutrients with longer biological half-lives.',
                ),
                const SizedBox(height: 16),
                for (int i = 0; i < weeklyFoods.length; i++) ...[
                  if (i > 0) const SizedBox(height: 8),
                  _buildRoutineItem(
                    food: weeklyFoods[i],
                    targetMap: state.targetMap,
                    nutrientMap: state.nutrientMap,
                  ),
                ],
              ],

              // Bottom padding offset for bottom navigation bar
              const SizedBox(height: 120),
            ],
          );
        },
      ),
    ),

            // Smooth Animated Bottom-Up HorizonAddSource Overlay
            AnimatedSlide(
              offset:
                  widget.isAddSourceOpen ? Offset.zero : const Offset(0.0, 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              child: AnimatedOpacity(
                opacity: widget.isAddSourceOpen ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: IgnorePointer(
                  ignoring: !widget.isAddSourceOpen,
                  child: HorizonAddSource(
                    selectedNutrientKey: widget.selectedNutrientKey,
                    onDone: widget.onAddSourceClose,
                    onSearchToggle: widget.onSearchActiveChanged,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
