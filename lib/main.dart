import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alter/alter.dart';
import 'data/services/isar_service.dart';
import 'data/services/nutrition_tracking_service.dart';
import 'horizon/debug_modal.dart';
import 'horizon/horizon_application_header.dart';
import 'horizon/horizon_bottom_navigation_bar_action.dart';
import 'pages/onboarding/landing_page.dart';
import 'pages/onboarding/onboarding_page.dart';
import 'pages/routine_page.dart';
import 'pages/stats_page.dart';
import 'pages/track_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  await IsarService.instance.init();
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
      home: Builder(
        builder: (context) => LandingPage(
          onGetStarted: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => OnboardingPage(
                  onReturnToLanding: () => Navigator.of(context).pop(),
                  onComplete: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HorizonAppShell()),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
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
  bool _isAddSourceTrackOpen = false;
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
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final hideNutrientMap = _isSearchActive && isKeyboardVisible;
    final isModalOpen = (_currentIndex == 2 && _isAddSourceOpen) ||
        (_currentIndex == 0 && _isAddSourceTrackOpen);

    final pages = [
      TrackPage(
        selectedNutrientKey: _selectedNutrientKey,
        isAddSourceOpen: _isAddSourceTrackOpen,
        onAddSourceClose: () => setState(() {
          _isAddSourceTrackOpen = false;
          _isSearchActive = false;
        }),
        onSearchActiveChanged: (active) =>
            setState(() => _isSearchActive = active),
      ),
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
      body: Stack(
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

          // Floating Bottom Navigation Action Bar
          if (!isModalOpen)
            Positioned(
              left: 0,
              right: 0,
              bottom: 28 + bottomPadding,
              child: Center(
                child: HorizonBottomNavigationBarAction(
                  selectedIndex: _currentIndex,
                  onItemTapped: (index) {
                    setState(() {
                      if (_currentIndex != index) {
                        _selectedNutrientKey = null;
                        _isAddSourceOpen = false;
                        _isAddSourceTrackOpen = false;
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
                    } else if (_currentIndex == 0) {
                      setState(() {
                        _isAddSourceTrackOpen = !_isAddSourceTrackOpen;
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
            top: 14 + topPadding,
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
    );
  }
}
