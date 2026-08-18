import 'package:flutter/material.dart';
import '../styles/tokens.dart';
import '../styles/typography.dart';
import 'buttons/button_graphic_image.dart';
import 'buttons/button_graphic_text.dart';
import 'buttons/button_icon.dart';

class ApplicationHeader extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.0.0';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title & Subtitle Group
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AlterTypography.h1Serif.copyWith(
                      color: AlterSemanticTokens.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AlterTypography.caption.copyWith(
                      color: AlterSemanticTokens.textSecondary,
                    ),
                  ),
                ],
              ),

              // Action Items Group
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasStyleButton) ...[
                    ButtonGraphicText(
                      title: styleButtonTitle,
                      subtitle: styleButtonSubtitle,
                      onTap: onStyleButtonTap,
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (hasActionTwo) ...[
                    ButtonIcon(
                      type: ButtonIconType.white,
                      onTap: onActionTwoTap,
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (hasActionOne) ...[
                    ButtonIcon(
                      type: ButtonIconType.white,
                      onTap: onActionOneTap,
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (hasProfileAction) ...[
                    ButtonGraphicImage(
                      onTap: onProfileTap,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutCubic,
          child: slot ?? const SizedBox.shrink(),
        ),
      ],
    );
  }
}
