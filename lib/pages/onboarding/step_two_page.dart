import 'package:flutter/material.dart';
import 'package:alter/alter.dart';
import '../../data/models/user_profile.dart';

/// Step 2: Body Metrics (Weight & Height) & Fitness Goal for Onboarding flow
///
/// Figma Nodes:
/// - `mainContainer`
/// - Goal Selector: `400:10530` ("What is your current goal?", "Bulk 💪", "Cut 📉", "Maintain")
///
/// Structure:
/// - mainContainer:
///   - Fill: `AlterSemanticTokens.baseWhite` (#FFFFFF)
///   - Border Radius: 24px
///   - Padding: 24px
///   - Gap: 24px
///   - Child 1: `NumericInput` for Weight (placeholder: 'Weight', suffix: 'kg', min: 20, max: 300)
///   - Child 2: `NumericInput` for Height (placeholder: 'Height', suffix: 'cm', min: 50, max: 250)
///   - Child 3: Goal Selector Column (Text label + Row of 3 `ToggleText`s with hasIcon: false)
class StepTwoPage extends StatefulWidget {
  /// Component version for reference
  /// v1.3.0: Set hasIcon: false on Goal Selector ToggleTexts.
  /// v1.2.0: Added Goal selector ('What is your current goal?', Bulk 💪, Cut 📉, Maintain) matching Figma node 400:10530, mapped to UserProfile.goal.
  /// v1.1.0: Added safe min/max bounds on weight (20-300 kg) and height (50-250 cm) with Alter error handling and validity notification.
  /// v1.0.0: Initial implementation of Step 2 with NumericInput for weight (kg) and height (cm) mapped to UserProfile.
  static const String version = '1.3.0';

  final double? initialWeight;
  final double? initialHeight;
  final UserGoal? initialGoal;
  final ValueChanged<double?>? onWeightChanged;
  final ValueChanged<double?>? onHeightChanged;
  final ValueChanged<UserGoal?>? onGoalChanged;
  final ValueChanged<bool>? onValidityChanged;

  const StepTwoPage({
    super.key,
    this.initialWeight,
    this.initialHeight,
    this.initialGoal,
    this.onWeightChanged,
    this.onHeightChanged,
    this.onGoalChanged,
    this.onValidityChanged,
  });

  @override
  State<StepTwoPage> createState() => _StepTwoPageState();
}

class _StepTwoPageState extends State<StepTwoPage> {
  late final TextEditingController _weightController;
  late final TextEditingController _heightController;
  UserGoal? _selectedGoal;

  static const double minWeight = 20.0;
  static const double maxWeight = 300.0;
  static const double minHeight = 50.0;
  static const double maxHeight = 250.0;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController(
      text: widget.initialWeight != null ? widget.initialWeight.toString() : '',
    );
    _heightController = TextEditingController(
      text: widget.initialHeight != null ? widget.initialHeight.toString() : '',
    );
    _selectedGoal = widget.initialGoal;
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  bool get _isValid {
    final w = NumericFormatterUtils.parse(_weightController.text);
    final h = NumericFormatterUtils.parse(_heightController.text);
    final isWeightValid = w != null && w >= minWeight && w <= maxWeight;
    final isHeightValid = h != null && h >= minHeight && h <= maxHeight;
    final isGoalValid = _selectedGoal != null;
    return isWeightValid && isHeightValid && isGoalValid;
  }

  void _notifyValidity() {
    widget.onValidityChanged?.call(_isValid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AlterSemanticTokens.baseWhite,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Weight NumericInput (20kg - 300kg)
          NumericInput(
            controller: _weightController,
            placeholder: 'Weight',
            suffix: 'kg',
            label: null,
            leftIcon: null,
            characterLimit: null,
            allowDecimals: true,
            allowNegative: false,
            minValue: minWeight,
            maxValue: maxWeight,
            onNumberChanged: (val) {
              final d = val?.toDouble();
              widget.onWeightChanged?.call(d);
              setState(() {});
              _notifyValidity();
            },
          ),
          const SizedBox(height: 24),

          // 2. Height NumericInput (50cm - 250cm)
          NumericInput(
            controller: _heightController,
            placeholder: 'Height',
            suffix: 'cm',
            label: null,
            leftIcon: null,
            characterLimit: null,
            allowDecimals: true,
            allowNegative: false,
            minValue: minHeight,
            maxValue: maxHeight,
            onNumberChanged: (val) {
              final d = val?.toDouble();
              widget.onHeightChanged?.call(d);
              setState(() {});
              _notifyValidity();
            },
          ),
          const SizedBox(height: 24),

          // 3. Goal Selector (#400:10530)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What is your current goal?',
                style: AlterTypography.body.copyWith(
                  color: AlterSemanticTokens.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // Bulk Option (#400:10515)
                  Expanded(
                    child: ToggleText(
                      label: 'Bulk 💪',
                      hasIcon: false,
                      isSelected: _selectedGoal == UserGoal.bulk,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _selectedGoal = _selectedGoal == UserGoal.bulk ? null : UserGoal.bulk;
                        });
                        widget.onGoalChanged?.call(_selectedGoal);
                        _notifyValidity();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Cut Option (#400:10516)
                  Expanded(
                    child: ToggleText(
                      label: 'Cut 📉',
                      hasIcon: false,
                      isSelected: _selectedGoal == UserGoal.cut,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _selectedGoal = _selectedGoal == UserGoal.cut ? null : UserGoal.cut;
                        });
                        widget.onGoalChanged?.call(_selectedGoal);
                        _notifyValidity();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Maintain Option (#400:10531)
                  Expanded(
                    child: ToggleText(
                      label: 'Maintain',
                      hasIcon: false,
                      isSelected: _selectedGoal == UserGoal.maintain,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _selectedGoal = _selectedGoal == UserGoal.maintain ? null : UserGoal.maintain;
                        });
                        widget.onGoalChanged?.call(_selectedGoal);
                        _notifyValidity();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
