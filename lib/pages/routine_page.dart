import 'dart:async';
import 'package:flutter/material.dart';
import '../alter/alter.dart';
import '../data/models/food_source_item.dart';
import '../data/models/nutrient_info.dart';
import '../data/services/nutrition_tracking_service.dart';
import '../horizon/horizon_list_item.dart';
import '../horizon/horizon_title_bar.dart';

class RoutinePage extends StatefulWidget {
  final String? selectedNutrientKey;

  const RoutinePage({
    super.key,
    this.selectedNutrientKey,
  });

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  final NutritionTrackingService _trackingService = NutritionTrackingService();

  // Active timer for continuous increment/decrement during long press
  Timer? _continuousTimer;
  String? _activeFoodId;
  double? _activeTargetGrams;

  void _startContinuousChange({
    required String foodId,
    required double currentPlannedGrams,
    required double delta,
  }) {
    _continuousTimer?.cancel();
    _activeFoodId = foodId;
    _activeTargetGrams = currentPlannedGrams;

    // Step immediately
    _activeTargetGrams = (_activeTargetGrams! + delta);
    if (_activeTargetGrams! < 1.0) _activeTargetGrams = 1.0;
    setState(() {}); // Instant visual feedback

    // Continuous step every 80ms locally without flooding disk I/O
    _continuousTimer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      if (delta < 0 && _activeTargetGrams! <= 1.0) {
        timer.cancel();
        return;
      }
      _activeTargetGrams = (_activeTargetGrams! + delta);
      if (_activeTargetGrams! < 1.0) _activeTargetGrams = 1.0;
      setState(() {});
    });
  }

  void _stopContinuousChange() {
    _continuousTimer?.cancel();
    _continuousTimer = null;

    // Flush single write transaction to Isar on release
    if (_activeFoodId != null && _activeTargetGrams != null) {
      _trackingService.updateFoodPlannedTarget(
        foodId: _activeFoodId!,
        newTargetGrams: _activeTargetGrams!,
      );
    }
    _activeFoodId = null;
    _activeTargetGrams = null;
  }

  /// Checks whether a given food item provides non-zero coverage for the selected nutrient
  bool _foodProvidesSelectedNutrient(FoodSourceItem food) {
    if (widget.selectedNutrientKey == null) return true;

    final foodNutrientKeys = {
      for (final n in food.nutrients)
        if (n.amountPer100g > 0 &&
            (n.nutrientKey != 'total_protein' || food.proteinIndex == 1))
          n.nutrientKey
    };

    return foodNutrientKeys.contains(widget.selectedNutrientKey);
  }

  @override
  void dispose() {
    _continuousTimer?.cancel();
    super.dispose();
  }

  /// Computes top 2 or 3 nutrient contribution strings: "'Key' 'coverage%' • ..."
  /// Uses O(1) in-memory targetMap and nutrientMap for zero re-computation overhead.
  String _buildNutrientCoverageSubtitle({
    required FoodSourceItem food,
    required double portionGrams,
    required Map<String, double> targetMap,
    required Map<String, NutrientInfo> nutrientMap,
  }) {
    final List<MapEntry<String, double>> topList = [];

    for (final nutrientVal in food.nutrients) {
      // Exclude energy from subtitle list
      if (nutrientVal.nutrientKey == 'energy') continue;

      // Protein qualification requires food to be a complete protein source (proteinIndex == 1)
      if (nutrientVal.nutrientKey == 'total_protein' && food.proteinIndex != 1) continue;

      final nutrientInfo = nutrientMap[nutrientVal.nutrientKey];
      if (nutrientInfo == null || !nutrientInfo.isTracked) continue;

      final target = targetMap[nutrientVal.nutrientKey] ?? 0.0;
      if (target <= 0) continue;

      final dailyYield = (portionGrams / 100.0) * nutrientVal.amountPer100g;
      // If nutrient frequency is weekly, compare weekly yield (dailyYield * 7) against weekly target
      final plannedYield = nutrientInfo.frequency == TrackingFrequency.weekly
          ? dailyYield * 7.0
          : dailyYield;

      final coveragePercent = (plannedYield / target) * 100.0;

      if (coveragePercent > 0.0) {
        final keyLabel = nutrientInfo.shortKey ?? nutrientInfo.displayName;
        topList.add(MapEntry(keyLabel, coveragePercent));
      }
    }

    // Sort by highest coverage percentage first
    topList.sort((a, b) => b.value.compareTo(a.value));

    // Take top 3
    final selected = topList.take(3).toList();
    if (selected.isEmpty) {
      return '';
    }

    return selected
        .map((e) => '${e.key} ${e.value.round()}%')
        .join(' • ');
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
    final subtitleText = _buildNutrientCoverageSubtitle(
      food: food,
      portionGrams: currentGrams,
      targetMap: targetMap,
      nutrientMap: nutrientMap,
    );

    final isMinima = currentGrams <= 1.0;
    final hostVariant = isMinima
        ? HorizonListItemHost.routineRemove
        : HorizonListItemHost.routine;

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
          // Single tap decrements target by 1g
          final updated = (currentGrams - 1.0).clamp(1.0, 99999.0);
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
            delta: -1.0,
          );
        }
      },
      onLeftTapUp: (_) => _stopContinuousChange(),
      onLeftTapCancel: () => _stopContinuousChange(),

      // RIGHT ACTION (Increment)
      onRightActionTap: () {
        final updated = (currentGrams + 1.0).clamp(1.0, 99999.0);
        _trackingService.updateFoodPlannedTarget(
          foodId: food.foodId,
          newTargetGrams: updated,
        );
      },
      onRightTapDown: (_) {
        _startContinuousChange(
          foodId: food.foodId,
          currentPlannedGrams: currentGrams,
          delta: 1.0,
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AlterSemanticTokens.baseWhite,
        borderRadius: BorderRadius.circular(24),
      ),
      child: StreamBuilder<RoutinePageState>(
        stream: _trackingService.watchRoutinePageState(),
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state == null) {
            return const SizedBox.shrink();
          }

          final routineFoods = state.routineFoods;
          final filteredFoods = routineFoods.where(_foodProvidesSelectedNutrient).toList();

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
                        'Supports nutrients requiring continuous daily supply.',
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
    );
  }
}
