import 'package:flutter/material.dart';
import '../../styles/tokens.dart';

enum BottomNavigationButtonType { primary, secondary }

class BottomNavigationButton extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.0.0';

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
        return AlterSemanticTokens.ui1;
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
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: _backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            color: _iconColor,
            size: 24,
          ),
        ),
      ),
    );
  }
}
