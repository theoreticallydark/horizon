import 'package:flutter/material.dart';
import '../../styles/tokens.dart';
import '../../styles/typography.dart';

class BottomNavigationItem extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.0.1';

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;

  const BottomNavigationItem({
    super.key,
    required this.label,
    required this.icon,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isSelected
        ? AlterSemanticTokens.textPrimary
        : AlterSemanticTokens.textSecondary;

    final iconColor = isSelected
        ? AlterSemanticTokens.textPrimary
        : AlterSemanticTokens.ui6;

    final backgroundColor = isSelected
        ? AlterSemanticTokens.ui1
        : Colors.transparent;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        constraints: const BoxConstraints(minWidth: 64),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AlterTypography.caption.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
