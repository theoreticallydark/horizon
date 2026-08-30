import 'package:flutter/material.dart';
import '../../styles/tokens.dart';
import '../../styles/typography.dart';

enum PillSize { defaultSize, compact }

enum PillColor { gray, neutral }

class Pill extends StatelessWidget {
  /// Component version for reference.
  /// v1.0.3: Enhanced smooth size and label showcase transitions with synchronized AnimatedCrossFade and cubic interpolation.
  static const String version = '1.0.3';

  final String label;
  final String? value;
  final PillSize size;
  final PillColor color;
  final bool hasLabel;
  final bool hasValue;
  final bool isSelected;
  final bool isCompleted;
  final bool isInteractive;
  final double? horizontalPadding;
  final VoidCallback? onTap;

  const Pill({
    super.key,
    this.label = 'Label',
    this.value,
    this.hasLabel = true,
    this.hasValue = true,
    this.size = PillSize.defaultSize,
    this.color = PillColor.gray,
    this.isSelected = false,
    this.isCompleted = false,
    this.isInteractive = true,
    this.horizontalPadding,
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
    final baseHorizontal = horizontalPadding ?? 16.0;
    final horizontal = baseHorizontal - _borderWidth;
    final vertical = (size == PillSize.defaultSize ? 12.0 : 6.0) - _borderWidth;
    return EdgeInsets.symmetric(
      horizontal: horizontal > 0 ? horizontal : 0,
      vertical: vertical > 0 ? vertical : 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _borderColor;
    final showValue = hasValue && value != null;

    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOutCubic,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (hasLabel)
            Text(
              label,
              textAlign: TextAlign.center,
              style: AlterTypography.captionBold.copyWith(
                color: _textColor,
              ),
            ),
          ClipRect(
            child: AnimatedCrossFade(
              alignment: Alignment.topCenter,
              firstChild: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasLabel) const SizedBox(height: 2),
                  Text(
                    value ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: AlterTypography.caption.copyWith(
                      color: _textColor,
                    ),
                  ),
                ],
              ),
              secondChild: const SizedBox(width: double.infinity, height: 0),
              crossFadeState: showValue
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 250),
              firstCurve: Curves.easeInOutCubic,
              secondCurve: Curves.easeInOutCubic,
              sizeCurve: Curves.easeInOutCubic,
            ),
          ),
        ],
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
