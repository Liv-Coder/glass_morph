import 'package:flutter/material.dart';

/// Configuration class for custom border styles in glass morphism widgets.
///
/// Provides flexible border customization with support for different border types,
/// colors, widths, and corner radii.
class GlassBorderConfig {
  /// Creates a custom border configuration.
  const GlassBorderConfig({
    this.border,
    this.borderRadius = 16.0,
    this.shadows,
  });

  /// The border to apply to the glass morphism widget.
  final Border? border;

  /// The border radius for rounded corners.
  final double borderRadius;

  /// Optional shadow effects to apply behind the widget.
  final List<BoxShadow>? shadows;

  /// Creates a copy of this configuration with optional overrides.
  GlassBorderConfig copyWith({
    Border? border,
    double? borderRadius,
    List<BoxShadow>? shadows,
  }) {
    return GlassBorderConfig(
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      shadows: shadows ?? this.shadows,
    );
  }

  /// Creates a minimal border configuration with subtle styling.
  factory GlassBorderConfig.minimal({
    Color? color,
    double width = 1.0,
    double borderRadius = 8.0,
  }) {
    return GlassBorderConfig(
      border: Border.all(
        color: color ?? Colors.white.withValues(alpha: 0.2),
        width: width,
      ),
      borderRadius: borderRadius,
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  /// Creates an elegant border configuration with refined styling.
  factory GlassBorderConfig.elegant({
    Color? color,
    double width = 1.5,
    double borderRadius = 16.0,
  }) {
    return GlassBorderConfig(
      border: Border.all(
        color: color ?? Colors.white.withValues(alpha: 0.3),
        width: width,
      ),
      borderRadius: borderRadius,
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.1),
          blurRadius: 4,
          offset: const Offset(0, -2),
        ),
      ],
    );
  }

  /// Creates a bold border configuration with prominent styling.
  factory GlassBorderConfig.bold({
    Color? color,
    double width = 2.0,
    double borderRadius = 24.0,
  }) {
    return GlassBorderConfig(
      border: Border.all(
        color: color ?? Colors.white.withValues(alpha: 0.4),
        width: width,
      ),
      borderRadius: borderRadius,
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.15),
          blurRadius: 8,
          offset: const Offset(0, -4),
        ),
      ],
    );
  }

  /// Creates a neon border configuration with glowing effects.
  factory GlassBorderConfig.neon({
    Color? color,
    double width = 2.0,
    double borderRadius = 20.0,
  }) {
    final glowColor = color ?? Colors.cyan.withValues(alpha: 0.8);
    return GlassBorderConfig(
      border: Border.all(
        color: glowColor,
        width: width,
      ),
      borderRadius: borderRadius,
      shadows: [
        BoxShadow(
          color: glowColor.withValues(alpha: 0.6),
          blurRadius: 16,
          spreadRadius: 2,
          offset: const Offset(0, 0),
        ),
        BoxShadow(
          color: glowColor.withValues(alpha: 0.4),
          blurRadius: 8,
          spreadRadius: 1,
          offset: const Offset(0, 0),
        ),
      ],
    );
  }

  /// Creates a gradient border configuration.
  factory GlassBorderConfig.gradient({
    required Gradient gradient,
    double width = 2.0,
    double borderRadius = 16.0,
  }) {
    return GlassBorderConfig(
      borderRadius: borderRadius,
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  /// Creates a configuration with no borders or shadows.
  factory GlassBorderConfig.none() {
    return const GlassBorderConfig(
      border: null,
      borderRadius: 0.0,
      shadows: null,
    );
  }

  /// Creates a rounded border configuration.
  factory GlassBorderConfig.rounded({
    Color? color,
    double width = 1.0,
    double borderRadius = 32.0,
  }) {
    return GlassBorderConfig(
      border: Border.all(
        color: color ?? Colors.white.withValues(alpha: 0.25),
        width: width,
      ),
      borderRadius: borderRadius,
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  /// Creates a sharp border configuration with minimal radius.
  factory GlassBorderConfig.sharp({
    Color? color,
    double width = 1.5,
    double borderRadius = 4.0,
  }) {
    return GlassBorderConfig(
      border: Border.all(
        color: color ?? Colors.white.withValues(alpha: 0.35),
        width: width,
      ),
      borderRadius: borderRadius,
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GlassBorderConfig &&
        other.border == border &&
        other.borderRadius == borderRadius &&
        other.shadows == shadows;
  }

  @override
  int get hashCode => Object.hash(border, borderRadius, shadows);

  @override
  String toString() {
    return 'GlassBorderConfig(border: $border, borderRadius: $borderRadius, shadows: $shadows)';
  }
}
