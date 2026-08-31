import 'dart:async';
import 'package:flutter/foundation.dart';

/// Helper utility to manage tap-and-hold continuous value changes with initial delay and periodic stepping.
class ContinuousStepController {
  final Duration holdDelay;
  final Duration stepInterval;
  final double stepDelta;
  final double minValue;
  final double maxValue;
  final ValueChanged<double> onStep;
  final VoidCallback? onHoldEnd;

  Timer? _holdTimer;
  Timer? _continuousTimer;

  ContinuousStepController({
    this.holdDelay = const Duration(milliseconds: 350),
    this.stepInterval = const Duration(milliseconds: 80),
    this.stepDelta = 1.0,
    this.minValue = 1.0,
    this.maxValue = double.infinity,
    required this.onStep,
    this.onHoldEnd,
  });

  /// Starts the continuous step sequence.
  /// Steps once immediately, waits for [holdDelay], then steps every [stepInterval].
  void start({
    required double currentDelta,
    required double currentValue,
  }) {
    stop();

    // Initial immediate step
    final nextVal = (currentValue + currentDelta).clamp(minValue, maxValue);
    onStep(nextVal);

    _holdTimer = Timer(holdDelay, () {
      _continuousTimer = Timer.periodic(stepInterval, (timer) {
        if (currentDelta < 0 && currentValue <= minValue) {
          timer.cancel();
          return;
        }
        if (currentDelta > 0 && currentValue >= maxValue) {
          timer.cancel();
          return;
        }
        final stepped = (currentValue + currentDelta).clamp(minValue, maxValue);
        onStep(stepped);
      });
    });
  }

  /// Cancels any active hold/continuous timers and triggers [onHoldEnd].
  void stop() {
    _holdTimer?.cancel();
    _holdTimer = null;
    _continuousTimer?.cancel();
    _continuousTimer = null;
    onHoldEnd?.call();
  }

  /// Disposes timers cleanly.
  void dispose() {
    stop();
  }
}
