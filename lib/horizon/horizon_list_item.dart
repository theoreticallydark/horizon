import 'package:flutter/material.dart' hide Checkbox;
import '../alter/alter.dart';

/// HorizonListItemHost represents the host variants from Figma node `130:4671` (.HorizonListItem)
/// Note: trackDaily/trackWeekly checked states are handled dynamically via isChecked,
/// and add favorite state is handled dynamically via isFavorite.
enum HorizonListItemHost {
  trackDaily,
  trackWeekly,
  routine,
  routineRemove,
  add,
}

class HorizonListItem extends StatelessWidget {
  /// Component version for reference.
  /// v1.7.0: Unified add/addIsFavorite into a single `add` host variant driven dynamically by `isFavorite`.
  static const String version = '1.7.0';

  final HorizonListItemHost host;
  final String title;
  final String? subtitle;
  final bool isChecked;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onLeftActionTap;
  final VoidCallback? onRightActionTap;
  final GestureTapDownCallback? onLeftTapDown;
  final GestureTapUpCallback? onLeftTapUp;
  final GestureTapCancelCallback? onLeftTapCancel;
  final GestureTapDownCallback? onRightTapDown;
  final GestureTapUpCallback? onRightTapUp;
  final GestureTapCancelCallback? onRightTapCancel;
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
    this.onLeftTapDown,
    this.onLeftTapUp,
    this.onLeftTapCancel,
    this.onRightTapDown,
    this.onRightTapUp,
    this.onRightTapCancel,
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
                  onTapDown: onRightTapDown,
                  onTapUp: onRightTapUp,
                  onTapCancel: onRightTapCancel,
                ),
          onTap: onTap,
        );

      // 3. Host = Routine (hasSubtitle: true, leftSlot: secondary remove_circle_outline, rightSlotOne: add_box)
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
            onTapDown: onLeftTapDown,
            onTapUp: onLeftTapUp,
            onTapCancel: onLeftTapCancel,
          ),
          hasRightSlotTwo: false,
          hasRightSlotOne: true,
          rightSlotOne: ButtonIconGhost(
            icon: Icons.add_box_outlined,
            type: ButtonIconGhostType.primary,
            onTap: onRightActionTap,
            onTapDown: onRightTapDown,
            onTapUp: onRightTapUp,
            onTapCancel: onRightTapCancel,
          ),
          onTap: onTap,
        );

      // 4. Host = Routine Remove (hasSubtitle: true, leftSlot: RED remove_circle_outline, rightSlotOne: add_box)
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
            onTapDown: onLeftTapDown,
            onTapUp: onLeftTapUp,
            onTapCancel: onLeftTapCancel,
          ),
          hasRightSlotTwo: false,
          hasRightSlotOne: true,
          rightSlotOne: ButtonIconGhost(
            icon: Icons.add_box_outlined,
            type: ButtonIconGhostType.primary,
            onTap: onRightActionTap,
            onTapDown: onRightTapDown,
            onTapUp: onRightTapUp,
            onTapCancel: onRightTapCancel,
          ),
          onTap: onTap,
        );

      // 5. Host = Add (hasSubtitle: true, leftSlot: ToggleIcon driven by isFavorite, rightSlotOne: add_box)
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
    }
  }
}
