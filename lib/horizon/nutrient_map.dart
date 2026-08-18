import 'package:flutter/material.dart';
import '../alter/alter.dart';
import 'nutrient_pill.dart';

enum NutrientMapVariant {
  routine,
  trackFullView,
  trackDailyView,
}

class NutrientData {
  final String label;
  final String? value;
  final PillColor color;
  final bool isSelected;
  final bool isCompleted;
  final bool isInteractive;

  const NutrientData({
    required this.label,
    this.value,
    this.color = PillColor.gray,
    this.isSelected = false,
    this.isCompleted = false,
    this.isInteractive = true,
  });

  NutrientData copyWith({
    String? label,
    String? value,
    PillColor? color,
    bool? isSelected,
    bool? isCompleted,
    bool? isInteractive,
  }) {
    return NutrientData(
      label: label ?? this.label,
      value: value ?? this.value,
      color: color ?? this.color,
      isSelected: isSelected ?? this.isSelected,
      isCompleted: isCompleted ?? this.isCompleted,
      isInteractive: isInteractive ?? this.isInteractive,
    );
  }
}

class NutrientMap extends StatelessWidget {
  final NutrientMapVariant variant;
  final List<NutrientData> nutrients;
  final ValueChanged<int>? onNutrientTap;
  final double spacing;
  final double runSpacing;

  /// Default 21 standard nutrients configured according to Figma node `120:6965`
  static const List<NutrientData> defaultNutrients = [
    // Row 1 (Macro / Core Nutrients - neutral color in Figma)
    NutrientData(label: 'Vit C', value: '85%', color: PillColor.neutral),
    NutrientData(label: 'Coll.', value: '85%', color: PillColor.neutral),
    NutrientData(label: 'Fiber', value: '85%', color: PillColor.neutral),
    NutrientData(label: 'Mg', value: '85%', color: PillColor.neutral),
    NutrientData(label: 'Ca', value: '85%', color: PillColor.neutral),
    NutrientData(label: 'K', value: '85%', color: PillColor.neutral),
    NutrientData(label: 'Creat.', value: '85%', color: PillColor.neutral),

    // Row 2 (Vitamins & Minerals - gray color in Figma)
    NutrientData(label: 'Vit A', value: '85%', color: PillColor.gray),
    NutrientData(label: 'Vit E', value: '85%', color: PillColor.gray),
    NutrientData(label: 'Vit B12', value: '85%', color: PillColor.gray),
    NutrientData(label: 'Se', value: '85%', color: PillColor.gray),
    NutrientData(label: 'Zinc', value: '85%', color: PillColor.gray),
    NutrientData(label: 'Iron', value: '85%', color: PillColor.gray),
    NutrientData(label: 'Iodine', value: '85%', color: PillColor.gray),

    // Row 3 (Trace & Fatty Acids - gray color in Figma)
    NutrientData(label: 'Vit K', value: '85%', color: PillColor.gray),
    NutrientData(label: 'Folate', value: '85%', color: PillColor.gray),
    NutrientData(label: 'Vit D', value: '85%', color: PillColor.gray),
    NutrientData(label: 'Om6', value: '85%', color: PillColor.gray),
    NutrientData(label: 'ALA', value: '85%', color: PillColor.gray),
    NutrientData(label: 'EPA', value: '85%', color: PillColor.gray),
    NutrientData(label: 'DHA', value: '85%', color: PillColor.gray),
  ];

  const NutrientMap({
    super.key,
    this.variant = NutrientMapVariant.routine,
    this.nutrients = defaultNutrients,
    this.onNutrientTap,
    this.spacing = 3.5,
    this.runSpacing = 3.5,
  });

  @override
  Widget build(BuildContext context) {
    final isCompact = variant != NutrientMapVariant.routine;
    final pillSize = isCompact ? PillSize.compact : PillSize.defaultSize;

    // Track Daily View shows 1 row (7 pills), other variants show 3 rows (21 pills)
    final itemCount = variant == NutrientMapVariant.trackDailyView ? 7 : nutrients.length;
    final displayedNutrients = nutrients.take(itemCount).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate equal width for each of the 7 columns taking into account the 6 gaps
        final totalSpacing = spacing * 6;
        final columnWidth = (constraints.maxWidth - totalSpacing) / 7;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int rowIndex = 0; rowIndex < (displayedNutrients.length / 7).ceil(); rowIndex++) ...[
              if (rowIndex > 0) SizedBox(height: runSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int colIndex = 0; colIndex < 7; colIndex++) ...[
                    if (colIndex > 0) SizedBox(width: spacing),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          final itemIndex = rowIndex * 7 + colIndex;
                          if (itemIndex >= displayedNutrients.length) {
                            return const SizedBox.shrink();
                          }
                          final item = displayedNutrients[itemIndex];
                          return SizedBox(
                            width: columnWidth,
                            child: NutrientPill(
                              label: item.label,
                              value: isCompact ? null : item.value,
                              size: pillSize,
                              color: item.color,
                              isSelected: item.isSelected,
                              isCompleted: item.isCompleted,
                              isInteractive: item.isInteractive,
                              onTap: () => onNutrientTap?.call(itemIndex),
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
}
