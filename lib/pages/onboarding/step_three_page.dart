import 'package:flutter/material.dart';
import 'package:alter/alter.dart';
import '../../data/models/nutrient_info.dart';
import '../../data/services/isar_service.dart';

/// Step 3: Set Nutrient Targets for Onboarding flow
///
/// Figma Node:
/// - Nutrient Target Selection: `387:10075`
///
/// Structure:
/// - mainContainer:
///   - Fill: `AlterSemanticTokens.baseWhite` (#FFFFFF)
///   - Border Radius: 24px
///   - Padding: 24px
///   - Content: Scrollable `Wrap` with spacing: 8px, runSpacing: 8px
///   - Children: `ToggleText` widgets for each visible nutrient in the database:
///     - `hasIcon: false`
///     - `label: nutrient.displayName`
///     - Multi-selection support (toggled on tap)
class StepThreePage extends StatefulWidget {
  /// Component version for reference
  /// v1.0.0: Initial implementation of Step 3 (Set nutrient targets) matching Figma node 387:10075 with multi-select ToggleTexts (hasIcon: false).
  static const String version = '1.0.0';

  final List<String>? initialSelectedNutrients;
  final ValueChanged<List<String>>? onNutrientsChanged;
  final ValueChanged<bool>? onValidityChanged;

  const StepThreePage({
    super.key,
    this.initialSelectedNutrients,
    this.onNutrientsChanged,
    this.onValidityChanged,
  });

  @override
  State<StepThreePage> createState() => _StepThreePageState();
}

class _StepThreePageState extends State<StepThreePage> {
  final Set<String> _selectedKeys = {};
  List<NutrientInfo> _nutrients = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.initialSelectedNutrients != null) {
      _selectedKeys.addAll(widget.initialSelectedNutrients!);
    }
    _loadNutrients();
  }

  Future<void> _loadNutrients() async {
    try {
      final list = await IsarService.instance.getVisibleNutrients();
      if (mounted) {
        setState(() {
          _nutrients = list;
          _isLoading = false;
        });
        _notifyValidity();
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool get _isValid => _selectedKeys.isNotEmpty;

  void _notifyValidity() {
    widget.onValidityChanged?.call(_isValid);
  }

  void _toggleNutrient(String key) {
    FocusScope.of(context).unfocus();
    setState(() {
      if (_selectedKeys.contains(key)) {
        _selectedKeys.remove(key);
      } else {
        _selectedKeys.add(key);
      }
    });
    widget.onNutrientsChanged?.call(_selectedKeys.toList());
    _notifyValidity();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AlterSemanticTokens.baseWhite,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: _isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _nutrients.map((nutrient) {
                    final isSelected = _selectedKeys.contains(nutrient.nutrientKey);
                    return ToggleText(
                      label: nutrient.displayName,
                      hasIcon: false,
                      isSelected: isSelected,
                      onTap: () => _toggleNutrient(nutrient.nutrientKey),
                    );
                  }).toList(),
                ),
              ),
      ),
    );
  }
}
