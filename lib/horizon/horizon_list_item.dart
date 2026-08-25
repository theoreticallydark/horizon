import 'package:flutter/material.dart' hide Checkbox;
import '../alter/alter.dart';

enum HorizonListItemHost {
  trackDaily,
  trackWeekly,
  routine,
  add,
  trackDailyChecked,
  trackWeeklyChecked,
  routineRemove,
  addIsFavorite,
}

class HorizonListItem extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.0.0';

  final HorizonListItemHost host;
  final String title;
  final String? subtitle;
  final bool isChecked;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onLeftActionTap;
  final VoidCallback? onRightActionTap;
  final ValueChanged<CheckboxState>? onCheckboxChanged;
  final ValueChanged<ToggleIconState>? onFavoriteChanged;

  const HorizonListItem({
    super.key,
    required this.title,
    this.host = HorizonListItemHost.trackDaily,
    this.subtitle,
    this.isChecked = false,
    this.isFavorite = false,
    this.onTap,
    this.onLeftActionTap,
    this.onRightActionTap,
    this.onCheckboxChanged,
    this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    switch (host) {
      // 1. Host = Track Daily (no subtitle, no left slot, right slot one is checkbox)
      case HorizonListItemHost.trackDaily:
        return ListItem(
          title: title,
          hasSubtitle: false,
          hasLeftSlot: false,
          hasRightSlotTwo: false,
          hasRightSlotOne: true,
          rightSlotOne: Checkbox(
            state: isChecked ? CheckboxState.checked : CheckboxState.unchecked,
            onChanged: onCheckboxChanged,
          ),
          onTap: onTap,
        );

      // 2. Host = Track Daily Checked
      case HorizonListItemHost.trackDailyChecked:
        return ListItem(
          title: title,
          hasSubtitle: false,
          hasLeftSlot: false,
          hasRightSlotTwo: false,
          hasRightSlotOne: true,
          rightSlotOne: Checkbox(
            state: CheckboxState.checked,
            onChanged: onCheckboxChanged,
          ),
          onTap: onTap,
        );

      // 3. Host = Track Weekly (has subtitle, no left slot, right slot one is checkbox)
      case HorizonListItemHost.trackWeekly:
        return ListItem(
          title: title,
          subtitle: subtitle ?? '',
          hasSubtitle: true,
          hasLeftSlot: false,
          hasRightSlotTwo: false,
          hasRightSlotOne: true,
          rightSlotOne: Checkbox(
            state: isChecked ? CheckboxState.checked : CheckboxState.unchecked,
            onChanged: onCheckboxChanged,
          ),
          onTap: onTap,
        );

      // 4. Host = Track Weekly Checked
      case HorizonListItemHost.trackWeeklyChecked:
        return ListItem(
          title: title,
          subtitle: subtitle ?? '',
          hasSubtitle: true,
          hasLeftSlot: false,
          hasRightSlotTwo: false,
          hasRightSlotOne: true,
          rightSlotOne: Checkbox(
            state: CheckboxState.checked,
            onChanged: onCheckboxChanged,
          ),
          onTap: onTap,
        );

      // 5. Host = Routine (has subtitle, left slot is secondary remove_circle_outline, right slot one is add_box)
      case HorizonListItemHost.routine:
        return ListItem(
          title: title,
          subtitle: subtitle ?? '',
          hasSubtitle: true,
          hasLeftSlot: true,
          leftSlot: ButtonIconGhost(
            icon: Icons.remove_circle_outline,
            type: ButtonIconGhostType.secondary,
            onTap: onLeftActionTap,
          ),
          hasRightSlotTwo: false,
          hasRightSlotOne: true,
          rightSlotOne: ButtonIconGhost(
            icon: Icons.add_box_outlined,
            type: ButtonIconGhostType.primary,
            onTap: onRightActionTap,
          ),
          onTap: onTap,
        );

      // 6. Host = Routine Remove (has subtitle, left slot is RED remove_circle_outline, right slot one is add_box)
      case HorizonListItemHost.routineRemove:
        return ListItem(
          title: title,
          subtitle: subtitle ?? '',
          hasSubtitle: true,
          hasLeftSlot: true,
          leftSlot: ButtonIconGhost(
            icon: Icons.remove_circle_outline,
            type: ButtonIconGhostType.red,
            onTap: onLeftActionTap,
          ),
          hasRightSlotTwo: false,
          hasRightSlotOne: true,
          rightSlotOne: ButtonIconGhost(
            icon: Icons.add_box_outlined,
            type: ButtonIconGhostType.primary,
            onTap: onRightActionTap,
          ),
          onTap: onTap,
        );

      // 7. Host = Add (has subtitle, left slot is unchecked toggle_icon favorite, right slot one is add_circle)
      case HorizonListItemHost.add:
        return ListItem(
          title: title,
          subtitle: subtitle ?? '',
          hasSubtitle: true,
          hasLeftSlot: true,
          leftSlot: ToggleIcon(
            state: isFavorite ? ToggleIconState.checked : ToggleIconState.unchecked,
            onChanged: onFavoriteChanged,
          ),
          hasRightSlotTwo: false,
          hasRightSlotOne: true,
          rightSlotOne: ButtonIconGhost(
            icon: Icons.add_circle_outline,
            type: ButtonIconGhostType.primary,
            onTap: onRightActionTap,
          ),
          onTap: onTap,
        );

      // 8. Host = Add isFavorite (has subtitle, left slot is CHECKED toggle_icon favorite, right slot one is add_circle)
      case HorizonListItemHost.addIsFavorite:
        return ListItem(
          title: title,
          subtitle: subtitle ?? '',
          hasSubtitle: true,
          hasLeftSlot: true,
          leftSlot: ToggleIcon(
            state: ToggleIconState.checked,
            onChanged: onFavoriteChanged,
          ),
          hasRightSlotTwo: false,
          hasRightSlotOne: true,
          rightSlotOne: ButtonIconGhost(
            icon: Icons.add_circle_outline,
            type: ButtonIconGhostType.primary,
            onTap: onRightActionTap,
          ),
          onTap: onTap,
        );
    }
  }
}
