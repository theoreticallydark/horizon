import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:alter/alter.dart';
import 'package:video_player/video_player.dart';

/// LandingPage Component
///
/// Figma Node: `387:8662` (Landing Page)
/// Layout:
/// - Background: `AlterSemanticTokens.baseGray` (#F9FAFB)
/// - Background Video: `cover_video` (#387:8991) looping `assets/horizon_cover_video.mp4` with BoxFit.cover
/// - Bottom Card: `mainContainer` (#387:9488) matching HorizonFoodModal structure:
///   - `width: double.infinity`
///   - `padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomPadding)`
///   - `BackdropFilter`: blur sigma 24, Fill: `AlterSemanticTokens.baseWhite` at 64% opacity, Radius: Top 24px
///   - Child 1: Title "Horizon 🍎" using `AlterTypography.hStyle` and `AlterSemanticTokens.textPrimary` (non-italic emoji)
///   - Child 2: Headline "Nutrient tracking for the creatures of habit." using Geist 24px/600 (height 32/24) and `AlterSemanticTokens.textPrimary`
///   - Child 3: `ButtonText` Large Primary with label "Get started"
///   - Child 4: Subtext "No account creation needed." using `AlterTypography.caption` and `AlterColors.colorsGray400`
class LandingPage extends StatefulWidget {
  /// Component version for reference
  /// v1.4.0: Added BackdropFilter with 24px blur (sigmaX: 24, sigmaY: 24) and 64% opacity background fill on mainContainer.
  /// v1.3.0: Set Title, Headline, and Subtext widths to fill, un-italicized apple emoji in title while keeping Horizon in hStyle, and ensured AlterTypography.caption for subtext.
  /// v1.2.0: Extended mainContainer flush to the bottom of screen with dynamic safe area bottom padding and top-only 24px radius.
  /// v1.1.0: Refined layout to exact Figma node 387:8662 & HorizonFoodModal placement (flush bottom container, radius 24, no arbitrary margins/shadows).
  /// v1.0.0: Initial implementation from Figma node 387:8662.
  static const String version = '1.4.0';

  final VoidCallback? onGetStarted;

  const LandingPage({
    super.key,
    this.onGetStarted,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    try {
      final controller = VideoPlayerController.asset('assets/horizon_cover_video.mp4');
      _controller = controller;
      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(0.0);
      await controller.play();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('LandingPage: Primary asset path failed ($e), trying fallback...');
      try {
        final fallbackController = VideoPlayerController.asset('lib/assets/horizon_cover_video.mp4');
        _controller = fallbackController;
        await fallbackController.initialize();
        await fallbackController.setLooping(true);
        await fallbackController.setVolume(0.0);
        await fallbackController.play();
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      } catch (fallbackError) {
        debugPrint('LandingPage: Video initialization failed: $fallbackError');
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AlterSemanticTokens.baseGray,
      body: Stack(
        children: [
          // Background Video (cover_video: #387:8991)
          Positioned.fill(
            child: _isInitialized && _controller != null
                ? SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller!.value.size.width,
                        height: _controller!.value.size.height,
                        child: VideoPlayer(_controller!),
                      ),
                    ),
                  )
                : Container(
                    color: AlterSemanticTokens.baseGray,
                  ),
          ),

          // Bottom Main Container Card (mainContainer: #387:9488)
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomPadding),
                  decoration: BoxDecoration(
                    color: AlterSemanticTokens.baseWhite.withValues(alpha: 0.64),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  // Title: "Horizon 🍎" (#387:9433) - W=Fill, hStyle with non-italic emoji
                  SizedBox(
                    width: double.infinity,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Horizon ',
                            style: AlterTypography.hStyle.copyWith(
                              color: AlterSemanticTokens.textPrimary,
                            ),
                          ),
                          TextSpan(
                            text: '🍎',
                            style: AlterTypography.hStyle.copyWith(
                              fontStyle: FontStyle.normal,
                              color: AlterSemanticTokens.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Headline: "Nutrient tracking for the Creatures of Habit." (#400:10512) - W=Fill
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Nutrient tracking for the creatures of habit.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AlterTypography.geistFont,
                        package: AlterTypography.package,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 32 / 24,
                        color: AlterSemanticTokens.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Primary Button: "Get started" (#387:9489) - W=Fill
                  ButtonText(
                    label: 'Get started',
                    type: ButtonType.primary,
                    size: ButtonSize.large,
                    onTap: widget.onGetStarted,
                  ),
                  const SizedBox(height: 16),

                  // Subtext: "No account creation needed." (#387:9490) - W=Fill, AlterTypography.caption
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'No account creation needed.',
                      textAlign: TextAlign.center,
                      style: AlterTypography.caption.copyWith(
                        color: AlterColors.colorsGray400,
                      ),
                    ),
                  ),
                ],
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
