import 'package:flutter/material.dart';
import '../alter/alter.dart';
import '../horizon/horizon_list_item.dart';
import '../horizon/horizon_title_bar.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  bool _isDailyChecked = false;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AlterSemanticTokens.baseWhite,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HorizonTitleBar(
              title: 'HorizonListItem',
              subtitle: 'Variants Preview (Figma 130:4671)',
            ),
            const SizedBox(height: 16),

            // 1. Track Daily (Unchecked & Checked handled dynamically)
            HorizonListItem(
              title: 'Guava, 100g',
              host: HorizonListItemHost.trackDaily,
              isChecked: _isDailyChecked,
              onCheckboxChanged: (state) {
                setState(() => _isDailyChecked = state == CheckboxState.checked);
              },
              onTap: () {
                setState(() => _isDailyChecked = !_isDailyChecked);
              },
            ),
            const SizedBox(height: 8),

            // 2. Track Weekly
            HorizonListItem(
              title: 'Guava',
              subtitle: 'Vitamin C • Magnesium',
              host: HorizonListItemHost.trackWeekly,
              onRightActionTap: () {},
            ),
            const SizedBox(height: 8),

            // 4. Track Weekly Checked
            const HorizonListItem(
              title: 'Guava',
              subtitle: 'Vitamin C • Magnesium',
              host: HorizonListItemHost.trackWeeklyChecked,
              isChecked: true,
            ),
            const SizedBox(height: 8),

            // 5. Routine
            HorizonListItem(
              title: 'Guava',
              subtitle: 'Vitamin C • Magnesium',
              host: HorizonListItemHost.routine,
              onLeftActionTap: () {},
              onRightActionTap: () {},
            ),
            const SizedBox(height: 8),

            // 6. Routine Remove
            HorizonListItem(
              title: 'Guava',
              subtitle: 'Vitamin C • Magnesium',
              host: HorizonListItemHost.routineRemove,
              onLeftActionTap: () {},
              onRightActionTap: () {},
            ),
            const SizedBox(height: 8),

            // 7. Add
            HorizonListItem(
              title: 'Guava',
              subtitle: 'Vitamin C • Magnesium',
              host: HorizonListItemHost.add,
              isFavorite: _isFavorite,
              onFavoriteChanged: (state) {
                setState(() => _isFavorite = state == ToggleIconState.checked);
              },
              onRightActionTap: () {},
            ),
            const SizedBox(height: 8),

            // 8. Add isFavorite
            HorizonListItem(
              title: 'Guava',
              subtitle: 'Vitamin C • Magnesium',
              host: HorizonListItemHost.addIsFavorite,
              isFavorite: true,
              onFavoriteChanged: (state) {},
              onRightActionTap: () {},
            ),

            // Bottom padding offset for bottom navigation bar
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
