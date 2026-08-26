import 'package:flutter/material.dart';
import '../alter/alter.dart';
import '../data/models/track_record.dart';
import '../data/services/nutrition_tracking_service.dart';
import '../horizon/horizon_list_item.dart';
import '../horizon/horizon_title_bar.dart';

class TrackPage extends StatelessWidget {
  const TrackPage({super.key});

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
      child: StreamBuilder<TrackRecordDaily?>(
        stream: trackingService.watchTodayDailyRecord(),
        builder: (context, dailySnapshot) {
          final dailyRecord = dailySnapshot.data;
          final dailyFoods = dailyRecord?.loggedFoods ?? [];

          return StreamBuilder<TrackRecordWeekly?>(
            stream: trackingService.watchCurrentWeeklyRecord(),
            builder: (context, weeklySnapshot) {
              final weeklyRecord = weeklySnapshot.data;
              final weeklyFoods = weeklyRecord?.loggedFoods ?? [];

              if (dailyFoods.isEmpty && weeklyFoods.isEmpty) {
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
                  // Daily Foods Section
                  if (dailyFoods.isNotEmpty) ...[
                    for (int i = 0; i < dailyFoods.length; i++) ...[
                      if (i > 0) const SizedBox(height: 8),
                      Builder(
                        builder: (context) {
                          final item = dailyFoods[i];
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
          );
        },
      ),
    );
  }
}
