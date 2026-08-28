import 'package:flutter/material.dart';
import '../../styles/tokens.dart';
import '../../styles/typography.dart';

/// Reusable Search component for the Alter Design System.
///
/// Figma Specifications (Node `130:11237`):
/// - Variants:
///   - `State=Default` (`130:11128`): Fill `baseGray`, Border `stroke100`, Text `textDisabled` ('Search')
///   - `State=Typing` (`130:11238`): Fill `baseGray`, Border `stroke1000`, Text `textPrimary`
///   - `State=Typed` (`164:8268`): Fill `baseGray`, Border `stroke100`, Text `textPrimary`
/// - Surface: `AlterSemanticTokens.baseGray` (`#F9FAFB`)
/// - Border: 1px `AlterSemanticTokens.stroke100` (Default/Typed) / `AlterSemanticTokens.stroke1000` (Typing)
/// - Border Radius: 20px
/// - Padding: 24px horizontal, 18px vertical (total height: 64px)
/// - Typography: Geist 16px Regular, line-height 28px
/// - Text Color: `AlterSemanticTokens.textPrimary` (Typed/Typing) / `AlterSemanticTokens.textDisabled` (Placeholder)
class Search extends StatefulWidget {
  /// Component version for reference.
  /// v1.0.1: Removed extra non-Figma leading/trailing slots to strictly match Figma Node 130:11237 specs.
  static const String version = '1.0.1';

  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final bool autofocus;
  final bool enabled;
  final bool readOnly;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  const Search({
    super.key,
    this.hintText = 'Search',
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.textInputAction = TextInputAction.search,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late final TextEditingController _internalController;
  late final FocusNode _internalFocusNode;

  TextEditingController get _effectiveController =>
      widget.controller ?? _internalController;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = TextEditingController();
    }
    if (widget.focusNode == null) {
      _internalFocusNode = FocusNode();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle inputTextStyle = TextStyle(
      fontFamily: AlterTypography.geistFont,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 28.0 / 16.0,
      color: AlterSemanticTokens.textPrimary,
      letterSpacing: 0.0,
    );

    const TextStyle hintTextStyle = TextStyle(
      fontFamily: AlterTypography.geistFont,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 28.0 / 16.0,
      color: AlterSemanticTokens.textDisabled,
      letterSpacing: 0.0,
    );

    final OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(
        color: AlterSemanticTokens.stroke100,
        width: 1.0,
      ),
    );

    final OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(
        color: AlterSemanticTokens.stroke1000,
        width: 1.0,
      ),
    );

    return TextField(
      controller: _effectiveController,
      focusNode: _effectiveFocusNode,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      style: inputTextStyle,
      cursorColor: AlterSemanticTokens.textPrimary,
      cursorWidth: 1.5,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: AlterSemanticTokens.baseGray,
        hintText: widget.hintText,
        hintStyle: hintTextStyle,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 18.0,
        ),
        border: defaultBorder,
        enabledBorder: defaultBorder,
        focusedBorder: focusedBorder,
        disabledBorder: defaultBorder,
      ),
    );
  }
}
