import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart';
import 'bottom_navigation_button.dart';

enum BottomNavigationBarActionType { defaultAction, save }

class BottomNavigationBarAction extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.0.2';

  final BottomNavigationBarActionType type;
  final int selectedIndex;
  final List<BottomNavigationItemData> items;
  final ValueChanged<int>? onItemTapped;

  // Primary Action Button (Default Type: Add, Save Type: Check/Save)
  final VoidCallback? onPrimaryActionTap;
  final IconData primaryActionIcon;

  // Additional Action Buttons (Save Type)
  final VoidCallback? onSecondaryActionOneTap;
  final IconData secondaryActionOneIcon;
  final VoidCallback? onSecondaryActionTwoTap;
  final IconData secondaryActionTwoIcon;

  const BottomNavigationBarAction({
    super.key,
    this.type = BottomNavigationBarActionType.defaultAction,
    this.selectedIndex = 0,
    this.items = const [
      BottomNavigationItemData(label: 'Home', icon: Icons.home_outlined),
      BottomNavigationItemData(label: 'Search', icon: Icons.search),
      BottomNavigationItemData(label: 'Profile', icon: Icons.person_outline),
    ],
    this.onItemTapped,
    this.onPrimaryActionTap,
    this.primaryActionIcon = Icons.add,
    this.onSecondaryActionOneTap,
    this.secondaryActionOneIcon = Icons.favorite_border,
    this.onSecondaryActionTwoTap,
    this.secondaryActionTwoIcon = Icons.search,
  });

  @override
  Widget build(BuildContext context) {
    if (type == BottomNavigationBarActionType.defaultAction) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AlterBottomNavigationBar(
            selectedIndex: selectedIndex,
            items: items,
            onItemTapped: onItemTapped,
          ),
          const SizedBox(width: 10),
          BottomNavigationButton(
            icon: primaryActionIcon,
            type: BottomNavigationButtonType.primary,
            onTap: onPrimaryActionTap,
          ),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BottomNavigationButton(
            icon: primaryActionIcon,
            type: BottomNavigationButtonType.primary,
            onTap: onPrimaryActionTap,
          ),
          const SizedBox(width: 10),
          BottomNavigationButton(
            icon: secondaryActionOneIcon,
            type: BottomNavigationButtonType.secondary,
            onTap: onSecondaryActionOneTap,
          ),
          const SizedBox(width: 10),
          BottomNavigationButton(
            icon: secondaryActionTwoIcon,
            type: BottomNavigationButtonType.secondary,
            onTap: onSecondaryActionTwoTap,
          ),
        ],
      );
    }
  }
}
