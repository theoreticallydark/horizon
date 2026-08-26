import 'package:flutter/material.dart';
import '../alter/alter.dart';
import '../data/models/nutrient_info.dart';
import '../data/services/nutrition_tracking_service.dart';

enum NutrientMapVariant {
  routine,
  trackFullView,
  trackDailyView,
}

class NutrientData {
  final String nutrientKey;
  final String label;
  final String? value;
  final PillColor color;
  final bool isSelected;
  final bool isCompleted;
  final bool isInteractive;

  const NutrientData({
    required this.label,
    this.nutrientKey = '',
    this.value,
    this.color = PillColor.gray,
    this.isSelected = false,
    this.isCompleted = false,
    this.isInteractive = true,
  });

  NutrientData copyWith({
    String? nutrientKey,
    String? label,
    String? value,
    PillColor? color,
    bool? isSelected,
    bool? isCompleted,
    bool? isInteractive,
  }) {
    return NutrientData(
      nutrientKey: nutrientKey ?? this.nutrientKey,
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
  final List<NutrientData>? nutrients;
  final String? selectedNutrientKey;
  final ValueChanged<String>? onNutrientTap;
  final double spacing;
  final double runSpacing;

  /// Default 20 standard nutrients configured with exact key labels and dynamic colors
  static const List<NutrientData> defaultNutrients = [
    // Row 1 (7 Daily Nutrients: Vit C, Coll., Fiber, Mg, Ca, K, Creat. -> neutral color)
    NutrientData(nutrientKey: 'vitamin_c', label: 'Vit C', value: '0%', color: PillColor.neutral),
    NutrientData(nutrientKey: 'collagen', label: 'Coll.', value: '0%', color: PillColor.neutral),
    NutrientData(nutrientKey: 'total_fiber', label: 'Fiber', value: '0%', color: PillColor.neutral),
    NutrientData(nutrientKey: 'magnesium', label: 'Mg', value: '0%', color: PillColor.neutral),
    NutrientData(nutrientKey: 'calcium', label: 'Ca', value: '0%', color: PillColor.neutral),
    NutrientData(nutrientKey: 'potassium', label: 'K', value: '0%', color: PillColor.neutral),
    NutrientData(nutrientKey: 'creatine', label: 'Creat.', value: '0%', color: PillColor.neutral),

    // Row 2 (Weekly Nutrients -> gray color)
    NutrientData(nutrientKey: 'vitamin_a', label: 'Vit A', value: '0%', color: PillColor.gray),
    NutrientData(nutrientKey: 'vitamin_e', label: 'Vit E', value: '0%', color: PillColor.gray),
    NutrientData(nutrientKey: 'vitamin_b12', label: 'Vit B12', value: '0%', color: PillColor.gray),
    NutrientData(nutrientKey: 'selenium', label: 'Se', value: '0%', color: PillColor.gray),
    NutrientData(nutrientKey: 'zinc', label: 'Zinc', value: '0%', color: PillColor.gray),
    NutrientData(nutrientKey: 'iron', label: 'Iron', value: '0%', color: PillColor.gray),
    NutrientData(nutrientKey: 'iodine', label: 'Iodine', value: '0%', color: PillColor.gray),

    // Row 3 (Weekly Nutrients & Essential Lipids -> gray color)
    NutrientData(nutrientKey: 'vitamin_k', label: 'Vit K', value: '0%', color: PillColor.gray),
    NutrientData(nutrientKey: 'folate', label: 'Folate', value: '0%', color: PillColor.gray),
    NutrientData(nutrientKey: 'vitamin_d', label: 'Vit D', value: '0%', color: PillColor.gray),
    NutrientData(nutrientKey: 'linoleic_acid_omega_6', label: 'Om6', value: '0%', color: PillColor.gray),
    NutrientData(nutrientKey: 'alpha_linolenic_acid_omega_3', label: 'ALA', value: '0%', color: PillColor.gray),
    NutrientData(nutrientKey: 'omega_3_epa_dha', label: 'Om3', value: '0%', color: PillColor.gray),
  ];

  const NutrientMap({
    super.key,
    this.variant = NutrientMapVariant.routine,
    this.nutrients,
    this.selectedNutrientKey,
    this.onNutrientTap,
    this.spacing = 3.5,
    this.runSpacing = 3.5,
  });

  /// Map database NutrientInfo list and calculated live coverage to NutrientData UI items
  List<NutrientData> _mapFromEntities(
    List<NutrientInfo> list,
    Map<String, double> coverageMap,
  ) {
    if (list.isEmpty) return defaultNutrients;

    // Sort: Daily nutrients first (Row 1), then Weekly nutrients
    final daily = list.where((n) => n.frequency == TrackingFrequency.daily).toList();
    final weekly = list.where((n) => n.frequency == TrackingFrequency.weekly).toList();
    final ordered = [...daily, ...weekly];

    return ordered.map((n) {
      final label = n.shortKey ?? n.displayName;
      final isDaily = n.frequency == TrackingFrequency.daily;
      final rawPercent = coverageMap[n.nutrientKey] ?? 0.0;
      final percentClamped = rawPercent.clamp(0.0, 999.0).round();
      final isCompleted = rawPercent >= 100.0;
      final isSelected = selectedNutrientKey == n.nutrientKey;

      return NutrientData(
        nutrientKey: n.nutrientKey,
        label: label,
        value: '$percentClamped%',
        color: isDaily ? PillColor.neutral : PillColor.gray,
        isCompleted: isCompleted,
        isSelected: isSelected,
      );
    }).toList();
  }

  Widget _buildGrid(List<NutrientData> dataList) {
    final isCompact = variant != NutrientMapVariant.routine;
    final pillSize = isCompact ? PillSize.compact : PillSize.defaultSize;

    // Track Daily View shows 1 row (7 pills), other variants show all tracked pills
    final itemCount = variant == NutrientMapVariant.trackDailyView ? 7 : dataList.length;
    final displayedNutrients = dataList.take(itemCount).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
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
                          final isSelected = item.nutrientKey.isNotEmpty &&
                              selectedNutrientKey == item.nutrientKey;

                          return SizedBox(
                            width: columnWidth,
                            child: Pill(
                              label: item.label,
                              value: isCompact ? null : item.value,
                              size: pillSize,
                              color: item.color,
                              isSelected: isSelected,
                              isCompleted: item.isCompleted,
                              isInteractive: item.isInteractive,
                              onTap: () {
                                if (item.nutrientKey.isNotEmpty) {
                                  onNutrientTap?.call(item.nutrientKey);
                                }
                              },
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

  @override
  Widget build(BuildContext context) {
    // If nutrients are passed explicitly, use them directly
    if (nutrients != null) {
      return _buildGrid(nutrients!);
    }

    final trackingService = NutritionTrackingService();
    final isTrackView = variant != NutrientMapVariant.routine;

    // Single consolidated watcher stream for nutrients + live coverage
    return StreamBuilder<NutrientMapState>(
      stream: trackingService.watchNutrientMapState(isTrackView),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state == null) {
          return _buildGrid(defaultNutrients);
        }

        final items = _mapFromEntities(state.nutrients, state.coverageMap);
        return _buildGrid(items);
      },
    );
  }
}
