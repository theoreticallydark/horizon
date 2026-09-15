import 'package:flutter/material.dart';
import 'package:alter/alter.dart';
import '../data/services/nutrition_tracking_service.dart';
import 'nutrient_map.dart';

/// Horizon Application Header wrapper with baseGray background override
///
/// Component version for reference:
/// v1.4.0: Overrode hardcoded white fill to AlterSemanticTokens.baseGray, added direct title/subtitle support for Onboarding and edge-to-edge topPadding handling.
class HorizonApplicationHeader extends StatelessWidget {
  static const String version = '1.4.0';

  final String? title;
  final String? subtitle;
  final bool hasReturnButton;
  final VoidCallback? onReturnTap;

  final bool hasStyleButton;
  final String styleButtonTitle;
  final String styleButtonSubtitle;
  final VoidCallback? onStreakTap;

  final bool hasActionOne;
  final IconData actionOneIcon;
  final VoidCallback? onActionOneTap;

  final bool hasActionTwo;
  final IconData actionTwoIcon;
  final VoidCallback? onActionTwoTap;

  final bool hasProfileAction;
  final ImageProvider? profileImage;
  final VoidCallback? onProfileTap;

  final Widget? slot;

  // Tab-driven mode for main shell
  final int? currentIndex;
  final String? selectedNutrientKey;
  final ValueChanged<String>? onNutrientTap;
  final bool hideNutrientMap;

  const HorizonApplicationHeader({
    super.key,
    this.title,
    this.subtitle,
    this.hasReturnButton = false,
    this.onReturnTap,
    this.hasStyleButton = false,
    this.styleButtonTitle = 'STREAK',
    this.styleButtonSubtitle = '7 DAYS',
    this.onStreakTap,
    this.hasActionOne = false,
    this.actionOneIcon = Icons.favorite_border,
    this.onActionOneTap,
    this.hasActionTwo = false,
    this.actionTwoIcon = Icons.favorite_border,
    this.onActionTwoTap,
    this.hasProfileAction = false,
    this.profileImage,
    this.onProfileTap,
    this.slot,
    this.currentIndex,
    this.selectedNutrientKey,
    this.onNutrientTap,
    this.hideNutrientMap = false,
  });

  Widget _buildContent(BuildContext context, {
    required String effectiveTitle,
    required String effectiveSubtitle,
    required bool effectiveHasReturnButton,
    required bool effectiveHasStyleButton,
    required bool effectiveHasActionOne,
    required bool effectiveHasActionTwo,
    required bool effectiveHasProfileAction,
    required Widget? effectiveSlot,
  }) {
    final topPadding = MediaQuery.of(context).padding.top;

    final actions = <Widget>[
      if (effectiveHasStyleButton)
        ButtonGraphicText(
          title: styleButtonTitle,
          subtitle: styleButtonSubtitle,
          onTap: onStreakTap,
        ),
      if (effectiveHasActionOne)
        ButtonIcon(
          icon: actionOneIcon,
          type: ButtonIconType.gray,
          size: 48,
          onTap: onActionOneTap,
        ),
      if (effectiveHasActionTwo)
        ButtonIcon(
          icon: actionTwoIcon,
          type: ButtonIconType.gray,
          size: 48,
          onTap: onActionTwoTap,
        ),
      if (effectiveHasProfileAction)
        ButtonGraphicImage(
          image: profileImage,
          onTap: onProfileTap,
        ),
    ];

    return Container(
      width: double.infinity,
      color: AlterSemanticTokens.baseGray,
      padding: EdgeInsets.fromLTRB(24, 24 + topPadding, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Group (Return Button + Title/Subtitle)
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (effectiveHasReturnButton) ...[
                      ButtonIconGhost(
                        icon: Icons.arrow_back,
                        size: 32,
                        type: ButtonIconGhostType.primary,
                        onTap: onReturnTap,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            effectiveTitle,
                            style: AlterTypography.h1Serif.copyWith(
                              color: AlterSemanticTokens.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            effectiveSubtitle,
                            style: AlterTypography.caption.copyWith(
                              color: AlterSemanticTokens.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Right Group (Actions)
              if (actions.isNotEmpty) ...[
                const SizedBox(width: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = 0; i < actions.length; i++) ...[
                      if (i > 0) const SizedBox(width: 8),
                      actions[i],
                    ],
                  ],
                ),
              ],
            ],
          ),

          // Slot Container
          if (effectiveSlot != null) ...[
            const SizedBox(height: 16),
            effectiveSlot,
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex == null) {
      // Direct Onboarding or standalone mode
      return _buildContent(
        context,
        effectiveTitle: title ?? '',
        effectiveSubtitle: subtitle ?? '',
        effectiveHasReturnButton: hasReturnButton,
        effectiveHasStyleButton: hasStyleButton,
        effectiveHasActionOne: hasActionOne,
        effectiveHasActionTwo: hasActionTwo,
        effectiveHasProfileAction: hasProfileAction,
        effectiveSlot: slot,
      );
    }

    final trackingService = NutritionTrackingService();

    return StreamBuilder<({double consumedCalories, double plannedCalories, double consumedProtein, double plannedProtein})>(
      stream: trackingService.watchTodayTrackHeaderEnergyAndProtein(),
      builder: (context, snapshot) {
        final consumedCal = snapshot.data?.consumedCalories.round() ?? 0;
        final plannedCal = snapshot.data?.plannedCalories.round() ?? 0;
        final consumedProt = snapshot.data?.consumedProtein.round() ?? 0;
        final plannedProt = snapshot.data?.plannedProtein.round() ?? 0;

        String pageTitle;
        String pageSubtitle;
        bool pageHasStyleButton = false;
        bool pageHasProfileAction = false;
        Widget? slotWidget;

        switch (currentIndex) {
          case 0:
            pageTitle = 'Today';
            pageSubtitle = '$consumedCal/$plannedCal calories • $consumedProt/${plannedProt}g protein';
            pageHasStyleButton = true;
            pageHasProfileAction = false;
            slotWidget = hideNutrientMap
                ? null
                : NutrientMap(
                    key: const ValueKey('header_nutrient_map'),
                    variant: NutrientMapVariant.trackFullView,
                    selectedNutrientKey: selectedNutrientKey,
                    onNutrientTap: onNutrientTap,
                  );
            break;
          case 1:
            pageTitle = 'Stats';
            pageSubtitle = 'Just do it';
            pageHasStyleButton = true;
            pageHasProfileAction = false;
            slotWidget = null;
            break;
          case 2:
            pageTitle = 'Plan Routine';
            pageSubtitle = '$plannedCal calories • ${plannedProt}g protein';
            pageHasStyleButton = false;
            pageHasProfileAction = true;
            slotWidget = hideNutrientMap
                ? null
                : NutrientMap(
                    key: const ValueKey('header_nutrient_map'),
                    variant: NutrientMapVariant.routine,
                    selectedNutrientKey: selectedNutrientKey,
                    onNutrientTap: onNutrientTap,
                  );
            break;
          default:
            pageTitle = 'Horizon';
            pageSubtitle = 'Design System';
            break;
        }

        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          child: _buildContent(
            context,
            effectiveTitle: pageTitle,
            effectiveSubtitle: pageSubtitle,
            effectiveHasReturnButton: false,
            effectiveHasStyleButton: pageHasStyleButton,
            effectiveHasActionOne: false,
            effectiveHasActionTwo: false,
            effectiveHasProfileAction: pageHasProfileAction,
            effectiveSlot: slotWidget,
          ),
        );
      },
    );
  }
}
