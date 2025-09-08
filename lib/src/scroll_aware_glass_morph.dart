import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

/// A mixin that provides dynamic blur based on scroll velocity.
/// This mixin can be applied to any glass morphism widget to make
/// the blur effect responsive to scroll speed.
mixin ScrollAwareGlassMorph<T extends StatefulWidget> on State<T> {
  /// The scroll controller to monitor for velocity changes.
  ScrollController? get scrollController;

  /// The base blur value to use when not scrolling.
  double get baseBlur;

  /// The maximum blur multiplier when scrolling at high velocity.
  double get maxBlurMultiplier => 2.0;

  /// The velocity threshold above which blur increases.
  double get velocityThreshold => 1000.0; // pixels per second

  /// Animation controller for smooth blur transitions.
  late AnimationController _blurController;

  /// Variables for velocity calculation
  double _previousPosition = 0.0;
  DateTime _lastUpdateTime = DateTime.now();
  late Animation<double> _blurAnimation;

  /// Must be implemented by the class using this mixin to provide TickerProvider.
  TickerProvider get tickerProvider;

  @override
  void initState() {
    super.initState();
    _blurController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: tickerProvider,
    );
    _blurAnimation = Tween<double>(
      begin: baseBlur,
      end: baseBlur,
    ).animate(CurvedAnimation(
      parent: _blurController,
      curve: Curves.easeOut,
    ));

    scrollController?.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController?.removeListener(_onScroll);
    _blurController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (scrollController == null || !mounted) return;

    final velocity = scrollController!.position.activity is ScrollActivity
        ? (scrollController!.position.activity as dynamic).velocity ?? 0.0
        : 0.0;

    final absVelocity = velocity.abs();

    // Calculate blur multiplier based on velocity
    final blurMultiplier = absVelocity > velocityThreshold
        ? 1.0 +
            ((absVelocity - velocityThreshold) / velocityThreshold)
                .clamp(0.0, maxBlurMultiplier - 1.0)
        : 1.0;

    final targetBlur = baseBlur * blurMultiplier.clamp(1.0, maxBlurMultiplier);

    if ((targetBlur - _blurAnimation.value).abs() > 0.1) {
      _blurAnimation = Tween<double>(
        begin: _blurAnimation.value,
        end: targetBlur,
      ).animate(CurvedAnimation(
        parent: _blurController,
        curve: Curves.easeOut,
      ));

      _blurController.forward(from: 0.0);
    }
  }

  /// Get the current dynamic blur value based on scroll velocity.
  double get dynamicBlur => _blurAnimation.value;

  /// Apply dynamic blur to a widget using BackdropFilter.
  Widget applyDynamicBlur(
      {required Widget child, required BorderRadius borderRadius}) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: dynamicBlur,
          sigmaY: dynamicBlur,
        ),
        child: child,
      ),
    );
  }
}

/// A utility class for managing scroll-aware blur configurations.
class ScrollAwareConfig {
  const ScrollAwareConfig({
    this.maxBlurMultiplier = 2.0,
    this.velocityThreshold = 1000.0,
    this.blurTransitionDuration = const Duration(milliseconds: 150),
  });

  final double maxBlurMultiplier;
  final double velocityThreshold;
  final Duration blurTransitionDuration;

  ScrollAwareConfig copyWith({
    double? maxBlurMultiplier,
    double? velocityThreshold,
    Duration? blurTransitionDuration,
  }) {
    return ScrollAwareConfig(
      maxBlurMultiplier: maxBlurMultiplier ?? this.maxBlurMultiplier,
      velocityThreshold: velocityThreshold ?? this.velocityThreshold,
      blurTransitionDuration:
          blurTransitionDuration ?? this.blurTransitionDuration,
    );
  }
}
