import 'package:flutter/material.dart';

/// GlassMorphPresets provides predefined style configurations for glass-morphism widgets.
/// These presets offer quick styling options for minimal, elegant, and bold appearances.
///
/// Usage:
/// ```dart
/// GlassMorphButton(
///   child: Text('Button'),
///   style: GlassMorphPresets.minimal,
/// )
/// ```
class GlassMorphPresets {
  /// Minimal style: subtle blur with low opacity for a clean, understated look
  static final GlassMorphStyle minimal = GlassMorphStyle(
    blur: 8.0,
    opacity: 0.12,
    borderRadius: 8.0,
    animationDuration: const Duration(milliseconds: 150),
    border: null,
    shadow: null,
  );

  /// Elegant style: balanced blur and opacity for sophisticated, refined appearance
  static final GlassMorphStyle elegant = GlassMorphStyle(
    blur: 12.0,
    opacity: 0.18,
    borderRadius: 16.0,
    animationDuration: const Duration(milliseconds: 200),
    border: Border.all(
      color: const Color(0x1FFFFFFF), // Semi-transparent white border
      width: 1.0,
    ),
    shadow: const [
      BoxShadow(
        color: Color(0x0F000000), // Subtle shadow
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  /// Bold style: strong blur and opacity for dramatic, eye-catching effect
  static final GlassMorphStyle bold = GlassMorphStyle(
    blur: 20.0,
    opacity: 0.25,
    borderRadius: 24.0,
    animationDuration: const Duration(milliseconds: 250),
    border: Border.all(
      color: const Color(0x2FFFFFFF), // More visible white border
      width: 1.5,
    ),
    shadow: const [
      BoxShadow(
        color: Color(0x1A000000), // Stronger shadow
        blurRadius: 12.0,
        offset: Offset(0, 4),
      ),
      BoxShadow(
        color: Color(0x0FFFFFFF), // Inner highlight
        blurRadius: 8.0,
        offset: Offset(0, -2),
      ),
    ],
  );

  /// Ultra minimal: almost invisible glass effect for subtle overlays
  static final GlassMorphStyle ultraMinimal = GlassMorphStyle(
    blur: 4.0,
    opacity: 0.08,
    borderRadius: 4.0,
    animationDuration: const Duration(milliseconds: 100),
    border: null,
    shadow: null,
  );

  /// Frosted: high blur for a frosted glass appearance
  static final GlassMorphStyle frosted = GlassMorphStyle(
    blur: 25.0,
    opacity: 0.15,
    borderRadius: 20.0,
    animationDuration: const Duration(milliseconds: 300),
    border: Border.all(
      color: const Color(0x15FFFFFF),
      width: 0.5,
    ),
    shadow: const [
      BoxShadow(
        color: Color(0x08000000),
        blurRadius: 4.0,
        offset: Offset(0, 1),
      ),
    ],
  );

  /// Crystal: very high blur with low opacity for crystal-clear effect
  static final GlassMorphStyle crystal = GlassMorphStyle(
    blur: 30.0,
    opacity: 0.10,
    borderRadius: 28.0,
    animationDuration: const Duration(milliseconds: 350),
    border: Border.all(
      color: const Color(0x20FFFFFF),
      width: 1.0,
    ),
    shadow: const [
      BoxShadow(
        color: Color(0x0A000000),
        blurRadius: 8.0,
        offset: Offset(0, 3),
      ),
      BoxShadow(
        color: Color(0x08FFFFFF),
        blurRadius: 6.0,
        offset: Offset(0, -1),
      ),
    ],
  );

  /// Get a preset by name
  static GlassMorphStyle? fromName(String name) {
    switch (name.toLowerCase()) {
      case 'minimal':
        return minimal;
      case 'elegant':
        return elegant;
      case 'bold':
        return bold;
      case 'ultraminimal':
      case 'ultra_minimal':
        return ultraMinimal;
      case 'frosted':
        return frosted;
      case 'crystal':
        return crystal;
      default:
        return null;
    }
  }

  /// Get all available preset names
  static List<String> get presetNames => [
        'minimal',
        'elegant',
        'bold',
        'ultraMinimal',
        'frosted',
        'crystal',
      ];
}

/// Configuration class for glass-morphism widget styling.
/// This class encapsulates all visual properties that can be customized.
class GlassMorphStyle {
  const GlassMorphStyle({
    required this.blur,
    required this.opacity,
    required this.borderRadius,
    required this.animationDuration,
    this.border,
    this.shadow,
  });

  /// The blur intensity for the glass effect (sigma value).
  final double blur;

  /// The background opacity for the glass effect.
  final double opacity;

  /// The border radius of the widget.
  final double borderRadius;

  /// The duration of animations.
  final Duration animationDuration;

  /// Optional border for the widget.
  final Border? border;

  /// Optional shadow for the widget.
  final List<BoxShadow>? shadow;

  /// Create a copy of this style with modified properties.
  GlassMorphStyle copyWith({
    double? blur,
    double? opacity,
    double? borderRadius,
    Duration? animationDuration,
    Border? border,
    List<BoxShadow>? shadow,
  }) {
    return GlassMorphStyle(
      blur: blur ?? this.blur,
      opacity: opacity ?? this.opacity,
      borderRadius: borderRadius ?? this.borderRadius,
      animationDuration: animationDuration ?? this.animationDuration,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GlassMorphStyle &&
        other.blur == blur &&
        other.opacity == opacity &&
        other.borderRadius == borderRadius &&
        other.animationDuration == animationDuration &&
        other.border == border &&
        _shadowsEqual(other.shadow, shadow);
  }

  @override
  int get hashCode {
    return Object.hash(
      blur,
      opacity,
      borderRadius,
      animationDuration,
      border,
      shadow,
    );
  }

  bool _shadowsEqual(List<BoxShadow>? a, List<BoxShadow>? b) {
    if (a == b) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  String toString() {
    return 'GlassMorphStyle(blur: $blur, opacity: $opacity, borderRadius: $borderRadius, animationDuration: $animationDuration, border: $border, shadow: $shadow)';
  }
}
