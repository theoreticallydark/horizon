import 'package:flutter/material.dart';
import '../styles/tokens.dart';
import '../styles/typography.dart';

enum ButtonType { gray, white, primary }

enum ButtonSize { normal, large }

class ButtonText extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.0.1';

  final String label;
  final ButtonType type;
  final ButtonSize size;
  final VoidCallback? onTap;

  const ButtonText({
    super.key,
    required this.label,
    this.type = ButtonType.gray,
    this.size = ButtonSize.normal,
    this.onTap,
  });

  Color get _backgroundColor {
    switch (type) {
      case ButtonType.gray:
        return AlterSemanticTokens.baseGray;
      case ButtonType.white:
        return AlterSemanticTokens.baseWhite;
      case ButtonType.primary:
        return AlterSemanticTokens.baseBlack;
    }
  }

  Color get _borderColor {
    switch (type) {
      case ButtonType.gray:
      case ButtonType.white:
        return AlterSemanticTokens.stroke100;
      case ButtonType.primary:
        return AlterSemanticTokens.stroke1000;
    }
  }

  Color get _textColor {
    switch (type) {
      case ButtonType.gray:
      case ButtonType.white:
        return AlterSemanticTokens.textPrimary;
      case ButtonType.primary:
        return AlterSemanticTokens.textInverse;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case ButtonSize.normal:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 14);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 22);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        constraints: const BoxConstraints(minWidth: 64),
        padding: _padding,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _borderColor,
            width: 1,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AlterTypography.bodyLgBold.copyWith(
            color: _textColor,
          ),
        ),
      ),
    );
  }
}
