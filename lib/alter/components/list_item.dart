import 'package:flutter/material.dart' hide Checkbox;
import '../styles/tokens.dart';
import '../styles/typography.dart';
import 'buttons/button_icon_ghost.dart';
import 'selects/checkbox.dart';
import 'selects/toggle_icon.dart';

class ListItem extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.0.0';

  final String title;
  final String? subtitle;
  final bool hasSubtitle;
  final bool hasLeftSlot;
  final bool hasRightSlotOne;
  final bool hasRightSlotTwo;
  final Widget? leftSlot;
  final Widget? rightSlotOne;
  final Widget? rightSlotTwo;
  final VoidCallback? onTap;

  const ListItem({
    super.key,
    this.title = 'Title of the list item',
    this.subtitle = 'Subtitle of the list item',
    this.hasSubtitle = true,
    this.hasLeftSlot = true,
    this.hasRightSlotOne = true,
    this.hasRightSlotTwo = true,
    this.leftSlot,
    this.rightSlotOne,
    this.rightSlotTwo,
    this.onTap,
  });

  Widget _buildLeftSlot() {
    return leftSlot ??
        const ButtonIconGhost(
          icon: Icons.remove_circle_outline,
          type: ButtonIconGhostType.secondary,
        );
  }

  Widget _buildRightSlotOne() {
    return rightSlotOne ??
        const Checkbox(
          state: CheckboxState.unchecked,
        );
  }

  Widget _buildRightSlotTwo() {
    return rightSlotTwo ??
        const ToggleIcon(
          state: ToggleIconState.unchecked,
        );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Container (Left slot + Title/Subtitle)
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (hasLeftSlot) ...[
                    _buildLeftSlot(),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AlterTypography.h2.copyWith(
                            color: AlterSemanticTokens.textPrimary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        if (hasSubtitle && subtitle != null && subtitle!.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AlterTypography.caption.copyWith(
                              color: AlterSemanticTokens.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Right slots
            if (hasRightSlotTwo || hasRightSlotOne) ...[
              const SizedBox(width: 16),
              if (hasRightSlotTwo) _buildRightSlotTwo(),
              if (hasRightSlotTwo && hasRightSlotOne) const SizedBox(width: 16),
              if (hasRightSlotOne) _buildRightSlotOne(),
            ],
          ],
        ),
      ),
    );
  }
}
