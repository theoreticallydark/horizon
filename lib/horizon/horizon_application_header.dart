import 'package:flutter/material.dart';
import '../alter/alter.dart';

class HorizonApplicationHeader extends StatelessWidget {
  final int currentIndex;
  final VoidCallback? onProfileTap;
  final VoidCallback? onStreakTap;

  const HorizonApplicationHeader({
    super.key,
    required this.currentIndex,
    this.onProfileTap,
    this.onStreakTap,
  });

  @override
  Widget build(BuildContext context) {
    switch (currentIndex) {
      case 0:
        // Track Page Header
        return ApplicationHeader(
          title: 'Today',
          subtitle: '0/2300 calories • 0/120g protein',
          hasStyleButton: true,
          hasActionOne: false,
          hasActionTwo: false,
          hasProfileAction: true,
          onProfileTap: onProfileTap,
          onStyleButtonTap: onStreakTap,
        );
      case 1:
        // Stats Page Header
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
        // Routine Page Header
        return const ApplicationHeader(
          title: 'Plan Routine',
          subtitle: '2300 calories • 120g protein',
          hasStyleButton: false,
          hasActionOne: false,
          hasActionTwo: false,
          hasProfileAction: false,
        );
      default:
        return const ApplicationHeader(
          title: 'Horizon',
          subtitle: 'Design System',
        );
    }
  }
}
