import 'package:flutter/material.dart';
import '../alter/alter.dart';

class HorizonBottomNavigationBarAction extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onItemTapped;
  final VoidCallback? onPrimaryActionTap;

  const HorizonBottomNavigationBarAction({
    super.key,
    required this.selectedIndex,
    this.onItemTapped,
    this.onPrimaryActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBarAction(
      type: BottomNavigationBarActionType.defaultAction,
      selectedIndex: selectedIndex,
      items: const [
        BottomNavigationItemData(
          label: 'Track',
          icon: Icons.track_changes_outlined,
        ),
        BottomNavigationItemData(
          label: 'Stats',
          icon: Icons.dataset_outlined,
        ),
        BottomNavigationItemData(
          label: 'Routine',
          icon: Icons.egg_outlined,
        ),
      ],
      primaryActionIcon: Icons.add_circle_outline,
      primaryActionType: BottomNavigationButtonType.secondary,
      onItemTapped: onItemTapped,
      onPrimaryActionTap: onPrimaryActionTap,
    );
  }
}
