import 'package:flutter/material.dart';
import 'package:alter/alter.dart';
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

    final dailyDelta = isDaily ? food.stepGrams : (food.stepGrams / 7.0);

    final itemWidget = HorizonListItem(
      title: itemTitle,
      subtitle: subtitleText,
      host: hostVariant,

      // LEFT ACTION (Decrement / Remove)
      onLeftActionTap: () {
        if (isMinima) {
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

    return LongPressDraggable<FoodSourceItem>(
      data: food,
      axis: Axis.vertical,
      feedback: Material(
        color: Colors.transparent,
        elevation: 6,
        shadowColor: AlterSemanticTokens.textPrimary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: MediaQuery.of(context).size.width - 48,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AlterSemanticTokens.baseWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AlterSemanticTokens.textPrimary.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: itemWidget,
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.15,
        child: itemWidget,
      ),
      child: itemWidget,
    );
  }

  Widget _buildListSection({
    required TrackingFrequency frequency,
    required String title,
    required String subtitle,
    required List<FoodSourceItem> foods,
    required Map<String, double> targetMap,
    required Map<String, NutrientInfo> nutrientMap,
    required bool isFilterActive,
  }) {
    return DragTarget<FoodSourceItem>(
      onWillAcceptWithDetails: (details) {
        return details.data.frequency != frequency;
      },
      onAcceptWithDetails: (details) {
        _trackingService.setFoodFrequencyOverride(
          foodId: details.data.foodId,
          frequency: frequency,
        );
      },
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!isFilterActive || frequency == TrackingFrequency.weekly) ...[
                HorizonTitleBar(
                  title: title,
                  subtitle: subtitle,
                ),
                const SizedBox(height: 16),
              ],
              if (foods.isEmpty) ...[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isHovered
                        ? AlterSemanticTokens.baseGray
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    isHovered
                        ? 'Drop here to track ${frequency == TrackingFrequency.daily ? 'Daily' : 'Weekly'}'
                        : 'No ${frequency == TrackingFrequency.daily ? 'daily' : 'weekly'} foods yet',
                    style: AlterTypography.caption.copyWith(
                      color: isHovered
                          ? AlterSemanticTokens.textPrimary
                          : AlterSemanticTokens.textDisabled,
                    ),
                  ),
                ),
              ] else ...[
                for (int i = 0; i < foods.length; i++) ...[
                  if (i > 0) const SizedBox(height: 8),
                  _buildRoutineItem(
                    food: foods[i],
                    targetMap: targetMap,
                    nutrientMap: nutrientMap,
                  ),
                ],
              ],
            ],
          ),
        );
      },
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

                            final String amountText =
                                '${percent.round()}% ($formatYield / $formatTarget $unit)';

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${nutrient.displayName}: Planned ',
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
                      _buildListSection(
                        frequency: TrackingFrequency.daily,
                        title: 'Daily targets',
                        subtitle:
                            'Supports nutrients with faster biological turnover.',
                        foods: dailyFoods,
                        targetMap: state.targetMap,
                        nutrientMap: state.nutrientMap,
                        isFilterActive: widget.selectedNutrientKey != null,
                      ),

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
                      _buildListSection(
                        frequency: TrackingFrequency.weekly,
                        title: 'Weekly targets',
                        subtitle:
                            'Supports nutrients with longer biological half-lives.',
                        foods: weeklyFoods,
                        targetMap: state.targetMap,
                        nutrientMap: state.nutrientMap,
                        isFilterActive: widget.selectedNutrientKey != null,
                      ),

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
