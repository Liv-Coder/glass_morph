import 'dart:async';
import 'package:flutter/material.dart';

/// A utility class for tracking scroll velocity and providing dynamic blur values
/// based on scroll speed for glass-morphism effects.
class ScrollVelocityTracker {
  final ScrollController _scrollController;
  Timer? _velocityTimer;
  double _lastPosition = 0.0;
  double _lastTime = 0.0;
  double _currentVelocity = 0.0;

  /// Callback when velocity changes
  final void Function(double velocity)? onVelocityChanged;

  /// Minimum velocity threshold to trigger blur changes
  final double minVelocityThreshold;

  /// Maximum blur value
  final double maxBlur;

  /// Minimum blur value
  final double minBlur;

  ScrollVelocityTracker({
    required ScrollController scrollController,
    this.onVelocityChanged,
    this.minVelocityThreshold = 50.0,
    this.maxBlur = 20.0,
    this.minBlur = 8.0,
  }) : _scrollController = scrollController {
    _initializeTracking();
  }

  void _initializeTracking() {
    _scrollController.addListener(_onScroll);
    _startVelocityTracking();
  }

  void _onScroll() {
    final currentPosition = _scrollController.position.pixels;
    final currentTime = DateTime.now().millisecondsSinceEpoch.toDouble();

    if (_lastTime != 0.0) {
      final timeDelta =
          (currentTime - _lastTime) / 1000.0; // Convert to seconds
      final positionDelta = currentPosition - _lastPosition;

      if (timeDelta > 0) {
        _currentVelocity = (positionDelta / timeDelta).abs();
        onVelocityChanged?.call(_currentVelocity);
      }
    }

    _lastPosition = currentPosition;
    _lastTime = currentTime;
  }

  void _startVelocityTracking() {
    _velocityTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      // Gradually reduce velocity when not scrolling
      if (_currentVelocity > 0) {
        _currentVelocity *= 0.95; // Decay factor
        if (_currentVelocity < minVelocityThreshold) {
          _currentVelocity = 0.0;
        }
        onVelocityChanged?.call(_currentVelocity);
      }
    });
  }

  /// Get the current blur value based on scroll velocity
  double getBlurValue() {
    if (_currentVelocity < minVelocityThreshold) {
      return minBlur;
    }

    // Map velocity to blur value using exponential scaling
    final normalizedVelocity = (_currentVelocity - minVelocityThreshold) /
        (minVelocityThreshold * 4); // Scale factor

    final blurRange = maxBlur - minBlur;
    final blurValue =
        minBlur + (blurRange * (1 - (1 / (1 + normalizedVelocity))));

    return blurValue.clamp(minBlur, maxBlur);
  }

  /// Get the current velocity in pixels per second
  double get currentVelocity => _currentVelocity;

  /// Check if currently scrolling at significant velocity
  bool get isScrollingFast => _currentVelocity >= minVelocityThreshold;

  void dispose() {
    _velocityTimer?.cancel();
    _scrollController.removeListener(_onScroll);
  }
}

/// Extension on ScrollController to easily create a ScrollVelocityTracker
extension ScrollVelocityTrackerExtension on ScrollController {
  ScrollVelocityTracker createVelocityTracker({
    void Function(double velocity)? onVelocityChanged,
    double minVelocityThreshold = 50.0,
    double maxBlur = 20.0,
    double minBlur = 8.0,
  }) {
    return ScrollVelocityTracker(
      scrollController: this,
      onVelocityChanged: onVelocityChanged,
      minVelocityThreshold: minVelocityThreshold,
      maxBlur: maxBlur,
      minBlur: minBlur,
    );
  }
}
