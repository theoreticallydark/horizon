import 'package:flutter/material.dart';
import '../../styles/tokens.dart';
import '../../styles/typography.dart';

enum PillSize { defaultSize, compact }

enum PillColor { gray, neutral }

class Pill extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.0.1';

  final String label;
  final String? value;
  final PillSize size;
  final PillColor color;
  final bool isSelected;
  final bool isCompleted;
  final bool isInteractive;
  final VoidCallback? onTap;

  const Pill({
    super.key,
    this.label = 'Label',
    this.value,
    this.size = PillSize.defaultSize,
    this.color = PillColor.gray,
    this.isSelected = false,
    this.isCompleted = false,
    this.isInteractive = true,
    this.onTap,
  });

  Color get _backgroundColor {
    if (isCompleted) {
      return color == PillColor.gray
          ? AlterSemanticTokens.statusSuccess
          : AlterSemanticTokens.statusTeal;
    }
    return color == PillColor.gray
        ? AlterSemanticTokens.ui1
        : AlterSemanticTokens.ui2;
  }

  Color? get _borderColor {
    if (isSelected) {
      return AlterSemanticTokens.stroke1000;
    }
    if (isCompleted) {
      return null;
    }
    return color == PillColor.gray
        ? AlterSemanticTokens.stroke200
        : AlterSemanticTokens.ui4;
  }

  double get _borderWidth {
    if (isSelected) return 2.0;
    if (isCompleted) return 0.0;
    return 1.0;
  }

  Color get _textColor {
    if (isCompleted) {
      return AlterSemanticTokens.textInverse;
    }
    return AlterSemanticTokens.textSecondary;
  }

  EdgeInsets get _padding {
    final horizontal = 16.0 - _borderWidth;
    final vertical = (size == PillSize.defaultSize ? 12.0 : 6.0) - _borderWidth;
    return EdgeInsets.symmetric(
      horizontal: horizontal > 0 ? horizontal : 0,
      vertical: vertical > 0 ? vertical : 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _borderColor;
    final content = Container(
      padding: _padding,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: borderColor != null
            ? Border.all(
                color: borderColor,
                width: _borderWidth,
              )
            : null,
      ),
      child: size == PillSize.defaultSize && value != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: AlterTypography.captionBold.copyWith(
                    color: _textColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value!,
                  textAlign: TextAlign.center,
                  style: AlterTypography.caption.copyWith(
                    color: _textColor,
                  ),
                ),
              ],
            )
          : Text(
              label,
              textAlign: TextAlign.center,
              style: AlterTypography.captionBold.copyWith(
                color: _textColor,
              ),
            ),
    );

    if (!isInteractive) {
      return content;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: content,
    );
  }
}
