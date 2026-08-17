import 'package:flutter/material.dart';
import '../../styles/tokens.dart';
import 'bottom_navigation_item.dart';

class BottomNavigationItemData {
  final String label;
  final IconData icon;

  const BottomNavigationItemData({
    required this.label,
    required this.icon,
  });
}

class AlterBottomNavigationBar extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.0.1';

  final int selectedIndex;
  final List<BottomNavigationItemData> items;
  final ValueChanged<int>? onItemTapped;

  const AlterBottomNavigationBar({
    super.key,
    this.selectedIndex = 0,
    this.items = const [
      BottomNavigationItemData(label: 'Home', icon: Icons.home_outlined),
      BottomNavigationItemData(label: 'Search', icon: Icons.search),
      BottomNavigationItemData(label: 'Profile', icon: Icons.person_outline),
    ],
    this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AlterSemanticTokens.baseGray,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          final item = items[index];
          return BottomNavigationItem(
            label: item.label,
            icon: item.icon,
            isSelected: index == selectedIndex,
            onTap: () => onItemTapped?.call(index),
          );
        }),
      ),
    );
  }
}
