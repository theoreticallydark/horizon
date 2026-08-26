import 'package:flutter/material.dart';
import 'alter/alter.dart';
import 'data/services/isar_service.dart';
import 'data/services/nutrition_tracking_service.dart';
import 'horizon/horizon_application_header.dart';
import 'horizon/horizon_bottom_navigation_bar_action.dart';
import 'pages/routine_page.dart';
import 'pages/stats_page.dart';
import 'pages/track_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.instance.init();
  await IsarService.instance.seedDemoRoutine();
  await NutritionTrackingService().syncTrackRecordsWindow();
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
  final Set<String> _selectedNutrientKeys = <String>{};

  void _handleNutrientTap(String nutrientKey) {
    setState(() {
      if (_selectedNutrientKeys.contains(nutrientKey)) {
        _selectedNutrientKeys.remove(nutrientKey);
      } else {
        _selectedNutrientKeys.add(nutrientKey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      TrackPage(selectedNutrientKeys: _selectedNutrientKeys),
      const StatsPage(),
      RoutinePage(selectedNutrientKeys: _selectedNutrientKeys),
    ];

    return Scaffold(
      backgroundColor: AlterSemanticTokens.baseGray,
      body: SafeArea(
        child: Stack(
          children: [
            // Main App Container with Shared Horizon Header Wrapper
            Column(
              children: [
                HorizonApplicationHeader(
                  currentIndex: _currentIndex,
                  selectedNutrientKeys: _selectedNutrientKeys,
                  onNutrientTap: _handleNutrientTap,
                  onProfileTap: () {
                    debugPrint('Profile Tapped');
                  },
                  onStreakTap: () {
                    debugPrint('Streak Tapped');
                  },
                ),
                Expanded(
                  child: IndexedStack(
                    index: _currentIndex,
                    children: pages,
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
                child: HorizonBottomNavigationBarAction(
                  selectedIndex: _currentIndex,
                  onItemTapped: (index) {
                    setState(() {
                      if (_currentIndex != index) {
                        _selectedNutrientKeys.clear();
                      }
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
