import 'package:flutter/material.dart';
import '../../styles/tokens.dart';

enum BottomNavigationButtonType { primary, secondary }

class BottomNavigationButton extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.0.1';

  final IconData icon;
  final BottomNavigationButtonType type;
  final VoidCallback? onTap;

  const BottomNavigationButton({
    super.key,
    required this.icon,
    this.type = BottomNavigationButtonType.secondary,
    this.onTap,
  });

  Color get _backgroundColor {
    switch (type) {
      case BottomNavigationButtonType.primary:
        return AlterSemanticTokens.baseBlack;
      case BottomNavigationButtonType.secondary:
        return AlterSemanticTokens.baseGray;
    }
  }

  Color get _borderColor {
    switch (type) {
      case BottomNavigationButtonType.primary:
        return AlterSemanticTokens.stroke1000;
      case BottomNavigationButtonType.secondary:
        return AlterSemanticTokens.stroke100;
    }
  }

  Color get _iconColor {
    switch (type) {
      case BottomNavigationButtonType.primary:
        return AlterSemanticTokens.textInverse;
      case BottomNavigationButtonType.secondary:
        return AlterSemanticTokens.textPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 72,
        height: 72,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(30),
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
