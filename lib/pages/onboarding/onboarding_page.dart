import 'package:flutter/material.dart';
import 'package:alter/alter.dart';
import '../../data/models/user_profile.dart';
import '../../data/services/isar_service.dart';
import '../../horizon/horizon_application_header.dart';
import 'step_one_page.dart';
import 'step_two_page.dart';
import 'step_three_page.dart';

/// Master Onboarding Coordinator Page
///
/// Global layout matching Figma Node `387:9071`:
/// - Background: `AlterSemanticTokens.baseGray` (#F9FAFB)
/// - Direction: Column (crossAxisAlignment: stretch, 0 padding, 0 gap)
/// - Child 1: `HorizonApplicationHeader` (#387:9072) - Fill: `AlterSemanticTokens.baseGray`, edge-to-edge, hasReturnButton: false
/// - Child 2: `Expanded(child: mainContainer)` (#387:9073) - Fill: `AlterSemanticTokens.baseWhite`, Radius: 24px
/// - Child 3: `footerContainer` (#509:268) - Fill: `AlterSemanticTokens.baseWhite`, Padding: 24px + bottom safe-area, hosting `ButtonText` Large Primary with 48% disabled opacity
class OnboardingPage extends StatefulWidget {
  /// Component version for reference
  /// v1.11.0: Finalized 3-step onboarding flow (removed Step 4), updated Step 3 CTA to 'Launch Horizon', and synchronized selected nutrientTargets with NutrientInfo.isTracked in Isar.
  /// v1.10.0: Integrated Step 3 (Set nutrient targets) matching Figma node 387:10075 with multi-select ToggleTexts, gating Next on >= 1 selected nutrient and persisting to UserProfile.nutrientTargets in Isar.
  /// v1.9.0: Integrated Goal selection in Step 2, mapped to UserProfile.goal in Isar.
  /// v1.8.0: Integrated Step 2 (weight 20-300kg, height 50-250cm) validation controlling Next button disabled state.
  /// v1.7.0: Enforced Step 1 input validation (Name, DOB >= 12y, Sex) controlling Next button enabled/disabled state (48% opacity).
  /// v1.6.0: Integrated StepTwoPage (weightKg & heightCm), dynamic header "Hello {name} 👋" on Step 2, hasReturnButton: false across all steps with PopScope back-step support.
  /// v1.5.0: Mapped and persisted Step 1 inputs (name, dateOfBirth, sex) to UserProfile model in Isar.
  /// v1.4.0: Switched to HorizonApplicationHeader with baseGray fill matching Figma transparent header spec.
  /// v1.3.0: Removed SafeArea from root screen, applied top safe-area padding to ApplicationHeader and bottom padding to footerContainer.
  /// v1.2.0: Added footerContainer holding ButtonText matching updated Figma node 387:9071.
  /// v1.1.0: Strictly match Figma node 387:9072 (hasReturnButton: false for Step 1), unselected draft state.
  /// v1.0.0: Initial release of Onboarding Coordinator hosting Step 1 (About You).
  static const String version = '1.11.0';

  final VoidCallback? onReturnToLanding;
  final VoidCallback? onComplete;

  const OnboardingPage({
    super.key,
    this.onReturnToLanding,
    this.onComplete,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentStep = 0;

  // Onboarding draft state across steps (mapping to UserProfile)
  String? _name;
  DateTime? _dateOfBirth;
  String? _sex;
  double? _weightKg;
  double? _heightCm;
  UserGoal? _goal;
  List<String> _selectedNutrientTargets = [];

  bool _isStepOneValid = false;
  bool _isStepTwoValid = false;
  bool _isStepThreeValid = false;

  String get _headerTitle {
    switch (_currentStep) {
      case 0:
        return 'About you';
      case 1:
        final displayName = (_name != null && _name!.trim().isNotEmpty)
            ? _name!.trim()
            : 'there';
        return 'Hello $displayName 👋';
      case 2:
        return 'Set nutrient targets';
      default:
        return 'Onboarding';
    }
  }

  String get _headerSubtitle {
    switch (_currentStep) {
      case 0:
        return 'Gotta know what to call ya 👽';
      case 1:
        return 'Help us calculate your RDAs';
      case 2:
        return 'Select nutrients for tracking 🤤';
      default:
        return '';
    }
  }

  bool get _isNextEnabled {
    switch (_currentStep) {
      case 0:
        return _isStepOneValid;
      case 1:
        return _isStepTwoValid;
      case 2:
        return _isStepThreeValid;
      default:
        return true;
    }
  }

  void _handleBack() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else {
      widget.onReturnToLanding?.call();
    }
  }

  Future<void> _handleNext() async {
    if (!_isNextEnabled) return;

    // Persist active step data to UserProfile in Isar
    await IsarService.instance.updateUserProfile(
      name: _name,
      dateOfBirth: _dateOfBirth,
      sex: _sex,
      weightKg: _weightKg,
      heightCm: _heightCm,
      goal: _goal,
      nutrientTargets: _selectedNutrientTargets.isNotEmpty ? _selectedNutrientTargets : null,
    );

    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    } else {
      widget.onComplete?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return PopScope(
      canPop: _currentStep == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _handleBack();
        }
      },
      child: Scaffold(
        backgroundColor: AlterSemanticTokens.baseGray,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Child 1: HorizonApplicationHeader (#387:9072) with baseGray fill & top safe-area
            HorizonApplicationHeader(
              title: _headerTitle,
              subtitle: _headerSubtitle,
              hasReturnButton: false,
              hasStyleButton: false,
              hasActionOne: false,
              hasActionTwo: false,
              hasProfileAction: false,
            ),

            // Child 2: mainContainer content (#387:9073) - Expanded
            Expanded(
              child: IndexedStack(
                index: _currentStep,
                children: [
                  // Step 1: About You
                  StepOnePage(
                    initialName: _name,
                    initialDob: _dateOfBirth,
                    initialSex: _sex,
                    onNameChanged: (val) {
                      _name = val;
                      setState(() {});
                    },
                    onDobChanged: (val) {
                      _dateOfBirth = val;
                      setState(() {});
                    },
                    onSexChanged: (val) {
                      _sex = val;
                      setState(() {});
                    },
                    onValidityChanged: (valid) {
                      setState(() {
                        _isStepOneValid = valid;
                      });
                    },
                  ),

                  // Step 2: Body Metrics & Fitness Goal
                  StepTwoPage(
                    initialWeight: _weightKg,
                    initialHeight: _heightCm,
                    initialGoal: _goal,
                    onWeightChanged: (val) {
                      _weightKg = val;
                      setState(() {});
                    },
                    onHeightChanged: (val) {
                      _heightCm = val;
                      setState(() {});
                    },
                    onGoalChanged: (val) {
                      _goal = val;
                      setState(() {});
                    },
                    onValidityChanged: (valid) {
                      setState(() {
                        _isStepTwoValid = valid;
                      });
                    },
                  ),

                  // Step 3: Set Nutrient Targets
                  StepThreePage(
                    initialSelectedNutrients: _selectedNutrientTargets,
                    onNutrientsChanged: (val) {
                      _selectedNutrientTargets = val;
                      setState(() {});
                    },
                    onValidityChanged: (valid) {
                      setState(() {
                        _isStepThreeValid = valid;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Child 3: footerContainer (#509:268) - Fill: baseWhite, Padding: 24px + bottom safe-area
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomPadding),
              decoration: const BoxDecoration(
                color: AlterSemanticTokens.baseWhite,
              ),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isNextEnabled ? 1.0 : 0.48,
                child: ButtonText(
                  label: _currentStep == 2 ? 'Launch Horizon' : 'Next',
                  type: ButtonType.primary,
                  size: ButtonSize.large,
                  onTap: _isNextEnabled ? _handleNext : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
