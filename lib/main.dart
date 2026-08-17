import 'package:flutter/material.dart';
import 'alter/alter.dart';
import 'pages/routine_page.dart';
import 'pages/stats_page.dart';
import 'pages/track_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Geist',
      ),
      home: const HorizonAppShell(),
    );
  }
}

class HorizonAppShell extends StatefulWidget {
  const HorizonAppShell({super.key});

  @override
  State<HorizonAppShell> createState() => _HorizonAppShellState();
}

class _HorizonAppShellState extends State<HorizonAppShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    TrackPage(),
    StatsPage(),
    RoutinePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlterSemanticTokens.baseWhite,
      body: Stack(
        children: [
          // Active Page Screen
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),

          // Floating Bottom Navigation Action Bar (Floating 28px from bottom)
          Positioned(
            left: 0,
            right: 0,
            bottom: 28,
            child: Center(
              child: BottomNavigationBarAction(
                type: BottomNavigationBarActionType.defaultAction,
                selectedIndex: _currentIndex,
                items: const [
                  BottomNavigationItemData(
                    label: 'Track',
                    icon: Icons.track_changes_outlined,
                  ),
                  BottomNavigationItemData(
                    label: 'Stats',
                    icon: Icons.dataset_outlined,
                  ),
                  BottomNavigationItemData(
                    label: 'Routine',
                    icon: Icons.egg_outlined,
                  ),
                ],
                primaryActionIcon: Icons.add_circle_outline,
                primaryActionType: BottomNavigationButtonType.secondary,
                onItemTapped: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                onPrimaryActionTap: () {
                  debugPrint('Primary Action Button Tapped!');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
