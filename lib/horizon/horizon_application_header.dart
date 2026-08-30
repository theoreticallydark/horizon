import 'package:flutter/material.dart';
import '../alter/alter.dart';
import '../data/services/nutrition_tracking_service.dart';
import 'nutrient_map.dart';

class HorizonApplicationHeader extends StatelessWidget {
  final int currentIndex;
  final VoidCallback? onProfileTap;
  final VoidCallback? onStreakTap;
  final String? selectedNutrientKey;
  final ValueChanged<String>? onNutrientTap;
  final bool hideNutrientMap;

  const HorizonApplicationHeader({
    super.key,
    required this.currentIndex,
    this.onProfileTap,
    this.onStreakTap,
    this.selectedNutrientKey,
    this.onNutrientTap,
    this.hideNutrientMap = false,
  });

  @override
  Widget build(BuildContext context) {
    final trackingService = NutritionTrackingService();

    return StreamBuilder<({double consumedCalories, double plannedCalories, double consumedProtein, double plannedProtein})>(
      stream: trackingService.watchTodayTrackHeaderEnergyAndProtein(),
      builder: (context, snapshot) {
        final consumedCal = snapshot.data?.consumedCalories.round() ?? 0;
        final plannedCal = snapshot.data?.plannedCalories.round() ?? 0;
        final consumedProt = snapshot.data?.consumedProtein.round() ?? 0;
        final plannedProt = snapshot.data?.plannedProtein.round() ?? 0;

        String title;
        String subtitle;
        bool hasStyleButton = false;
        bool hasProfileAction = false;
        Widget? slotWidget;

        switch (currentIndex) {
          case 0:
            title = 'Today';
            subtitle = '$consumedCal/$plannedCal calories • $consumedProt/${plannedProt}g protein';
            hasStyleButton = true;
            hasProfileAction = false;
            slotWidget = hideNutrientMap
                ? null
                : NutrientMap(
                    key: const ValueKey('header_nutrient_map'),
                    variant: NutrientMapVariant.trackFullView,
                    selectedNutrientKey: selectedNutrientKey,
                    onNutrientTap: onNutrientTap,
                  );
            break;
          case 1:
            title = 'Stats';
            subtitle = 'Just do it';
            hasStyleButton = true;
            hasProfileAction = false;
            slotWidget = null;
            break;
          case 2:
            title = 'Plan Routine';
            subtitle = '$plannedCal calories • ${plannedProt}g protein';
            hasStyleButton = false;
            hasProfileAction = true;
            slotWidget = hideNutrientMap
                ? null
                : NutrientMap(
                    key: const ValueKey('header_nutrient_map'),
                    variant: NutrientMapVariant.routine,
                    selectedNutrientKey: selectedNutrientKey,
                    onNutrientTap: onNutrientTap,
                  );
            break;
          default:
            title = 'Horizon';
            subtitle = 'Design System';
            break;
        }

        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          child: ApplicationHeader(
            title: title,
            subtitle: subtitle,
            hasStyleButton: hasStyleButton,
            hasActionOne: false,
            hasActionTwo: false,
            hasProfileAction: hasProfileAction,
            onProfileTap: onProfileTap,
            onStyleButtonTap: onStreakTap,
            slot: slotWidget,
          ),
        );
      },
    );
  }
}
