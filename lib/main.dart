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

  // Configure ApplicationHeader per tab index
  ApplicationHeader _buildHeaderForIndex(int index) {
    switch (index) {
      case 0:
        // Track Page Header
        return ApplicationHeader(
          title: 'Today',
          subtitle: '0/2300 calories • 0/120g protein',
          hasStyleButton: true,
          hasActionOne: false,
          hasActionTwo: false,
          hasProfileAction: true,
          onProfileTap: () {
            debugPrint('Profile Tapped');
          },
          onStyleButtonTap: () {
            debugPrint('Streak Tapped');
          },
        );
      case 1:
        // Stats Page Header
        return ApplicationHeader(
          title: 'Stats',
          subtitle: 'Just do it',
          hasStyleButton: true,
          hasActionOne: false,
          hasActionTwo: false,
          hasProfileAction: false,
          onStyleButtonTap: () {
            debugPrint('Streak Tapped');
          },
        );
      case 2:
        // Routine Page Header
        return ApplicationHeader(
          title: 'Plan Routine',
          subtitle: '2300 calories • 120g protein',
          hasStyleButton: false,
          hasActionOne: false,
          hasActionTwo: false,
          hasProfileAction: false,
        );
      default:
        return const ApplicationHeader(
          title: 'Horizon',
          subtitle: 'Design System',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlterSemanticTokens.baseGray,
      body: SafeArea(
        child: Stack(
          children: [
            // Main App Container with Shared Dynamic Header
            Column(
              children: [
                _buildHeaderForIndex(_currentIndex),
                Expanded(
                  child: IndexedStack(
                    index: _currentIndex,
                    children: _pages,
                  ),
                ),
              ],
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
      ),
    );
  }
}
