import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:alter/alter.dart';

/// Step 1: About You component for Onboarding flow
///
/// Figma Node: `387:9071` (AboutYou - Step 1) -> `mainContainer` (#387:9073)
/// Structure:
/// - mainContainer:
///   - Fill: `AlterSemanticTokens.baseWhite` (#FFFFFF)
///   - Border Radius: 24px
///   - Padding: 24px
///   - Gap: 24px
///   - Child 1: `TextInput` for Name (placeholder: "Name", characterLimit: 32)
///   - Child 2: `TextInput` for DOB (placeholder: "Date of birth (DD/MM/YYYY)", formatted DD/MM/YYYY, validation: >= 12 years old)
///   - Child 3: `sexContainer` with two `ToggleText`s ("Male" with Icons.face_5_outlined, "Female" with Icons.face_3_outlined), with focus dismissal on tap
class StepOnePage extends StatefulWidget {
  /// Component version for reference
  /// v1.3.0: Added character limit on Name, DOB >= 12 years validation with error display, keyboard unfocus on sex selection, and live validity notification.
  /// v1.2.0: Moved Next button out of mainContainer into footerContainer matching updated Figma node 387:9071.
  /// v1.1.0: Updated to strictly unselected state (no default prefill for name, DOB, or sex), clean placeholders matching Figma node 387:9071.
  /// v1.0.0: Initial implementation matching Figma node 387:9071.
  static const String version = '1.3.0';

  final String? initialName;
  final DateTime? initialDob;
  final String? initialSex; // 'male' | 'female' | null
  final ValueChanged<String>? onNameChanged;
  final ValueChanged<DateTime?>? onDobChanged;
  final ValueChanged<String?>? onSexChanged;
  final ValueChanged<bool>? onValidityChanged;

  const StepOnePage({
    super.key,
    this.initialName,
    this.initialDob,
    this.initialSex,
    this.onNameChanged,
    this.onDobChanged,
    this.onSexChanged,
    this.onValidityChanged,
  });

  @override
  State<StepOnePage> createState() => _StepOnePageState();
}

class _StepOnePageState extends State<StepOnePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _dobController;
  String? _selectedSex;

  bool _isDobError = false;
  String _dobErrorMessage = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _dobController = TextEditingController(
      text: widget.initialDob != null
          ? '${widget.initialDob!.day.toString().padLeft(2, '0')}/${widget.initialDob!.month.toString().padLeft(2, '0')}/${widget.initialDob!.year}'
          : '',
    );
    _selectedSex = widget.initialSex;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  DateTime? _parseDob(String text) {
    final parts = text.split('/');
    if (parts.length == 3) {
      final day = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final year = int.tryParse(parts[2]);
      if (day != null && month != null && year != null && year > 1900 && year <= DateTime.now().year) {
        try {
          final d = DateTime(year, month, day);
          if (d.year == year && d.month == month && d.day == day) {
            return d;
          }
        } catch (_) {}
      }
    }
    return null;
  }

  void _validateDob(String text) {
    if (text.isEmpty) {
      _isDobError = false;
      _dobErrorMessage = '';
      return;
    }

    if (text.length == 10) {
      final parsed = _parseDob(text);
      if (parsed == null) {
        _isDobError = true;
        _dobErrorMessage = 'Invalid date (DD/MM/YYYY)';
      } else {
        final now = DateTime.now();
        final minAgeDate = DateTime(now.year - 12, now.month, now.day);
        if (parsed.isAfter(minAgeDate)) {
          _isDobError = true;
          _dobErrorMessage = 'Must be at least 12 years old';
        } else {
          _isDobError = false;
          _dobErrorMessage = '';
        }
      }
    } else {
      _isDobError = false;
      _dobErrorMessage = '';
    }
  }

  bool get _isValid {
    final nameValid = _nameController.text.trim().isNotEmpty && _nameController.text.length <= 32;
    final dob = _parseDob(_dobController.text.trim());
    final now = DateTime.now();
    final minAgeDate = DateTime(now.year - 12, now.month, now.day);
    final dobValid = dob != null && !_isDobError && !dob.isAfter(minAgeDate);
    final sexValid = _selectedSex != null;
    return nameValid && dobValid && sexValid;
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
          // 1. Name TextInput (#387:9107) with characterLimit: 32
          TextInput(
            controller: _nameController,
            placeholder: 'Name',
            label: null,
            leftIcon: null,
            characterLimit: 32,
            textInputAction: TextInputAction.next,
            onChanged: (val) {
              widget.onNameChanged?.call(val);
              setState(() {});
              _notifyValidity();
            },
          ),
          const SizedBox(height: 24),

          // 2. Date of Birth TextInput (#387:9123) with >= 12 years validation & error display
          TextInput(
            controller: _dobController,
            placeholder: 'Date of birth (DD/MM/YYYY)',
            label: null,
            leftIcon: null,
            characterLimit: null,
            keyboardType: TextInputType.number,
            inputFormatters: [
              _DateInputFormatter(),
            ],
            isError: _isDobError,
            errorMessage: _dobErrorMessage,
            showErrorMessage: _isDobError,
            textInputAction: TextInputAction.done,
            onChanged: (val) {
              _validateDob(val);
              final dob = _parseDob(val);
              widget.onDobChanged?.call(_isDobError ? null : dob);
              setState(() {});
              _notifyValidity();
            },
          ),
          const SizedBox(height: 24),

          // 3. Sex Toggle Buttons Row (#387:9146) with focus dismissal
          Row(
            children: [
              Expanded(
                child: ToggleText(
                  label: 'Male',
                  icon: Icons.face_5_outlined,
                  isSelected: _selectedSex == 'male',
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      _selectedSex = _selectedSex == 'male' ? null : 'male';
                    });
                    widget.onSexChanged?.call(_selectedSex);
                    _notifyValidity();
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ToggleText(
                  label: 'Female',
                  icon: Icons.face_3_outlined,
                  isSelected: _selectedSex == 'female',
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      _selectedSex = _selectedSex == 'female' ? null : 'female';
                    });
                    widget.onSexChanged?.call(_selectedSex);
                    _notifyValidity();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Formatter for auto-inserting slashes in DD/MM/YYYY
class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (text.length > 8) {
      return oldValue;
    }

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) {
        buffer.write('/');
      }
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
