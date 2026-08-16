import 'package:flutter/material.dart';
import '../../styles/tokens.dart';
import 'bottom_navigation_button.dart';

enum BottomNavigationBarActionType { defaultAction, save }

class BottomNavigationBarAction extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.0.0';

  final BottomNavigationBarActionType type;
  final VoidCallback? onPrimaryActionTap;
  final VoidCallback? onSecondaryActionTap;

  const BottomNavigationBarAction({
    super.key,
    this.type = BottomNavigationBarActionType.defaultAction,
    this.onPrimaryActionTap,
    this.onSecondaryActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
        color: AlterSemanticTokens.baseWhite,
        border: Border(
          top: BorderSide(
            color: AlterSemanticTokens.stroke100,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomNavigationButton(
            icon: type == BottomNavigationBarActionType.defaultAction
                ? Icons.close
                : Icons.arrow_back,
            type: BottomNavigationButtonType.secondary,
            onTap: onSecondaryActionTap,
          ),
          BottomNavigationButton(
            icon: type == BottomNavigationBarActionType.defaultAction
                ? Icons.add
                : Icons.check,
            type: BottomNavigationButtonType.primary,
            onTap: onPrimaryActionTap,
          ),
        ],
      ),
    );
  }
}
