import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Configuration class for advanced glass morphism animations
class GlassAnimationConfig {
  /// Default animation configuration
  static const GlassAnimationConfig defaultConfig = GlassAnimationConfig();

  /// Spring animation configuration for natural bouncy effects
  static const GlassAnimationConfig springConfig = GlassAnimationConfig(
    curve: Curves.elasticOut,
    useSpring: true,
    springDamping: 15.0,
    springStiffness: 100.0,
  );

  /// Smooth animation configuration
  static const GlassAnimationConfig smoothConfig = GlassAnimationConfig(
    curve: Curves.easeOutCubic,
    duration: Duration(milliseconds: 300),
  );

  /// Fast animation configuration
  static const GlassAnimationConfig fastConfig = GlassAnimationConfig(
    curve: Curves.easeOut,
    duration: Duration(milliseconds: 150),
  );

  const GlassAnimationConfig({
    this.curve = Curves.easeOut,
    this.duration = const Duration(milliseconds: 200),
    this.useSpring = false,
    this.springDamping = 20.0,
    this.springStiffness = 180.0,
    this.scaleFactor = 0.92,
    this.blurReductionFactor = 0.6,
  });

  /// Animation curve for smooth transitions
  final Curve curve;

  /// Duration of the animation
  final Duration duration;

  /// Whether to use spring physics for more natural animations
  final bool useSpring;

  /// Spring damping coefficient (higher = less bouncy)
  final double springDamping;

  /// Spring stiffness coefficient (higher = faster return)
  final double springStiffness;

  /// Scale factor when pressed (0.0 to 1.0)
  final double scaleFactor;

  /// Blur reduction factor when pressed (0.0 to 1.0)
  final double blurReductionFactor;

  /// Creates a spring simulation for natural animations
  SpringSimulation createSpringSimulation(double start, double end) {
    return SpringSimulation(
      SpringDescription(
        mass: 1.0,
        stiffness: springStiffness,
        damping: springDamping,
      ),
      start,
      end,
      0.0,
    );
  }

  /// Creates a copy with modified properties
  GlassAnimationConfig copyWith({
    Curve? curve,
    Duration? duration,
    bool? useSpring,
    double? springDamping,
    double? springStiffness,
    double? scaleFactor,
    double? blurReductionFactor,
  }) {
    return GlassAnimationConfig(
      curve: curve ?? this.curve,
      duration: duration ?? this.duration,
      useSpring: useSpring ?? this.useSpring,
      springDamping: springDamping ?? this.springDamping,
      springStiffness: springStiffness ?? this.springStiffness,
      scaleFactor: scaleFactor ?? this.scaleFactor,
      blurReductionFactor: blurReductionFactor ?? this.blurReductionFactor,
    );
  }
}

/// Predefined animation presets for common use cases
class GlassAnimationPresets {
  /// Default preset - balanced performance and feel
  static const GlassAnimationConfig defaultPreset =
      GlassAnimationConfig.defaultConfig;

  /// Spring preset - bouncy, natural feel
  static const GlassAnimationConfig spring = GlassAnimationConfig.springConfig;

  /// Smooth preset - fluid, elegant transitions
  static const GlassAnimationConfig smooth = GlassAnimationConfig.smoothConfig;

  /// Fast preset - quick, responsive feedback
  static const GlassAnimationConfig fast = GlassAnimationConfig.fastConfig;

  /// Material Design compliant preset
  static const GlassAnimationConfig material = GlassAnimationConfig(
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 200),
  );

  /// iOS-style preset with spring physics
  static const GlassAnimationConfig ios = GlassAnimationConfig(
    useSpring: true,
    springDamping: 25.0,
    springStiffness: 200.0,
    scaleFactor: 0.95,
  );
}
