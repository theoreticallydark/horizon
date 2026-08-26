import 'package:flutter/material.dart';
import '../alter/alter.dart';

/// HorizonTitleBar Component
///
/// Figma Node: `130:4993` (.HorizonTitleBar)
/// Layout:
/// - Direction: Column (crossAxisAlignment: START, itemSpacing: 2.0)
/// - Title:
///   - Typography: Instrument Serif, 20px, Italic, 400, LineHeight 28px
///   - Color: `AlterColors.black` (VariableID:1:5 / `AlterSemanticTokens.textPrimary`)
/// - Subtitle:
///   - Typography: Geist, 12px, Regular, 400, LineHeight 16px (`AlterTypography.caption`)
///   - Color: `AlterColors.colorsGray600` (VariableID:103:9008 / `AlterSemanticTokens.textSecondary`)
class HorizonTitleBar extends StatelessWidget {
  /// Version tracking for Alter / Horizon component lifecycle
  static const String version = '1.1.0'; // Changed layout to vertical (Column) with 2px gap

  final String title;
  final String? subtitle;

  const HorizonTitleBar({
    super.key,
    this.title = 'Title',
    this.subtitle = 'Subtitle',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: AlterTypography.instrumentSerifFont,
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            height: 28.0 / 20.0,
            color: AlterSemanticTokens.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (subtitle != null && subtitle!.isNotEmpty) ...[
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
