import 'package:flutter/material.dart';
import 'alter/alter.dart';
import 'data/services/isar_service.dart';
import 'horizon/horizon_application_header.dart';
import 'horizon/horizon_bottom_navigation_bar_action.dart';
import 'pages/routine_page.dart';
import 'pages/stats_page.dart';
import 'pages/track_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.instance.init();
  await IsarService.instance.seedDemoRoutine();
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
      backgroundColor: AlterSemanticTokens.baseGray,
      body: SafeArea(
        child: Stack(
          children: [
            // Main App Container with Shared Horizon Header Wrapper
            Column(
              children: [
                HorizonApplicationHeader(
                  currentIndex: _currentIndex,
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
                child: HorizonBottomNavigationBarAction(
                  selectedIndex: _currentIndex,
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
