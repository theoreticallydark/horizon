import 'package:flutter/material.dart';
import '../../styles/tokens.dart';
import '../../styles/swatches.dart';

enum ButtonIconGhostType {
  primary,
  secondary,
  red,
}

class ButtonIconGhost extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.1.0'; // Added onLongPress and gesture hooks for tap-and-hold continuous interaction

  final IconData icon;
  final ButtonIconGhostType type;
  final double size;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;

  const ButtonIconGhost({
    super.key,
    required this.icon,
    this.type = ButtonIconGhostType.primary,
    this.size = 24.0,
    this.onTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
  });

  Color get _iconColor {
    switch (type) {
      case ButtonIconGhostType.primary:
        return AlterSemanticTokens.textPrimary; // VariableID:103:9007 (black)
      case ButtonIconGhostType.secondary:
        return AlterSemanticTokens.textSecondary; // VariableID:103:9014 (gray600)
      case ButtonIconGhostType.red:
        return AlterColors.colorsRed600; // VariableID:103:9010 (red600)
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(size / 2),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Icon(
              icon,
              size: size,
              color: _iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
