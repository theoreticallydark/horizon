import 'package:flutter/material.dart';
import 'alter/alter.dart';
import 'data/services/isar_service.dart';
import 'data/services/nutrition_tracking_service.dart';
import 'horizon/debug_modal.dart';
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
  String? _selectedNutrientKey;
  bool _isAddSourceOpen = false;
  bool _isSearchActive = false;

  void _handleNutrientTap(String nutrientKey) {
    setState(() {
      if (_selectedNutrientKey == nutrientKey) {
        _selectedNutrientKey = null; // deselect on second tap
      } else {
        _selectedNutrientKey = nutrientKey;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final hideNutrientMap = _isSearchActive && isKeyboardVisible;

    final pages = [
      TrackPage(selectedNutrientKey: _selectedNutrientKey),
      const StatsPage(),
      RoutinePage(
        selectedNutrientKey: _selectedNutrientKey,
        isAddSourceOpen: _isAddSourceOpen,
        onAddSourceClose: () => setState(() {
          _isAddSourceOpen = false;
          _isSearchActive = false;
        }),
        onSearchActiveChanged: (active) =>
            setState(() => _isSearchActive = active),
      ),
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
                  selectedNutrientKey: _selectedNutrientKey,
                  onNutrientTap: _handleNutrientTap,
                  hideNutrientMap: hideNutrientMap,
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
            if (!_isAddSourceOpen || _currentIndex != 2)
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
                          _selectedNutrientKey = null;
                          _isAddSourceOpen = false;
                          _isSearchActive = false;
                        }
                        _currentIndex = index;
                      });
                    },
                    onPrimaryActionTap: () {
                      if (_currentIndex == 2) {
                        setState(() {
                          _isAddSourceOpen = !_isAddSourceOpen;
                        });
                      } else {
                        debugPrint('Primary Action Button Tapped!');
                      }
                    },
                  ),
                ),
              ),

            // Floating Debug & Time Travel Button (Top-Right of Viewport)
            Positioned(
              top: 14,
              right: 14,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    HorizonDebugModal.show(context, initialTabIndex: _currentIndex);
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AlterSemanticTokens.baseWhite.withAlpha(220),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AlterSemanticTokens.stroke100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(15),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.bug_report,
                      size: 20,
                      color: AlterSemanticTokens.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
