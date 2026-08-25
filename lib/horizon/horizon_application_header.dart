import 'package:flutter/material.dart';
import '../alter/alter.dart';
import 'nutrient_map.dart';

class HorizonApplicationHeader extends StatelessWidget {
  final int currentIndex;
  final VoidCallback? onProfileTap;
  final VoidCallback? onStreakTap;
  final ValueChanged<int>? onNutrientTap;

  const HorizonApplicationHeader({
    super.key,
    required this.currentIndex,
    this.onProfileTap,
    this.onStreakTap,
    this.onNutrientTap,
  });

  @override
  Widget build(BuildContext context) {
    switch (currentIndex) {
      case 0:
        // Track Page Header (with NutrientMap TrackFullView in slot)
        return ApplicationHeader(
          title: 'Today',
          subtitle: '0/2300 calories • 0/120g protein',
          hasStyleButton: true,
          hasActionOne: false,
          hasActionTwo: false,
          hasProfileAction: false,
          onProfileTap: onProfileTap,
          onStyleButtonTap: onStreakTap,
          slot: NutrientMap(
            variant: NutrientMapVariant.trackFullView,
            onNutrientTap: onNutrientTap,
          ),
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
        return ApplicationHeader(
          title: 'Plan Routine',
          subtitle: '2300 calories • 120g protein',
          hasStyleButton: false,
          hasActionOne: false,
          hasActionTwo: false,
          hasProfileAction: true,
          onProfileTap: onProfileTap,
          slot: NutrientMap(
            variant: NutrientMapVariant.routine,
            onNutrientTap: onNutrientTap,
          ),
        );
      default:
        return const ApplicationHeader(
          title: 'Horizon',
          subtitle: 'Design System',
        );
    }
  }
}
