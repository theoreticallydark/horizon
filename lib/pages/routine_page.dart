import 'dart:async';
import 'package:flutter/material.dart';
import '../alter/alter.dart';
import '../data/models/food_source_item.dart';
import '../data/models/nutrient_info.dart';
import '../data/models/user_profile.dart';
import '../data/services/nutrition_tracking_service.dart';
import '../horizon/horizon_list_item.dart';
import '../horizon/horizon_title_bar.dart';

class RoutinePage extends StatefulWidget {
  final Set<String> selectedNutrientKeys;

  const RoutinePage({
    super.key,
    this.selectedNutrientKeys = const {},
  });

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  final NutritionTrackingService _trackingService = NutritionTrackingService();

  // Active timer for continuous increment/decrement during long press
  Timer? _continuousTimer;

  void _startContinuousChange({
    required String foodId,
    required double currentPlannedGrams,
    required double delta,
  }) {
    _continuousTimer?.cancel();
    double currentVal = currentPlannedGrams;

    // Initial step immediately after press
    currentVal = (currentVal + delta);
    if (currentVal < 1.0) currentVal = 1.0;
    _trackingService.updateFoodPlannedTarget(
      foodId: foodId,
      newTargetGrams: currentVal,
    );

    // Continuous tick every 100ms
    _continuousTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (delta < 0 && currentVal <= 1.0) {
        timer.cancel();
        return;
      }
      currentVal = (currentVal + delta);
      if (currentVal < 1.0) currentVal = 1.0;

      _trackingService.updateFoodPlannedTarget(
        foodId: foodId,
        newTargetGrams: currentVal,
      );
    });
  }

  void _stopContinuousChange() {
    _continuousTimer?.cancel();
    _continuousTimer = null;
  }

  /// Checks whether a given food item provides non-zero coverage for all selected nutrients
  bool _foodProvidesSelectedNutrients(FoodSourceItem food) {
    if (widget.selectedNutrientKeys.isEmpty) return true;

    final foodNutrientKeys = {
      for (final n in food.nutrients)
        if (n.amountPer100g > 0 &&
            (n.nutrientKey != 'total_protein' || food.proteinIndex == 1))
          n.nutrientKey
    };

    // If multi-select is active, check if food provides at least one of the selected nutrients
    // (or any of the selected filters)
    return widget.selectedNutrientKeys.any((k) => foodNutrientKeys.contains(k));
  }

  @override
  void dispose() {
    _continuousTimer?.cancel();
    super.dispose();
  }

  /// Computes top 2 or 3 nutrient contribution strings: "'Key' 'coverage%' • ..."
  String _buildNutrientCoverageSubtitle({
    required FoodSourceItem food,
    required UserProfile profile,
    required List<NutrientInfo> allNutrients,
  }) {
    final nutrientMap = {for (var n in allNutrients) n.nutrientKey: n};
    final List<MapEntry<String, double>> topList = [];

    final portionGrams = food.plannedDailyGrams;

    for (final nutrientVal in food.nutrients) {
      // Exclude energy from subtitle list
      if (nutrientVal.nutrientKey == 'energy') continue;

      // Protein qualification requires food to be a complete protein source (proteinIndex == 1)
      if (nutrientVal.nutrientKey == 'total_protein' && food.proteinIndex != 1) continue;

      final nutrientInfo = nutrientMap[nutrientVal.nutrientKey];
      if (nutrientInfo == null || !nutrientInfo.isTracked) continue;

      final target = nutrientInfo.calculateEffectiveTarget(profile);
      if (target <= 0) continue;

      final yieldAmount = (portionGrams / 100.0) * nutrientVal.amountPer100g;
      final coveragePercent = (yieldAmount / target) * 100.0;

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
    required UserProfile profile,
    required List<NutrientInfo> allNutrients,
  }) {
    final isDaily = food.frequency == TrackingFrequency.daily;
    final targetGrams = isDaily ? food.plannedDailyGrams : food.plannedWeeklyGrams;
    final targetLabel = '${targetGrams.round()}g';
    final itemTitle = '${food.title}, $targetLabel';
    final subtitleText = _buildNutrientCoverageSubtitle(
      food: food,
      profile: profile,
      allNutrients: allNutrients,
    );

    final isMinima = food.plannedDailyGrams <= 1.0;
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
          final updated = (food.plannedDailyGrams - 1.0).clamp(1.0, 99999.0);
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
            currentPlannedGrams: food.plannedDailyGrams,
            delta: -1.0,
          );
        }
      },
      onLeftTapUp: (_) => _stopContinuousChange(),
      onLeftTapCancel: () => _stopContinuousChange(),

      // RIGHT ACTION (Increment)
      onRightActionTap: () {
        final updated = (food.plannedDailyGrams + 1.0).clamp(1.0, 99999.0);
        _trackingService.updateFoodPlannedTarget(
          foodId: food.foodId,
          newTargetGrams: updated,
        );
      },
      onRightTapDown: (_) {
        _startContinuousChange(
          foodId: food.foodId,
          currentPlannedGrams: food.plannedDailyGrams,
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
      child: StreamBuilder<UserProfile?>(
        stream: _trackingService.watchUserProfile(),
        builder: (context, profileSnapshot) {
          final profile = profileSnapshot.data ?? UserProfile();

          return StreamBuilder<List<NutrientInfo>>(
            stream: _trackingService.watchNutrientInfos(),
            builder: (context, nutrientSnapshot) {
              final allNutrients = nutrientSnapshot.data ?? [];

              return StreamBuilder<List<FoodSourceItem>>(
                stream: _trackingService.watchTrackedRoutineFoods(),
                builder: (context, foodSnapshot) {
                  final routineFoods = foodSnapshot.data ?? [];
                  final filteredFoods = routineFoods.where(_foodProvidesSelectedNutrients).toList();

                  if (filteredFoods.isEmpty) {
                    return Center(
                      child: Text(
                        widget.selectedNutrientKeys.isNotEmpty
                            ? 'No foods in your routine provide the selected nutrients.'
                            : 'No foods in your routine yet.\nAdd foods to build your daily & weekly routine.',
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
                      // Daily Targets Section
                      if (dailyFoods.isNotEmpty) ...[
                        const HorizonTitleBar(
                          title: 'Daily targets',
                          subtitle:
                              'Supports nutrients requiring continuous daily supply.',
                        ),
                        const SizedBox(height: 16),
                        for (int i = 0; i < dailyFoods.length; i++) ...[
                          if (i > 0) const SizedBox(height: 8),
                          _buildRoutineItem(
                            food: dailyFoods[i],
                            profile: profile,
                            allNutrients: allNutrients,
                          ),
                        ],
                      ],

                      // Divider and Weekly Targets Section
                      if (weeklyFoods.isNotEmpty) ...[
                        if (dailyFoods.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: AlterColors.colorsGray100,
                          ),
                          const SizedBox(height: 16),
                        ],
                        const HorizonTitleBar(
                          title: 'Weekly targets',
                          subtitle:
                              'Supports nutrients that can be stored longer by the body.',
                        ),
                        const SizedBox(height: 16),
                        for (int i = 0; i < weeklyFoods.length; i++) ...[
                          if (i > 0) const SizedBox(height: 8),
                          _buildRoutineItem(
                            food: weeklyFoods[i],
                            profile: profile,
                            allNutrients: allNutrients,
                          ),
                        ],
                      ],

                      // Bottom padding offset for bottom navigation bar
                      const SizedBox(height: 120),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
