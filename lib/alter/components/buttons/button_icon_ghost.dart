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
  static const String version = '1.0.0';

  final IconData icon;
  final ButtonIconGhostType type;
  final double size;
  final VoidCallback? onTap;

  const ButtonIconGhost({
    super.key,
    required this.icon,
    this.type = ButtonIconGhostType.primary,
    this.size = 24.0,
    this.onTap,
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
    return InkWell(
      onTap: onTap,
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
    );
  }
}
