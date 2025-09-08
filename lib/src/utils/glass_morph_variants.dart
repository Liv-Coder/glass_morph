import 'package:flutter/material.dart';

/// Enum defining different visual variants for glass morph widgets
enum GlassMorphVariant {
  /// Default filled variant with standard glass-morphism effects
  filled,

  /// Outlined variant with border and reduced opacity
  outlined,

  /// Ghost variant with minimal opacity and subtle effects
  ghost,
}

/// Configuration class for glass morph widget variants
class GlassMorphVariantConfig {
  final double opacity;
  final double blur;
  final Border? border;
  final List<BoxShadow>? shadows;

  const GlassMorphVariantConfig({
    required this.opacity,
    required this.blur,
    this.border,
    this.shadows,
  });

  /// Get configuration for a specific variant
  static GlassMorphVariantConfig getConfig(GlassMorphVariant variant) {
    switch (variant) {
      case GlassMorphVariant.filled:
        return const GlassMorphVariantConfig(
          opacity: 0.2,
          blur: 12.0,
          shadows: [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        );

      case GlassMorphVariant.outlined:
        return GlassMorphVariantConfig(
          opacity: 0.1,
          blur: 8.0,
          border: Border.all(
            color: const Color(0x33FFFFFF),
            width: 1.0,
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        );

      case GlassMorphVariant.ghost:
        return const GlassMorphVariantConfig(
          opacity: 0.05,
          blur: 6.0,
          shadows: [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        );
    }
  }

  /// Create a copy with modified values
  GlassMorphVariantConfig copyWith({
    double? opacity,
    double? blur,
    Border? border,
    List<BoxShadow>? shadows,
  }) {
    return GlassMorphVariantConfig(
      opacity: opacity ?? this.opacity,
      blur: blur ?? this.blur,
      border: border ?? this.border,
      shadows: shadows ?? this.shadows,
    );
  }
}
