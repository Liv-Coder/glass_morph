import 'package:flutter/material.dart';

/// Utility class for enhanced accessibility features across glass morph widgets
class AccessibilityHelpers {
  /// Generates descriptive semantic labels based on widget type and content
  static String generateSemanticLabel({
    required String widgetType,
    String? customLabel,
    Widget? child,
    bool isInteractive = false,
    bool hasAnimation = false,
  }) {
    if (customLabel != null && customLabel.isNotEmpty) {
      return customLabel;
    }

    final baseLabel = _getBaseLabel(widgetType, child);
    final interactiveSuffix = isInteractive ? ' button' : '';
    final animationSuffix = hasAnimation ? ' with animation' : '';

    return '$baseLabel$interactiveSuffix$animationSuffix'.trim();
  }

  /// Generates helpful semantic hints for screen readers
  static String generateSemanticHint({
    required String widgetType,
    String? customHint,
    bool isInteractive = false,
    bool isDismissible = false,
    bool hasAnimation = false,
  }) {
    if (customHint != null && customHint.isNotEmpty) {
      return customHint;
    }

    final hints = <String>[];

    if (isInteractive) {
      hints.add('Double tap to activate');
    }

    if (isDismissible) {
      hints.add('Swipe down to dismiss');
    }

    if (hasAnimation) {
      hints.add('Animated glass effect');
    }

    // Add widget-specific hints
    switch (widgetType) {
      case 'GlassMorphButton':
        hints.add('Glass morphism button with blur effect');
        break;
      case 'GlassMorphCard':
        hints.add('Glass morphism card with translucent background');
        break;
      case 'GlassMorphFloatingActionButton':
        hints.add('Floating action button with glass morphism effect');
        break;
      case 'GlassMorphAppBar':
        hints.add('App bar with glass morphism background');
        break;
      case 'GlassMorphBottomSheet':
        hints.add('Bottom sheet with glass morphism effect');
        break;
      case 'GlassMorphDialog':
        hints.add('Dialog with glass morphism effect');
        break;
    }

    return hints.join('. ') + '.';
  }

  /// Determines if a widget should be focusable based on interaction capabilities
  static bool shouldBeFocusable({
    required bool isInteractive,
    required bool isEnabled,
    required bool isVisible,
  }) {
    return isInteractive && isEnabled && isVisible;
  }

  /// Gets focus order for widgets in a container
  static int getFocusOrder(String widgetType) {
    switch (widgetType) {
      case 'GlassMorphButton':
        return 1;
      case 'GlassMorphFloatingActionButton':
        return 2;
      case 'GlassMorphCard':
        return 3;
      case 'GlassMorphAppBar':
        return 4;
      case 'GlassMorphBottomSheet':
        return 5;
      case 'GlassMorphDialog':
        return 6;
      default:
        return 0;
    }
  }

  /// Generates accessibility announcements for state changes
  static String generateStateAnnouncement({
    required String widgetType,
    required String state,
    String? additionalInfo,
  }) {
    final announcement = '$widgetType $state';

    if (additionalInfo != null && additionalInfo.isNotEmpty) {
      return '$announcement: $additionalInfo';
    }

    return announcement;
  }

  /// Checks if high contrast mode optimizations should be applied
  static bool shouldApplyHighContrastOptimizations(BuildContext context) {
    final highContrast = MediaQuery.highContrastOf(context);
    final platformBrightness = MediaQuery.platformBrightnessOf(context);
    final themeBrightness = Theme.of(context).brightness;

    // Apply optimizations if system is in high contrast mode
    // or if there's a mismatch between platform and theme brightness
    return highContrast || platformBrightness != themeBrightness;
  }

  /// Gets optimized colors for high contrast mode
  static Color getHighContrastColor({
    required BuildContext context,
    required Color originalColor,
    bool isBackground = false,
  }) {
    if (!shouldApplyHighContrastOptimizations(context)) {
      return originalColor;
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (isBackground) {
      return isDark
          ? theme.colorScheme.surface.withValues(alpha: 0.9)
          : theme.colorScheme.surface.withValues(alpha: 0.95);
    } else {
      return theme.colorScheme.onSurface.withValues(alpha: 0.95);
    }
  }

  /// Gets optimized border for high contrast mode
  static Border? getHighContrastBorder({
    required BuildContext context,
    Border? originalBorder,
    double width = 2.0,
  }) {
    if (!shouldApplyHighContrastOptimizations(context)) {
      return originalBorder;
    }

    final theme = Theme.of(context);
    return Border.all(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
      width: width,
    );
  }

  static String _getBaseLabel(String widgetType, Widget? child) {
    // Try to extract text from child if it's a Text widget
    if (child is Text) {
      final text = child.data ?? '';
      if (text.isNotEmpty) {
        return text;
      }
    }

    // Fallback to widget type
    return widgetType.replaceAll('GlassMorph', '').toLowerCase();
  }
}

/// Extension methods for enhanced accessibility
extension AccessibilityExtensions on Widget {
  /// Wraps widget with enhanced accessibility features
  Widget withEnhancedAccessibility({
    required String widgetType,
    String? semanticLabel,
    String? semanticHint,
    bool isInteractive = false,
    bool hasAnimation = false,
    bool isEnabled = true,
    bool isVisible = true,
    VoidCallback? onAccessibilityTap,
  }) {
    final effectiveLabel = AccessibilityHelpers.generateSemanticLabel(
      widgetType: widgetType,
      customLabel: semanticLabel,
      child: this,
      isInteractive: isInteractive,
      hasAnimation: hasAnimation,
    );

    final effectiveHint = AccessibilityHelpers.generateSemanticHint(
      widgetType: widgetType,
      customHint: semanticHint,
      isInteractive: isInteractive,
      hasAnimation: hasAnimation,
    );

    final focusable = AccessibilityHelpers.shouldBeFocusable(
      isInteractive: isInteractive,
      isEnabled: isEnabled,
      isVisible: isVisible,
    );

    return Semantics(
      label: effectiveLabel,
      hint: effectiveHint,
      button: isInteractive,
      enabled: isEnabled,
      focusable: focusable,
      onTap: onAccessibilityTap,
      child: this,
    );
  }
}
