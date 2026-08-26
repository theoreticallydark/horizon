import 'package:flutter/material.dart';
import '../alter/alter.dart';
import '../data/services/nutrition_tracking_service.dart';
import 'nutrient_map.dart';

class HorizonApplicationHeader extends StatelessWidget {
  final int currentIndex;
  final VoidCallback? onProfileTap;
  final VoidCallback? onStreakTap;
  final Set<String> selectedNutrientKeys;
  final ValueChanged<String>? onNutrientTap;

  const HorizonApplicationHeader({
    super.key,
    required this.currentIndex,
    this.onProfileTap,
    this.onStreakTap,
    this.selectedNutrientKeys = const {},
    this.onNutrientTap,
  });

  @override
  Widget build(BuildContext context) {
    final trackingService = NutritionTrackingService();

    switch (currentIndex) {
      case 0:
        // Track Page Header (with NutrientMap TrackFullView in slot)
        return StreamBuilder<({double calories, double protein})>(
          stream: trackingService.watchPlannedRoutineEnergyAndProtein(),
          builder: (context, snapshot) {
            final plannedCal = snapshot.data?.calories.round() ?? 0;
            final plannedProt = snapshot.data?.protein.round() ?? 0;

            return ApplicationHeader(
              title: 'Today',
              subtitle: '0/$plannedCal calories • 0/${plannedProt}g protein',
              hasStyleButton: true,
              hasActionOne: false,
              hasActionTwo: false,
              hasProfileAction: false,
              onProfileTap: onProfileTap,
              onStyleButtonTap: onStreakTap,
              slot: NutrientMap(
                variant: NutrientMapVariant.trackFullView,
                selectedNutrientKeys: selectedNutrientKeys,
                onNutrientTap: onNutrientTap,
              ),
            );
          },
        );
      case 1:
        // Stats Page Header (no slot)
        return ApplicationHeader(
          title: 'Stats',
          subtitle: 'Just do it',
          hasStyleButton: true,
          hasActionOne: false,
          hasActionTwo: false,
          hasProfileAction: false,
          onStyleButtonTap: onStreakTap,
        );
      case 2:
        // Routine Page Header (with NutrientMap Routine in slot)
        return StreamBuilder<({double calories, double protein})>(
          stream: trackingService.watchPlannedRoutineEnergyAndProtein(),
          builder: (context, snapshot) {
            final calories = snapshot.data?.calories.round() ?? 0;
            final protein = snapshot.data?.protein.round() ?? 0;
            final subtitleText = '$calories calories • ${protein}g protein';

            return ApplicationHeader(
              title: 'Plan Routine',
              subtitle: subtitleText,
              hasStyleButton: false,
              hasActionOne: false,
              hasActionTwo: false,
              hasProfileAction: true,
              onProfileTap: onProfileTap,
              slot: NutrientMap(
                variant: NutrientMapVariant.routine,
                selectedNutrientKeys: selectedNutrientKeys,
                onNutrientTap: onNutrientTap,
              ),
            );
          },
        );
      default:
        return const ApplicationHeader(
          title: 'Horizon',
          subtitle: 'Design System',
        );
    }
  }
}

