import 'dart:async';
import 'package:flutter/material.dart';
import '../alter/alter.dart';
import '../data/models/food_source_item.dart';
import '../data/models/nutrient_info.dart';
import '../data/services/nutrition_tracking_service.dart';
import '../data/utils/continuous_step_controller.dart';
import 'horizon_list_item.dart';
import 'horizon_title_bar.dart';

/// Modal component for inspecting and adjusting a Food Source's portion and nutrient contributions.
///
/// Features:
/// - Vertical layout, 24px padding, 16px gap between children, H=Hug, rounded corners 24px, base-white background.
/// - Child 1: `HorizonTitleBar` without subtitle, title editable.
/// - Child 2: `HorizonListItem` of type Routine (stops at minimum 1g quantity, does not transition to routineRemove).
/// - Child 3: `NutrientPillGridContainer` hosting nutrients in a 4-column grid (only >= 5% contributors on NutrientMap).
/// - Child 4: `ActionContainer` with `ButtonText` Large Gray and Primary reading 'Cancel' and 'Done'.
/// - Child 5: Option W=Fill text container with center-aligned text (default: "Visit Routine to include Daily/Weekly").
class HorizonFoodModal extends StatefulWidget {
  /// Component version for reference.
  // Version 1.0.3: Initial quantity falls back to clean snappedPortionGrams.
  static const String version = '1.0.3';

  final String? title;
  final FoodSourceItem food;
  final double? initialGrams;
  final Map<String, double>? targetMap;
  final Map<String, NutrientInfo>? nutrientMap;
  final ValueChanged<double>? onDone;
  final VoidCallback? onCancel;
  final String? footerText;
  final bool showFooter;

  const HorizonFoodModal({
    super.key,
    this.title,
    required this.food,
    this.initialGrams,
    this.targetMap,
    this.nutrientMap,
    this.onDone,
    this.onCancel,
    this.footerText = 'Visit Routine to include Daily/Weekly',
    this.showFooter = true,
  });

  /// Opens HorizonFoodModal as a bottom-up modal sheet.
  static Future<double?> show(
    BuildContext context, {
    String? title,
    required FoodSourceItem food,
    double? initialGrams,
    Map<String, double>? targetMap,
    Map<String, NutrientInfo>? nutrientMap,
    String? footerText = 'Visit Routine to include Daily/Weekly',
    bool showFooter = true,
  }) {
    return showModalBottomSheet<double>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => HorizonFoodModal(
        title: title,
        food: food,
        initialGrams: initialGrams,
        targetMap: targetMap,
        nutrientMap: nutrientMap,
        footerText: footerText,
        showFooter: showFooter,
        onDone: (grams) => Navigator.of(context).pop(grams),
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  State<HorizonFoodModal> createState() => _HorizonFoodModalState();
}

class _HorizonFoodModalState extends State<HorizonFoodModal> {
  final NutritionTrackingService _trackingService = NutritionTrackingService();

  late double _quantityGrams;
  late final ContinuousStepController _stepController;

  Map<String, double>? _targetMap;
  Map<String, NutrientInfo>? _nutrientMap;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _quantityGrams = widget.initialGrams ??
        (widget.food.plannedDailyGrams > 0
            ? widget.food.plannedDailyGrams
            : widget.food.snappedPortionGrams);

    _stepController = ContinuousStepController(
      minValue: 1.0,
      onStep: (newVal) {
        setState(() {
          _quantityGrams = newVal;
        });
      },
    );

    if (widget.targetMap != null && widget.nutrientMap != null) {
      _targetMap = widget.targetMap;
      _nutrientMap = widget.nutrientMap;
      _isLoading = false;
    } else {
      _loadMetadata();
    }
  }

  @override
  void dispose() {
    _stepController.dispose();
    super.dispose();
  }

  Future<void> _loadMetadata() async {
    final state = await _trackingService.loadAddSourceState();
    if (!mounted) return;
    setState(() {
      _targetMap = state.targetMap;
      _nutrientMap = state.nutrientMap;
      _isLoading = false;
    });
  }

  void _stepQuantity(double delta) {
    final updated = (_quantityGrams + delta).clamp(1.0, 99999.0);
    setState(() {
      _quantityGrams = updated;
    });
  }

  String _buildSubtitle() {
    if (_targetMap == null || _nutrientMap == null) return '';
    return widget.food.buildNutrientCoverageSubtitle(
      portionGrams: _quantityGrams,
      targetMap: _targetMap!,
      nutrientMap: _nutrientMap!,
    );
  }

  List<({NutrientInfo info, double coveragePercent, bool isDaily})> _getQualifiedNutrients() {
    if (_targetMap == null || _nutrientMap == null) return [];
    final qualified = widget.food.calculateNutrientContributions(
      portionGrams: _quantityGrams,
      targetMap: _targetMap!,
      nutrientMap: _nutrientMap!,
      minCoveragePercent: 5.0,
    );

    // Sort: Daily nutrients first, then Weekly nutrients (same ordering as NutrientMap)
    final daily = qualified.where((n) => n.isDaily).toList();
    final weekly = qualified.where((n) => !n.isDaily).toList();
    return [...daily, ...weekly];
  }

  @override
  Widget build(BuildContext context) {
    final titleText = widget.title ?? widget.food.title;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AlterSemanticTokens.baseWhite,
        borderRadius: BorderRadius.circular(24),
      ),
      child: _isLoading
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressIndicator(
                  color: AlterSemanticTokens.textPrimary,
                ),
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Child 1: HorizonTitleBar without subtitle, title editable
                HorizonTitleBar(
                  title: titleText,
                  subtitle: null,
                ),
                const SizedBox(height: 16),

                // Child 2: HorizonListItem of type Routine (stops at 1g, does not go to routineRemove)
                HorizonListItem(
                  host: HorizonListItemHost.routine,
                  title: '${widget.food.title}, ${_quantityGrams.round()}g',
                  subtitle: _buildSubtitle(),
                  onLeftActionTap: () => _stepQuantity(-widget.food.stepGrams),
                  onLeftTapDown: (_) => _stepController.start(
                    currentDelta: -widget.food.stepGrams,
                    currentValue: _quantityGrams,
                  ),
                  onLeftTapUp: (_) => _stepController.stop(),
                  onLeftTapCancel: () => _stepController.stop(),
                  onRightActionTap: () => _stepQuantity(widget.food.stepGrams),
                  onRightTapDown: (_) => _stepController.start(
                    currentDelta: widget.food.stepGrams,
                    currentValue: _quantityGrams,
                  ),
                  onRightTapUp: (_) => _stepController.stop(),
                  onRightTapCancel: () => _stepController.stop(),
                ),
                const SizedBox(height: 16),

                // Child 3: NutrientPillGridContainer in 4-column grid (only >= 5% contributors on NutrientMap)
                _buildNutrientPillGridContainer(),
                const SizedBox(height: 16),

                // Child 4: ActionContainer with ButtonText Large Cancel (Gray) and Done (Primary)
                _buildActionContainer(),

                // Child 5: Option W=Fill textbox with center-aligned text
                if (widget.showFooter &&
                    widget.footerText != null &&
                    widget.footerText!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    widget.footerText!,
                    textAlign: TextAlign.center,
                    style: AlterTypography.caption.copyWith(
                      color: AlterSemanticTokens.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  Widget _buildNutrientPillGridContainer() {
    final qualifiedNutrients = _getQualifiedNutrients();

    if (qualifiedNutrients.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24),
        alignment: Alignment.center,
        child: Text(
          'No nutrients with >5% contribution',
          textAlign: TextAlign.center,
          style: AlterTypography.caption.copyWith(
            color: AlterSemanticTokens.textSecondary,
          ),
        ),
      );
    }

    const double spacing = 6.0;
    const double runSpacing = 6.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalSpacing = spacing * 3;
        final columnWidth = (constraints.maxWidth - totalSpacing) / 4;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int rowIndex = 0;
                rowIndex < (qualifiedNutrients.length / 4).ceil();
                rowIndex++) ...[
              if (rowIndex > 0) const SizedBox(height: runSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int colIndex = 0; colIndex < 4; colIndex++) ...[
                    if (colIndex > 0) const SizedBox(width: spacing),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          final itemIndex = rowIndex * 4 + colIndex;
                          if (itemIndex >= qualifiedNutrients.length) {
                            return const SizedBox.shrink();
                          }
                          final item = qualifiedNutrients[itemIndex];
                          final label = item.info.shortKey ?? item.info.displayName;
                          final percentClamped = item.coveragePercent.clamp(0.0, 999.0).round();
                          final isCompleted = item.coveragePercent >= 100.0;

                          return SizedBox(
                            width: columnWidth,
                            child: Pill(
                              label: label,
                              value: '$percentClamped%',
                              size: PillSize.defaultSize,
                              color: item.isDaily ? PillColor.neutral : PillColor.gray,
                              isCompleted: isCompleted,
                              isInteractive: false,
                              horizontalPadding: 2.4,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildActionContainer() {
    return Row(
      children: [
        // ButtonText Large Gray 'Cancel'
        Expanded(
          child: ButtonText(
            label: 'Cancel',
            type: ButtonType.gray,
            size: ButtonSize.large,
            onTap: () {
              if (widget.onCancel != null) {
                widget.onCancel!();
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        const SizedBox(width: 16),

        // ButtonText Large Primary 'Done'
        Expanded(
          child: ButtonText(
            label: 'Done',
            type: ButtonType.primary,
            size: ButtonSize.large,
            onTap: () {
              if (widget.onDone != null) {
                widget.onDone!(_quantityGrams);
              } else {
                Navigator.of(context).pop(_quantityGrams);
              }
            },
          ),
        ),
      ],
    );
  }
}
