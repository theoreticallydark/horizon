import 'package:flutter/material.dart';
import '../alter/alter.dart';
import '../data/models/food_source_item.dart';
import '../data/models/nutrient_info.dart';
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
          final dailyFoods = (state.dailyRecord?.loggedFoods ?? [])
              .where((f) {
                final food = foodMap[f.foodId];
                final freq = food?.frequency ?? f.frequency;
                return freq == TrackingFrequency.daily;
              })
              .toList();
          final weeklyFoods = (state.weeklyRecord?.loggedFoods ?? [])
              .where((f) {
                final food = foodMap[f.foodId];
                final freq = food?.frequency ?? f.frequency;
                return freq == TrackingFrequency.weekly;
              })
              .toList();

          final filteredDaily = dailyFoods
              .where((f) => _foodProvidesSelectedNutrient(f, foodMap))
              .toList();
          final filteredWeekly = weeklyFoods
              .where((f) => _foodProvidesSelectedNutrient(f, foodMap))
              .toList();

          if (dailyFoods.isEmpty && weeklyFoods.isEmpty && selectedNutrientKey == null) {
            return const Center(
              child: Text(
                'No foods in your routine yet.\nAdd foods in the Routine tab to track them here.',
                textAlign: TextAlign.center,
                style: AlterTypography.caption,
              ),
            );
          }

          return ListView(
            children: [
              // Filter Header if a nutrient pill is selected
              if (selectedNutrientKey != null &&
                  state.nutrientMap.containsKey(selectedNutrientKey)) ...[
                Builder(
                  builder: (context) {
                    final nutrient = state.nutrientMap[selectedNutrientKey]!;
                    final isWeekly = nutrient.frequency == TrackingFrequency.weekly;
                    final targetVal = state.targetMap[selectedNutrientKey] ?? 0.0;

                    // Calculate total consumed contribution for this nutrient
                    final double consumedTotal;
                    if (isWeekly) {
                      double cVal = 0.0;
                      if (state.weeklyRecord != null) {
                        for (final s in state.weeklyRecord!.nutrientSummaries) {
                          if (s.nutrientKey == selectedNutrientKey) {
                            cVal = s.amountConsumed;
                            break;
                          }
                        }
                      }
                      consumedTotal = cVal;
                    } else {
                      double cVal = 0.0;
                      if (state.dailyRecord != null) {
                        for (final s in state.dailyRecord!.nutrientSummaries) {
                          if (s.nutrientKey == selectedNutrientKey) {
                            cVal = s.amountConsumed;
                            break;
                          }
                        }
                      }
                      consumedTotal = cVal;
                    }

                    final rawUnit = nutrient.unit.isNotEmpty ? nutrient.unit.split('/').first.trim() : '';
                    final unit = rawUnit.replaceAll('RAE', '').trim();
                    final String formatConsumed = consumedTotal >= 10
                        ? consumedTotal.round().toString()
                        : consumedTotal.toStringAsFixed(1);
                    final String formatTarget = targetVal >= 10
                        ? targetVal.round().toString()
                        : targetVal.toStringAsFixed(1);

                    final percent = targetVal > 0 ? (consumedTotal / targetVal) * 100.0 : 0.0;
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
                    final amountText = '$formatConsumed/$formatTarget$unit';

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
              if (filteredWeekly.isNotEmpty) ...[
                if (filteredDaily.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: AlterSemanticTokens.stroke100,
                  ),
                  const SizedBox(height: 24),
                ],
                const HorizonTitleBar(
                  title: 'Weekly goals',
                  subtitle:
                      'Supports nutrients that can be stored longer by the body.',
                ),
                const SizedBox(height: 16),
                for (int i = 0; i < filteredWeekly.length; i++) ...[
                  if (i > 0) const SizedBox(height: 8),
                  Builder(
                    builder: (context) {
                      final item = filteredWeekly[i];
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
