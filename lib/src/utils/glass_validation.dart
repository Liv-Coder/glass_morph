import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Validation utilities for glass morph widgets
class GlassValidation {
  /// Validates blur intensity values
  static void validateBlur(double blur) {
    if (blur < 0) {
      throw ArgumentError.value(
          blur, 'blur', 'Blur intensity cannot be negative');
    }
    if (blur > 100) {
      throw ArgumentError.value(blur, 'blur',
          'Blur intensity cannot exceed 100 (performance impact)');
    }
  }

  /// Validates opacity values
  static void validateOpacity(double opacity) {
    if (opacity < 0 || opacity > 1) {
      throw ArgumentError.value(
          opacity, 'opacity', 'Opacity must be between 0.0 and 1.0');
    }
  }

  /// Validates border radius values
  static void validateBorderRadius(double borderRadius) {
    if (borderRadius < 0) {
      throw ArgumentError.value(
          borderRadius, 'borderRadius', 'Border radius cannot be negative');
    }
  }

  /// Validates animation duration
  static void validateAnimationDuration(Duration duration) {
    if (duration.isNegative) {
      throw ArgumentError.value(duration, 'animationDuration',
          'Animation duration cannot be negative');
    }
    if (duration > const Duration(seconds: 10)) {
      throw ArgumentError.value(duration, 'animationDuration',
          'Animation duration cannot exceed 10 seconds');
    }
  }

  /// Validates color values
  static void validateColor(Color? color) {
    if (color != null && color.alpha == 0) {
      throw ArgumentError.value(
          color, 'color', 'Color cannot be fully transparent');
    }
  }

  /// Validates shadow configuration
  static void validateShadow(BoxShadow shadow) {
    if (shadow.blurRadius < 0) {
      throw ArgumentError.value(shadow.blurRadius, 'shadow.blurRadius',
          'Shadow blur radius cannot be negative');
    }
    if (shadow.spreadRadius < 0) {
      throw ArgumentError.value(shadow.spreadRadius, 'shadow.spreadRadius',
          'Shadow spread radius cannot be negative');
    }
  }

  /// Validates shadow list
  static void validateShadows(List<BoxShadow>? shadows) {
    if (shadows != null) {
      for (final shadow in shadows) {
        validateShadow(shadow);
      }
      if (shadows.length > 5) {
        throw ArgumentError.value(shadows.length, 'shadows',
            'Cannot have more than 5 shadows (performance impact)');
      }
    }
  }

  /// Validates gradient configuration
  static void validateGradient(Gradient? gradient) {
    if (gradient != null) {
      if (gradient.colors.isEmpty) {
        throw ArgumentError.value(
            gradient, 'gradient', 'Gradient must have at least one color');
      }
      if (gradient.colors.length != gradient.stops?.length) {
        throw ArgumentError.value(
            gradient, 'gradient', 'Gradient stops must match colors length');
      }
    }
  }

  /// Validates border configuration
  static void validateBorder(Border? border) {
    if (border != null) {
      if (border.top.width < 0 ||
          border.right.width < 0 ||
          border.bottom.width < 0 ||
          border.left.width < 0) {
        throw ArgumentError.value(
            border, 'border', 'Border widths cannot be negative');
      }
    }
  }

  /// Validates padding configuration
  static void validatePadding(EdgeInsets? padding) {
    if (padding != null) {
      if (padding.left < 0 ||
          padding.top < 0 ||
          padding.right < 0 ||
          padding.bottom < 0) {
        throw ArgumentError.value(
            padding, 'padding', 'Padding values cannot be negative');
      }
    }
  }

  /// Validates elevation values
  static void validateElevation(double elevation) {
    if (elevation < 0) {
      throw ArgumentError.value(
          elevation, 'elevation', 'Elevation cannot be negative');
    }
    if (elevation > 50) {
      throw ArgumentError.value(elevation, 'elevation',
          'Elevation cannot exceed 50 (performance impact)');
    }
  }

  /// Validates size constraints
  static void validateSize(BoxConstraints? constraints) {
    if (constraints != null) {
      if (constraints.minWidth < 0 || constraints.minHeight < 0) {
        throw ArgumentError.value(constraints, 'constraints',
            'Minimum size constraints cannot be negative');
      }
      if (constraints.maxWidth < constraints.minWidth ||
          constraints.maxHeight < constraints.minHeight) {
        throw ArgumentError.value(constraints, 'constraints',
            'Maximum size cannot be less than minimum size');
      }
    }
  }

  /// Comprehensive validation for glass morph widgets
  static void validateGlassMorphWidget({
    required double blur,
    required double opacity,
    required double borderRadius,
    Duration? animationDuration,
    Color? fillColor,
    List<BoxShadow>? shadows,
    Border? border,
    EdgeInsets? padding,
    double? elevation,
    BoxConstraints? constraints,
    Gradient? gradient,
  }) {
    validateBlur(blur);
    validateOpacity(opacity);
    validateBorderRadius(borderRadius);

    if (animationDuration != null) {
      validateAnimationDuration(animationDuration);
    }

    if (fillColor != null) {
      validateColor(fillColor);
    }

    validateShadows(shadows);
    validateBorder(border);

    if (padding != null) {
      validatePadding(padding);
    }

    if (elevation != null) {
      validateElevation(elevation);
    }

    if (constraints != null) {
      validateSize(constraints);
    }

    if (gradient != null) {
      validateGradient(gradient);
    }
  }

  /// Validates widget configuration at runtime
  static void validateAtRuntime({
    required BuildContext context,
    required double blur,
    required double opacity,
    required double borderRadius,
    Duration? animationDuration,
    Color? fillColor,
    List<BoxShadow>? shadows,
    Border? border,
    EdgeInsets? padding,
    double? elevation,
    BoxConstraints? constraints,
    Gradient? gradient,
  }) {
    try {
      validateGlassMorphWidget(
        blur: blur,
        opacity: opacity,
        borderRadius: borderRadius,
        animationDuration: animationDuration,
        fillColor: fillColor,
        shadows: shadows,
        border: border,
        padding: padding,
        elevation: elevation,
        constraints: constraints,
        gradient: gradient,
      );
    } catch (e) {
      // In debug mode, throw the error
      if (kDebugMode) {
        throw e;
      }
      // In release mode, log the error and continue with defaults
      debugPrint('GlassMorph validation error: $e');
    }
  }
}

/// Extension methods for validation
extension GlassValidationExtensions on num {
  /// Validates that this number is within a range
  void validateRange(String paramName, num min, num max) {
    if (this < min || this > max) {
      throw ArgumentError.value(
          this, paramName, 'Must be between $min and $max');
    }
  }

  /// Validates that this number is non-negative
  void validateNonNegative(String paramName) {
    if (this < 0) {
      throw ArgumentError.value(this, paramName, 'Cannot be negative');
    }
  }
}

/// Custom exceptions for glass morph widgets
class GlassMorphException implements Exception {
  final String message;
  final String? parameter;
  final dynamic value;

  GlassMorphException(this.message, {this.parameter, this.value});

  @override
  String toString() {
    if (parameter != null && value != null) {
      return 'GlassMorphException: $message (parameter: $parameter, value: $value)';
    } else if (parameter != null) {
      return 'GlassMorphException: $message (parameter: $parameter)';
    }
    return 'GlassMorphException: $message';
  }
}

/// Validation result class
class ValidationResult {
  final bool isValid;
  final List<String> errors;
  final List<String> warnings;

  ValidationResult({
    required this.isValid,
    this.errors = const [],
    this.warnings = const [],
  });

  factory ValidationResult.valid() => ValidationResult(isValid: true);

  factory ValidationResult.invalid(List<String> errors,
          {List<String> warnings = const []}) =>
      ValidationResult(isValid: false, errors: errors, warnings: warnings);

  void throwIfInvalid() {
    if (!isValid && errors.isNotEmpty) {
      throw GlassMorphException(errors.first);
    }
  }
}
