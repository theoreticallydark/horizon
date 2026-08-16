import 'package:flutter/material.dart';
import '../../styles/tokens.dart';
import '../../styles/typography.dart';

class BottomNavigationItem extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.0.0';

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
    final color = isSelected
        ? AlterSemanticTokens.textPrimary
        : AlterSemanticTokens.textSecondary;

    final textStyle = isSelected
        ? AlterTypography.captionBold.copyWith(color: color)
        : AlterTypography.caption.copyWith(color: color);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: color,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
