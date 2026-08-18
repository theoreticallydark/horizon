import 'package:flutter/material.dart';
import '../alter/alter.dart';

class NutrientPill extends StatelessWidget {
  final String label;
  final String? value;
  final PillSize size;
  final PillColor color;
  final bool hasLabel;
  final bool hasValue;
  final bool isSelected;
  final bool isCompleted;
  final bool isInteractive;
  final double horizontalPadding;
  final VoidCallback? onTap;

  const NutrientPill({
    super.key,
    required this.label,
    this.value = '85%',
    this.size = PillSize.defaultSize,
    this.color = PillColor.gray,
    this.hasLabel = true,
    this.hasValue = true,
    this.isSelected = false,
    this.isCompleted = false,
    this.isInteractive = true,
    this.horizontalPadding = 4.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Pill(
      label: label,
      value: value,
      size: size,
      color: color,
      hasLabel: hasLabel,
      hasValue: hasValue,
      isSelected: isSelected,
      isCompleted: isCompleted,
      isInteractive: isInteractive,
      horizontalPadding: horizontalPadding,
      onTap: onTap,
    );
  }
}
