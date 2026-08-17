import 'package:flutter/material.dart';
import '../alter/alter.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  // Independent test states for each interactive pill (Selection toggles)
  bool _calorieSelected = false;
  bool _proteinSelected = false;
  bool _completedCalorieSelected = false;
  bool _completedProteinSelected = false;

  bool _breakfastSelected = false;
  bool _lunchSelected = false;
  bool _completedBreakfastSelected = false;
  bool _completedLunchSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlterSemanticTokens.baseGray,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pill Components Demo',
              style: AlterTypography.h2.copyWith(
                color: AlterSemanticTokens.textPrimary,
              ),
            ),
            const SizedBox(height: 24),

            // -----------------------------------------------------------------
            // 1. DEFAULT SIZE PILLS (INTERACTIVE)
            // -----------------------------------------------------------------
            Text(
              '1. Default Size (Interactive: ON)',
              style: AlterTypography.bodyLgBold.copyWith(
                color: AlterSemanticTokens.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Incomplete (Tap to toggle selection):',
              style: AlterTypography.caption.copyWith(
                color: AlterSemanticTokens.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Pill(
                  label: 'Calories',
                  value: '2300',
                  size: PillSize.defaultSize,
                  color: PillColor.gray,
                  isSelected: _calorieSelected,
                  isInteractive: true,
                  onTap: () {
                    setState(() {
                      _calorieSelected = !_calorieSelected;
                    });
                  },
                ),
                Pill(
                  label: 'Protein',
                  value: '120g',
                  size: PillSize.defaultSize,
                  color: PillColor.neutral,
                  isSelected: _proteinSelected,
                  isInteractive: true,
                  onTap: () {
                    setState(() {
                      _proteinSelected = !_proteinSelected;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            Text(
              'Completed (isCompleted: true, Tap to toggle selection):',
              style: AlterTypography.caption.copyWith(
                color: AlterSemanticTokens.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Pill(
                  label: 'Calories (Done)',
                  value: '2300 / 2300',
                  size: PillSize.defaultSize,
                  color: PillColor.gray,
                  isCompleted: true,
                  isSelected: _completedCalorieSelected,
                  isInteractive: true,
                  onTap: () {
                    setState(() {
                      _completedCalorieSelected = !_completedCalorieSelected;
                    });
                  },
                ),
                Pill(
                  label: 'Protein (Done)',
                  value: '120g / 120g',
                  size: PillSize.defaultSize,
                  color: PillColor.neutral,
                  isCompleted: true,
                  isSelected: _completedProteinSelected,
                  isInteractive: true,
                  onTap: () {
                    setState(() {
                      _completedProteinSelected = !_completedProteinSelected;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // -----------------------------------------------------------------
            // 2. DEFAULT SIZE PILLS (NON-INTERACTIVE)
            // -----------------------------------------------------------------
            Text(
              '2. Default Size (Interactive: OFF)',
              style: AlterTypography.bodyLgBold.copyWith(
                color: AlterSemanticTokens.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Static visual states showcase',
              style: AlterTypography.caption.copyWith(
                color: AlterSemanticTokens.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Pill(
                  label: 'Default',
                  value: '100%',
                  size: PillSize.defaultSize,
                  color: PillColor.gray,
                  isInteractive: false,
                ),
                Pill(
                  label: 'Selected',
                  value: 'Active',
                  size: PillSize.defaultSize,
                  color: PillColor.gray,
                  isSelected: true,
                  isInteractive: false,
                ),
                Pill(
                  label: 'Completed',
                  value: 'Done',
                  size: PillSize.defaultSize,
                  color: PillColor.gray,
                  isCompleted: true,
                  isInteractive: false,
                ),
                Pill(
                  label: 'Neutral Done',
                  value: 'Goal',
                  size: PillSize.defaultSize,
                  color: PillColor.neutral,
                  isCompleted: true,
                  isInteractive: false,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // -----------------------------------------------------------------
            // 3. COMPACT PILLS (INTERACTIVE)
            // -----------------------------------------------------------------
            Text(
              '3. Compact Size (Interactive: ON)',
              style: AlterTypography.bodyLgBold.copyWith(
                color: AlterSemanticTokens.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Incomplete (Tap to toggle selection):',
              style: AlterTypography.caption.copyWith(
                color: AlterSemanticTokens.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Pill(
                  label: 'Breakfast',
                  size: PillSize.compact,
                  color: PillColor.gray,
                  isSelected: _breakfastSelected,
                  isInteractive: true,
                  onTap: () {
                    setState(() {
                      _breakfastSelected = !_breakfastSelected;
                    });
                  },
                ),
                Pill(
                  label: 'Lunch',
                  size: PillSize.compact,
                  color: PillColor.neutral,
                  isSelected: _lunchSelected,
                  isInteractive: true,
                  onTap: () {
                    setState(() {
                      _lunchSelected = !_lunchSelected;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            Text(
              'Completed (isCompleted: true, Tap to toggle selection):',
              style: AlterTypography.caption.copyWith(
                color: AlterSemanticTokens.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Pill(
                  label: 'Breakfast (Done)',
                  size: PillSize.compact,
                  color: PillColor.gray,
                  isCompleted: true,
                  isSelected: _completedBreakfastSelected,
                  isInteractive: true,
                  onTap: () {
                    setState(() {
                      _completedBreakfastSelected = !_completedBreakfastSelected;
                    });
                  },
                ),
                Pill(
                  label: 'Lunch (Done)',
                  size: PillSize.compact,
                  color: PillColor.neutral,
                  isCompleted: true,
                  isSelected: _completedLunchSelected,
                  isInteractive: true,
                  onTap: () {
                    setState(() {
                      _completedLunchSelected = !_completedLunchSelected;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // -----------------------------------------------------------------
            // 4. COMPACT PILLS (NON-INTERACTIVE)
            // -----------------------------------------------------------------
            Text(
              '4. Compact Size (Interactive: OFF)',
              style: AlterTypography.bodyLgBold.copyWith(
                color: AlterSemanticTokens.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Static compact states showcase',
              style: AlterTypography.caption.copyWith(
                color: AlterSemanticTokens.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Pill(
                  label: 'Default',
                  size: PillSize.compact,
                  color: PillColor.gray,
                  isInteractive: false,
                ),
                Pill(
                  label: 'Selected',
                  size: PillSize.compact,
                  color: PillColor.gray,
                  isSelected: true,
                  isInteractive: false,
                ),
                Pill(
                  label: 'Completed',
                  size: PillSize.compact,
                  color: PillColor.gray,
                  isCompleted: true,
                  isInteractive: false,
                ),
                Pill(
                  label: 'Neutral Done',
                  size: PillSize.compact,
                  color: PillColor.neutral,
                  isCompleted: true,
                  isInteractive: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
