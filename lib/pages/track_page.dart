import 'package:flutter/material.dart';
import '../alter/alter.dart';
import '../data/models/food_source_item.dart';
import '../data/models/track_record.dart';
import '../data/services/nutrition_tracking_service.dart';
import '../horizon/horizon_list_item.dart';
import '../horizon/horizon_title_bar.dart';

class TrackPage extends StatelessWidget {
  final String? selectedNutrientKey;

  const TrackPage({
    super.key,
    this.selectedNutrientKey,
  });

  bool _foodProvidesSelectedNutrient(
    TrackedFoodEntry entry,
    Map<String, FoodSourceItem> foodMap,
  ) {
    if (selectedNutrientKey == null) return true;

    final food = foodMap[entry.foodId];
    if (food == null) return true;

    final foodNutrientKeys = {
      for (final n in food.nutrients)
        if (n.amountPer100g > 0 &&
            (n.nutrientKey != 'total_protein' || food.proteinIndex == 1))
          n.nutrientKey
    };

    return foodNutrientKeys.contains(selectedNutrientKey);
  }

  @override
  Widget build(BuildContext context) {
    final trackingService = NutritionTrackingService();

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AlterSemanticTokens.baseWhite,
        borderRadius: BorderRadius.circular(24),
      ),
      child: StreamBuilder<TrackPageState>(
        stream: trackingService.watchTrackPageState(),
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state == null) {
            return const SizedBox.shrink();
          }

          final foodMap = state.foodMap;
          final dailyFoods = state.dailyRecord?.loggedFoods ?? [];
          final weeklyFoods = state.weeklyRecord?.loggedFoods ?? [];

          final filteredDaily = dailyFoods
              .where((f) => _foodProvidesSelectedNutrient(f, foodMap))
              .toList();
          final filteredWeekly = weeklyFoods
              .where((f) => _foodProvidesSelectedNutrient(f, foodMap))
              .toList();

          if (filteredDaily.isEmpty && filteredWeekly.isEmpty) {
            return Center(
              child: Text(
                selectedNutrientKey != null
                    ? 'No logged foods provide the selected nutrient.'
                    : 'No foods in your routine yet.\nAdd foods in the Routine tab to track them here.',
                textAlign: TextAlign.center,
                style: AlterTypography.caption,
              ),
            );
          }

                  return ListView(
                    children: [
                      // Daily Foods Section
                      if (filteredDaily.isNotEmpty) ...[
                        for (int i = 0; i < filteredDaily.length; i++) ...[
                          if (i > 0) const SizedBox(height: 8),
                          Builder(
                            builder: (context) {
                              final item = filteredDaily[i];
                              final isChecked = item.amountConsumedGrams > 0;
                              final targetLabel = '${item.plannedGrams.round()}g';
                              final itemTitle = '${item.foodTitle}, $targetLabel';

                          return HorizonListItem(
                            title: itemTitle,
                            host: HorizonListItemHost.trackDaily,
                            isChecked: isChecked,
                            onCheckboxChanged: (state) {
                              final willCheck = state == CheckboxState.checked;
                              trackingService.toggleDailyFoodChecked(
                                foodId: item.foodId,
                                isChecked: willCheck,
                              );
                            },
                            onTap: () {
                              trackingService.toggleDailyFoodChecked(
                                foodId: item.foodId,
                                isChecked: !isChecked,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ],

                  // Divider and Weekly Goals Section
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
                      title: 'Weekly goals',
                      subtitle:
                          'Supports nutrients that can be stored longer by the body.',
                    ),
                    const SizedBox(height: 16),
                    for (int i = 0; i < weeklyFoods.length; i++) ...[
                      if (i > 0) const SizedBox(height: 8),
                      Builder(
                        builder: (context) {
                          final item = weeklyFoods[i];
                          final target = item.plannedGrams;
                          final step = target > 0 ? target / 7.0 : 50.0;
                          final isChecked = item.amountConsumedGrams >= target && target > 0;

                          final consumedLabel = '${item.amountConsumedGrams.round()}g';
                          final targetLabel = '${target.round()}g';
                          final itemTitle = '${item.foodTitle}, $consumedLabel';
                          final subtitleText = 'Target ($targetLabel)';

                          return HorizonListItem(
                            title: itemTitle,
                            subtitle: subtitleText,
                            host: HorizonListItemHost.trackWeekly,
                            isChecked: isChecked,
                            onRightActionTap: () {
                              // Increases amountConsumed by weeklyTarget / 7
                              trackingService.updateWeeklyFoodIntake(
                                foodId: item.foodId,
                                deltaGrams: step,
                              );
                            },
                            onCheckboxChanged: (state) {
                              // Unchecking reduces amountConsumed by weeklyTarget / 7
                              if (state == CheckboxState.unchecked) {
                                trackingService.updateWeeklyFoodIntake(
                                  foodId: item.foodId,
                                  deltaGrams: -step,
                                );
                              }
                            },
                            onTap: () {
                              if (isChecked) {
                                trackingService.updateWeeklyFoodIntake(
                                  foodId: item.foodId,
                                  deltaGrams: -step,
                                );
                              } else {
                                trackingService.updateWeeklyFoodIntake(
                                  foodId: item.foodId,
                                  deltaGrams: step,
                                );
                              }
                            },
                          );
                        },
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
