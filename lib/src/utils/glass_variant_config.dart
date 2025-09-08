import 'package:flutter/material.dart';
import 'glass_border_config.dart';
import 'package:flutter/material.dart';

/// Configuration for different glass morph widget variants
enum GlassVariant {
  /// Standard glass morphism with blur and transparency
  glass,

  /// Outlined variant with border but no background fill
  outlined,

  /// Filled variant with solid background (no glass effect)
  filled,

  /// Ghost variant with minimal styling and subtle effects
  ghost,
}

/// Configuration class for glass morph widget variants
class GlassVariantConfig {
  /// The variant type
  final GlassVariant variant;

  /// Background color for filled variant
  final Color? fillColor;

  /// Border configuration for outlined variant
  final Border? border;

  /// Custom border configuration with shadows and styling
  final GlassBorderConfig? borderConfig;

  /// Opacity for ghost variant
  final double ghostOpacity;

  /// Blur intensity for ghost variant
  final double ghostBlur;

  const GlassVariantConfig({
    required this.variant,
    this.fillColor,
    this.border,
    this.borderConfig,
    this.ghostOpacity = 0.05,
    this.ghostBlur = 4.0,
  });

  /// Standard glass variant
  factory GlassVariantConfig.glass() => const GlassVariantConfig(
        variant: GlassVariant.glass,
      );

  /// Outlined variant with customizable border
  factory GlassVariantConfig.outlined({
    Border? border,
    Color borderColor = Colors.white24,
    double borderWidth = 1.0,
  }) =>
      GlassVariantConfig(
        variant: GlassVariant.outlined,
        border: border ??
            Border.all(
              color: borderColor,
              width: borderWidth,
            ),
      );

  /// Filled variant with solid background
  factory GlassVariantConfig.filled({
    required Color fillColor,
  }) =>
      GlassVariantConfig(
        variant: GlassVariant.filled,
        fillColor: fillColor,
      );

  /// Ghost variant with minimal effects
  factory GlassVariantConfig.ghost({
    double opacity = 0.05,
    double blur = 4.0,
  }) =>
      GlassVariantConfig(
        variant: GlassVariant.ghost,
        ghostOpacity: opacity,
        ghostBlur: blur,
      );

  /// Get the effective opacity based on variant
  double getEffectiveOpacity(double baseOpacity) {
    switch (variant) {
      case GlassVariant.glass:
        return baseOpacity;
      case GlassVariant.outlined:
        return 0.0; // No background for outlined
      case GlassVariant.filled:
        return 1.0; // Solid background for filled
      case GlassVariant.ghost:
        return ghostOpacity;
    }
  }

  /// Get the effective blur based on variant
  double getEffectiveBlur(double baseBlur) {
    switch (variant) {
      case GlassVariant.glass:
        return baseBlur;
      case GlassVariant.outlined:
        return 0.0; // No blur for outlined
      case GlassVariant.filled:
        return 0.0; // No blur for filled
      case GlassVariant.ghost:
        return ghostBlur;
    }
  }

  /// Check if this variant should use BackdropFilter
  bool get shouldUseBackdropFilter {
    switch (variant) {
      case GlassVariant.glass:
      case GlassVariant.ghost:
        return true;
      case GlassVariant.outlined:
      case GlassVariant.filled:
        return false;
    }
  }

  /// Get the background decoration for this variant
  BoxDecoration? getDecoration(Color? themeSurfaceColor) {
    switch (variant) {
      case GlassVariant.glass:
      case GlassVariant.ghost:
        return null; // Use BackdropFilter
      case GlassVariant.outlined:
        return BoxDecoration(
          border: border,
          borderRadius: BorderRadius.circular(16),
        );
      case GlassVariant.filled:
        return BoxDecoration(
          color: fillColor ?? themeSurfaceColor,
          borderRadius: BorderRadius.circular(16),
        );
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GlassVariantConfig &&
        other.variant == variant &&
        other.fillColor == fillColor &&
        other.border == border &&
        other.ghostOpacity == ghostOpacity &&
        other.ghostBlur == ghostBlur;
  }

  @override
  int get hashCode {
    return Object.hash(
      variant,
      fillColor,
      border,
      ghostOpacity,
      ghostBlur,
    );
  }

  @override
  String toString() {
    return 'GlassVariantConfig(variant: $variant, fillColor: $fillColor, border: $border, ghostOpacity: $ghostOpacity, ghostBlur: $ghostBlur)';
  }
}
