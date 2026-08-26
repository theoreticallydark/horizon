import 'package:flutter/material.dart' hide Checkbox;
import '../alter/alter.dart';

/// HorizonListItemHost represents the host variants from Figma node `130:4671` (.HorizonListItem)
/// Note: trackDailyChecked is handled dynamically via isChecked on trackDaily.
enum HorizonListItemHost {
  trackDaily,
  trackWeekly,
  trackWeeklyChecked,
  routine,
  routineRemove,
  add,
  addIsFavorite,
}

class HorizonListItem extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.4.0'; // trackWeekly dynamically renders ButtonIconGhost (add_box) or Checkbox (checked) based on isChecked

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
      // 1. Host = Track Daily (hasSubtitle: false, hasLeftSlot: false, rightSlotOne: Checkbox with state based on isChecked)
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

      // 2. Host = Track Weekly (hasSubtitle: true, hasLeftSlot: false, rightSlotOne: ButtonIconGhost(add_box) or Checkbox checked if isChecked)
      case HorizonListItemHost.trackWeekly:
        return ListItem(
          title: title,
          subtitle: subtitle ?? '',
          hasSubtitle: true,
          hasLeftSlot: false,
          hasRightSlotTwo: false,
          hasRightSlotOne: true,
          rightSlotOne: isChecked
              ? Checkbox(
                  state: CheckboxState.checked,
                  onChanged: onCheckboxChanged,
                )
              : ButtonIconGhost(
                  icon: Icons.add_box_outlined,
                  type: ButtonIconGhostType.primary,
                  onTap: onRightActionTap,
                ),
          onTap: onTap,
        );

      // 3. Host = Track Weekly Checked (hasSubtitle: true, hasLeftSlot: false, rightSlotOne: Checkbox Checked)
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

      // 4. Host = Routine (hasSubtitle: true, leftSlot: secondary remove_circle_outline, rightSlotOne: add_box)
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

      // 5. Host = Routine Remove (hasSubtitle: true, leftSlot: RED remove_circle_outline, rightSlotOne: add_box)
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

      // 6. Host = Add (hasSubtitle: true, leftSlot: ToggleIcon unchecked, rightSlotOne: add_box)
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
            icon: Icons.add_box_outlined,
            type: ButtonIconGhostType.primary,
            onTap: onRightActionTap,
          ),
          onTap: onTap,
        );

      // 7. Host = Add Is Favorite (hasSubtitle: true, leftSlot: ToggleIcon checked, rightSlotOne: add_box)
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
            icon: Icons.add_box_outlined,
            type: ButtonIconGhostType.primary,
            onTap: onRightActionTap,
          ),
          onTap: onTap,
        );
    }
  }
}
