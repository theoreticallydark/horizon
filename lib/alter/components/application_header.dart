import 'package:flutter/material.dart';
import '../styles/tokens.dart';
import '../styles/typography.dart';
import 'buttons/button_graphic_image.dart';
import 'buttons/button_graphic_text.dart';
import 'buttons/button_icon.dart';

class ApplicationHeader extends StatelessWidget {
  /// Component version for reference.
  /// v1.0.1: Updated outer layout to 24px padding all around and 16px itemSpacing between headerContainer and Slot as per Figma node 119:5716.
  /// v1.0.2: Dynamically hug action elements with spacing only between adjacent active items, eliminating trailing space when subsequent actions are absent.
  static const String version = '1.0.2';

  final String title;
  final String subtitle;

  final bool hasStyleButton;
  final String styleButtonTitle;
  final String styleButtonSubtitle;
  final VoidCallback? onStyleButtonTap;

  final bool hasActionOne;
  final VoidCallback? onActionOneTap;

  final bool hasActionTwo;
  final VoidCallback? onActionTwoTap;

  final bool hasProfileAction;
  final VoidCallback? onProfileTap;

  final Widget? slot;

  const ApplicationHeader({
    super.key,
    this.title = 'Alter',
    this.subtitle = 'Design System',
    this.hasStyleButton = true,
    this.styleButtonTitle = 'STREAK',
    this.styleButtonSubtitle = '7 DAYS',
    this.onStyleButtonTap,
    this.hasActionOne = true,
    this.onActionOneTap,
    this.hasActionTwo = false,
    this.onActionTwoTap,
    this.hasProfileAction = true,
    this.onProfileTap,
    this.slot,
  });

  @override
  Widget build(BuildContext context) {
    final actions = <Widget>[
      if (hasStyleButton)
        ButtonGraphicText(
          title: styleButtonTitle,
          subtitle: styleButtonSubtitle,
          onTap: onStyleButtonTap,
        ),
      if (hasActionTwo)
        ButtonIcon(
          type: ButtonIconType.white,
          onTap: onActionTwoTap,
        ),
      if (hasActionOne)
        ButtonIcon(
          type: ButtonIconType.white,
          onTap: onActionOneTap,
        ),
      if (hasProfileAction)
        ButtonGraphicImage(
          onTap: onProfileTap,
        ),
    ];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row Container (Title + Subtitle on Left, Actions on Right)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title & Subtitle Group
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AlterTypography.h1Serif.copyWith(
                        color: AlterSemanticTokens.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AlterTypography.caption.copyWith(
                        color: AlterSemanticTokens.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Action Items Group (Hugging elements with gap only between active items)
              if (actions.isNotEmpty)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < actions.length; i++) ...[
                      if (i > 0) const SizedBox(width: 8),
                      actions[i],
                    ],
                  ],
                ),
            ],
          ),

          // Slot Container (Animated with 16px gap above)
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOutCubic,
            child: slot != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: slot!,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
