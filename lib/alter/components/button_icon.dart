import 'package:flutter/material.dart';
import '../styles/tokens.dart';

enum ButtonIconType { gray, white, primary }

class ButtonIcon extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.0.0';

  final IconData icon;
  final ButtonIconType type;
  final VoidCallback? onTap;

  const ButtonIcon({
    super.key,
    this.icon = Icons.favorite_border,
    this.type = ButtonIconType.gray,
    this.onTap,
  });

  Color get _backgroundColor {
    switch (type) {
      case ButtonIconType.gray:
        return AlterSemanticTokens.baseGray;
      case ButtonIconType.white:
        return AlterSemanticTokens.baseWhite;
      case ButtonIconType.primary:
        return AlterSemanticTokens.baseBlack;
    }
  }

  Color get _borderColor {
    switch (type) {
      case ButtonIconType.gray:
      case ButtonIconType.white:
        return AlterSemanticTokens.stroke100;
      case ButtonIconType.primary:
        return AlterSemanticTokens.stroke1000;
    }
  }

  Color get _iconColor {
    switch (type) {
      case ButtonIconType.gray:
      case ButtonIconType.white:
        return AlterSemanticTokens.textPrimary;
      case ButtonIconType.primary:
        return AlterSemanticTokens.textInverse;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _borderColor,
            width: 1,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            color: _iconColor,
            size: 28,
          ),
        ),
      ),
    );
  }
}
