import 'package:flutter/material.dart' hide Checkbox;
import '../alter/alter.dart';
import '../horizon/horizon_list_item.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  CheckboxState _dailyCheck = CheckboxState.unchecked;
  CheckboxState _weeklyCheck = CheckboxState.unchecked;
  ToggleIconState _favState = ToggleIconState.unchecked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlterSemanticTokens.baseGray,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AlterSemanticTokens.baseWhite,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AlterSemanticTokens.stroke100),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'HorizonListItem (8 Variants)',
                        style: AlterTypography.h3.copyWith(
                          color: AlterSemanticTokens.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Figma Node: 130:4671',
                        style: AlterTypography.caption.copyWith(
                          color: AlterSemanticTokens.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AlterSemanticTokens.stroke100),

                // 1. Host = Track Daily
                _buildSectionHeader('1. Track Daily'),
                HorizonListItem(
                  host: HorizonListItemHost.trackDaily,
                  title: 'Guava',
                  isChecked: _dailyCheck == CheckboxState.checked,
                  onCheckboxChanged: (s) => setState(() => _dailyCheck = s),
                  onTap: () => debugPrint('Track Daily tapped'),
                ),
                const Divider(height: 1, color: AlterSemanticTokens.stroke100),

                // 2. Host = Track Daily Checked
                _buildSectionHeader('2. Track Daily Checked'),
                const HorizonListItem(
                  host: HorizonListItemHost.trackDailyChecked,
                  title: 'Guava',
                  isChecked: true,
                ),
                const Divider(height: 1, color: AlterSemanticTokens.stroke100),

                // 3. Host = Track Weekly
                _buildSectionHeader('3. Track Weekly'),
                HorizonListItem(
                  host: HorizonListItemHost.trackWeekly,
                  title: 'Guava',
                  subtitle: 'Vitamin C • Magnesium',
                  isChecked: _weeklyCheck == CheckboxState.checked,
                  onCheckboxChanged: (s) => setState(() => _weeklyCheck = s),
                  onTap: () => debugPrint('Track Weekly tapped'),
                ),
                const Divider(height: 1, color: AlterSemanticTokens.stroke100),

                // 4. Host = Track Weekly Checked
                _buildSectionHeader('4. Track Weekly Checked'),
                const HorizonListItem(
                  host: HorizonListItemHost.trackWeeklyChecked,
                  title: 'Guava',
                  subtitle: 'Vitamin C • Magnesium',
                  isChecked: true,
                ),
                const Divider(height: 1, color: AlterSemanticTokens.stroke100),

                // 5. Host = Routine
                _buildSectionHeader('5. Routine'),
                HorizonListItem(
                  host: HorizonListItemHost.routine,
                  title: 'Guava',
                  subtitle: 'Vitamin C • Magnesium',
                  onLeftActionTap: () => debugPrint('Routine remove tapped'),
                  onRightActionTap: () => debugPrint('Routine add portion tapped'),
                  onTap: () => debugPrint('Routine row tapped'),
                ),
                const Divider(height: 1, color: AlterSemanticTokens.stroke100),

                // 6. Host = Routine Remove
                _buildSectionHeader('6. Routine Remove (Destructive)'),
                HorizonListItem(
                  host: HorizonListItemHost.routineRemove,
                  title: 'Guava',
                  subtitle: 'Vitamin C • Magnesium',
                  onLeftActionTap: () => debugPrint('Routine confirmed delete tapped'),
                  onRightActionTap: () => debugPrint('Routine add portion tapped'),
                ),
                const Divider(height: 1, color: AlterSemanticTokens.stroke100),

                // 7. Host = Add
                _buildSectionHeader('7. Add (Search / Catalog)'),
                HorizonListItem(
                  host: HorizonListItemHost.add,
                  title: 'Guava',
                  subtitle: 'Vitamin C • Magnesium',
                  isFavorite: _favState == ToggleIconState.checked,
                  onFavoriteChanged: (s) => setState(() => _favState = s),
                  onRightActionTap: () => debugPrint('Add to routine tapped'),
                ),
                const Divider(height: 1, color: AlterSemanticTokens.stroke100),

                // 8. Host = Add isFavorite
                _buildSectionHeader('8. Add isFavorite (Search / Catalog)'),
                HorizonListItem(
                  host: HorizonListItemHost.addIsFavorite,
                  title: 'Guava',
                  subtitle: 'Vitamin C • Magnesium',
                  isFavorite: true,
                  onFavoriteChanged: (s) => setState(() => _favState = s),
                  onRightActionTap: () => debugPrint('Add to routine tapped'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 4),
      child: Text(
        title,
        style: AlterTypography.captionBold.copyWith(
          color: AlterSemanticTokens.textSecondary,
        ),
      ),
    );
  }
}
