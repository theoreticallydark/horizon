import 'package:flutter/material.dart';
import '../../styles/tokens.dart';
import '../../styles/swatches.dart';

enum ToggleIconState {
  unchecked,
  checked,
}

class ToggleIcon extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.0.0';

  final ToggleIconState state;
  final ValueChanged<ToggleIconState>? onChanged;
  final double size;

  const ToggleIcon({
    super.key,
    this.state = ToggleIconState.unchecked,
    this.onChanged,
    this.size = 24.0,
  });

  Color get _iconColor {
    switch (state) {
      case ToggleIconState.unchecked:
        return AlterSemanticTokens.textSecondary; // VariableID:103:9014 (gray600)
      case ToggleIconState.checked:
        return AlterColors.colorsPink600; // VariableID:1:194 (pink600 #E60076)
    }
  }

  IconData get _iconData {
    switch (state) {
      case ToggleIconState.unchecked:
        return Icons.favorite_border;
      case ToggleIconState.checked:
        return Icons.favorite;
    }
  }

  void _handleTap() {
    if (onChanged == null) return;
    onChanged!(
      state == ToggleIconState.unchecked
          ? ToggleIconState.checked
          : ToggleIconState.unchecked,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged != null ? _handleTap : null,
      borderRadius: BorderRadius.circular(size / 2),
      child: SizedBox(
        width: size,
        height: size,
        child: Center(
          child: Icon(
            _iconData,
            size: size,
            color: _iconColor,
          ),
        ),
      ),
    );
  }
}
