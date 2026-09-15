import 'package:flutter/material.dart';
import 'package:alter/alter.dart';

/// HorizonTitleBar Component
///
/// Figma Node: `130:4993` (.HorizonTitleBar)
/// Layout:
/// - Direction: Column (crossAxisAlignment: START, itemSpacing: 2.0)
/// - Title:
///   - Typography: `AlterTypography.hStyle`
///   - Color: `AlterColors.black` (VariableID:1:5 / `AlterSemanticTokens.textPrimary`)
/// - Subtitle:
///   - Typography: Geist, 12px, Regular, 400, LineHeight 16px (`AlterTypography.caption`)
///   - Color: `AlterColors.colorsGray600` (VariableID:103:9008 / `AlterSemanticTokens.textSecondary`)
class HorizonTitleBar extends StatelessWidget {
  /// Version tracking for Alter / Horizon component lifecycle
  /// v1.3.0: Updated title typography to use AlterTypography.hStyle.
  /// v1.2.0: Added optional `subtitleWidget` support for rich formatted subtitles (e.g. colored percentage/yield metrics).
  static const String version = '1.3.0';

  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;

  const HorizonTitleBar({
    super.key,
    this.title = 'Title',
    this.subtitle = 'Subtitle',
    this.subtitleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AlterTypography.hStyle.copyWith(
            color: AlterSemanticTokens.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (subtitleWidget != null) ...[
          const SizedBox(height: 2.0),
          subtitleWidget!,
        ] else if (subtitle != null && subtitle!.isNotEmpty) ...[
          const SizedBox(height: 2.0),
          Text(
            subtitle!,
            style: AlterTypography.caption.copyWith(
              color: AlterSemanticTokens.textSecondary,
              height: 16.0 / 12.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}
