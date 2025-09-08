import 'package:flutter/material.dart';

/// Configuration class for gradient backgrounds in glass-morphism widgets
class GlassGradientConfig {
  /// The gradient to use as background
  final Gradient? gradient;

  /// Opacity to apply to the gradient (0.0 to 1.0)
  final double opacity;

  /// Whether to use the gradient or fallback to solid color
  final bool enabled;

  const GlassGradientConfig({
    this.gradient,
    this.opacity = 0.2,
    this.enabled = false,
  });

  /// Creates a linear gradient configuration
  factory GlassGradientConfig.linear({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    double opacity = 0.2,
    TileMode tileMode = TileMode.clamp,
  }) {
    return GlassGradientConfig(
      gradient: LinearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
      opacity: opacity,
      enabled: true,
    );
  }

  /// Creates a radial gradient configuration
  factory GlassGradientConfig.radial({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry center = Alignment.center,
    double radius = 0.5,
    AlignmentGeometry? focal,
    double focalRadius = 0.0,
    double opacity = 0.2,
    TileMode tileMode = TileMode.clamp,
  }) {
    return GlassGradientConfig(
      gradient: RadialGradient(
        colors: colors,
        stops: stops,
        center: center,
        radius: radius,
        focal: focal,
        focalRadius: focalRadius,
        tileMode: tileMode,
      ),
      opacity: opacity,
      enabled: true,
    );
  }

  /// Creates a sweep gradient configuration
  factory GlassGradientConfig.sweep({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry center = Alignment.center,
    double startAngle = 0.0,
    double endAngle = 3.14159 * 2,
    double opacity = 0.2,
    TileMode tileMode = TileMode.clamp,
  }) {
    return GlassGradientConfig(
      gradient: SweepGradient(
        colors: colors,
        stops: stops,
        center: center,
        startAngle: startAngle,
        endAngle: endAngle,
        tileMode: tileMode,
      ),
      opacity: opacity,
      enabled: true,
    );
  }

  /// Creates a disabled gradient configuration (solid color fallback)
  const GlassGradientConfig.disabled({
    double opacity = 0.2,
  }) : this(
          gradient: null,
          opacity: opacity,
          enabled: false,
        );

  /// Predefined gradient presets
  static const GlassGradientConfig none = GlassGradientConfig.disabled();

  static GlassGradientConfig ocean = GlassGradientConfig.linear(
    colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6), Color(0xFF06B6D4)],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static GlassGradientConfig sunset = GlassGradientConfig.linear(
    colors: [Color(0xFFFF6B35), Color(0xFFF7931E), Color(0xFFFFD23F)],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static GlassGradientConfig forest = GlassGradientConfig.radial(
    colors: [Color(0xFF059669), Color(0xFF10B981), Color(0xFF34D399)],
    center: Alignment.center,
    radius: 0.8,
  );

  static GlassGradientConfig cosmic = GlassGradientConfig.sweep(
    colors: [Color(0xFF7C3AED), Color(0xFFEC4899), Color(0xFFF59E0B)],
    center: Alignment.center,
    startAngle: 0.0,
    endAngle: 3.14159 * 2,
  );

  /// Returns the gradient with opacity applied, or null if disabled
  Gradient? toGradient() {
    if (!enabled || gradient == null) return null;

    // Apply opacity to the gradient colors
    if (gradient is LinearGradient) {
      final linear = gradient as LinearGradient;
      return LinearGradient(
        colors: linear.colors
            .map((color) => color.withValues(alpha: opacity))
            .toList(),
        stops: linear.stops,
        begin: linear.begin,
        end: linear.end,
        tileMode: linear.tileMode,
      );
    } else if (gradient is RadialGradient) {
      final radial = gradient as RadialGradient;
      return RadialGradient(
        colors: radial.colors
            .map((color) => color.withValues(alpha: opacity))
            .toList(),
        stops: radial.stops,
        center: radial.center,
        radius: radial.radius,
        focal: radial.focal,
        focalRadius: radial.focalRadius,
        tileMode: radial.tileMode,
      );
    } else if (gradient is SweepGradient) {
      final sweep = gradient as SweepGradient;
      return SweepGradient(
        colors: sweep.colors
            .map((color) => color.withValues(alpha: opacity))
            .toList(),
        stops: sweep.stops,
        center: sweep.center,
        startAngle: sweep.startAngle,
        endAngle: sweep.endAngle,
        tileMode: sweep.tileMode,
      );
    }

    return gradient;
  }

  /// Creates a copy with modified properties
  GlassGradientConfig copyWith({
    Gradient? gradient,
    double? opacity,
    bool? enabled,
  }) {
    return GlassGradientConfig(
      gradient: gradient ?? this.gradient,
      opacity: opacity ?? this.opacity,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GlassGradientConfig &&
        other.gradient == gradient &&
        other.opacity == opacity &&
        other.enabled == enabled;
  }

  @override
  int get hashCode => Object.hash(gradient, opacity, enabled);

  @override
  String toString() {
    return 'GlassGradientConfig(gradient: $gradient, opacity: $opacity, enabled: $enabled)';
  }
}
