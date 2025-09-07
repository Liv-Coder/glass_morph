import 'package:flutter/material.dart';

/// Enhanced color palette with minimalist design principles
/// Features subtle variations, gradients, and improved accessibility
class AppColors {
  // ===========================================================================
  // LIGHT THEME COLORS - Minimalist Neutral Palette
  // ===========================================================================

  // Primary - Soft Slate Gray
  static const lightPrimary = 0xFF64748B; // Slate 500
  static const lightPrimaryVariant = 0xFF475569; // Slate 600
  static const lightPrimaryLight = 0xFF94A3B8; // Slate 400

  // Secondary - Warm Gray
  static const lightSecondary = 0xFF78716C; // Stone 500
  static const lightSecondaryVariant = 0xFF57534E; // Stone 600
  static const lightSecondaryLight = 0xFFA8A29E; // Stone 400

  // Background & Surface - Pure Whites with subtle variations
  static const lightBackground = 0xFFFFFFFF;
  static const lightSurface = 0xFFFEFEFE;
  static const lightSurfaceVariant = 0xFFF8F9FA;
  static const lightCardBackground = 0xFFFCFCFC;

  // Semantic colors
  static const lightError = 0xFFDC2626; // Red 600
  static const lightSuccess = 0xFF059669; // Emerald 600
  static const lightWarning = 0xFFD97706; // Amber 600
  static const lightInfo = 0xFF2563EB; // Blue 600

  // On colors - High contrast text
  static const lightOnPrimary = 0xFFFFFFFF;
  static const lightOnSecondary = 0xFFFFFFFF;
  static const lightOnBackground = 0xFF0F172A; // Slate 900
  static const lightOnSurface = 0xFF1E293B; // Slate 800
  static const lightOnSurfaceVariant = 0xFF475569; // Slate 600
  static const lightOnError = 0xFFFFFFFF;
  static const lightOnSuccess = 0xFFFFFFFF;
  static const lightOnWarning = 0xFFFFFFFF;
  static const lightOnInfo = 0xFFFFFFFF;

  // Glass morphism specific
  static const lightGlassBackground = 0x80FFFFFF; // Semi-transparent white
  static const lightGlassBorder = 0x1A64748B; // Subtle primary border

  // ===========================================================================
  // DARK THEME COLORS - Deep Neutral Palette
  // ===========================================================================

  // Primary - Soft Slate Gray (lighter for dark theme)
  static const darkPrimary = 0xFF94A3B8; // Slate 400
  static const darkPrimaryVariant = 0xFF64748B; // Slate 500
  static const darkPrimaryLight = 0xFFCBD5E1; // Slate 300

  // Secondary - Warm Gray (lighter for dark theme)
  static const darkSecondary = 0xFFA8A29E; // Stone 400
  static const darkSecondaryVariant = 0xFF78716C; // Stone 500
  static const darkSecondaryLight = 0xFFD6D3D1; // Stone 300

  // Background & Surface - Deep grays with subtle variations
  static const darkBackground = 0xFF0F172A; // Slate 900
  static const darkSurface = 0xFF1E293B; // Slate 800
  static const darkSurfaceVariant = 0xFF334155; // Slate 700
  static const darkCardBackground = 0xFF1E293B; // Slate 800

  // Semantic colors (lighter for dark theme)
  static const darkError = 0xFFF87171; // Red 400
  static const darkSuccess = 0xFF34D399; // Emerald 400
  static const darkWarning = 0xFFFBBF24; // Amber 400
  static const darkInfo = 0xFF60A5FA; // Blue 400

  // On colors - Light text for dark backgrounds
  static const darkOnPrimary = 0xFF0F172A; // Slate 900
  static const darkOnSecondary = 0xFF0F172A; // Slate 900
  static const darkOnBackground = 0xFFF8FAFC; // Slate 50
  static const darkOnSurface = 0xFFE2E8F0; // Slate 200
  static const darkOnSurfaceVariant = 0xFFCBD5E1; // Slate 300
  static const darkOnError = 0xFF0F172A; // Slate 900
  static const darkOnSuccess = 0xFF0F172A; // Slate 900
  static const darkOnWarning = 0xFF0F172A; // Slate 900
  static const darkOnInfo = 0xFF0F172A; // Slate 900

  // Glass morphism specific
  static const darkGlassBackground = 0x801E293B; // Semi-transparent surface
  static const darkGlassBorder = 0x1A94A3B8; // Subtle primary border

  // ===========================================================================
  // GRADIENT DEFINITIONS
  // ===========================================================================

  // Light theme gradients
  static const LinearGradient lightPrimaryGradient = LinearGradient(
    colors: [
      Color(lightPrimaryLight),
      Color(lightPrimary),
      Color(lightPrimaryVariant),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient lightSurfaceGradient = LinearGradient(
    colors: [
      Color(lightSurface),
      Color(lightSurfaceVariant),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient lightGlassGradient = LinearGradient(
    colors: [
      Color(lightGlassBackground),
      Color(0x60FFFFFF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Dark theme gradients
  static const LinearGradient darkPrimaryGradient = LinearGradient(
    colors: [
      Color(darkPrimaryLight),
      Color(darkPrimary),
      Color(darkPrimaryVariant),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkSurfaceGradient = LinearGradient(
    colors: [
      Color(darkSurface),
      Color(darkSurfaceVariant),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient darkGlassGradient = LinearGradient(
    colors: [
      Color(darkGlassBackground),
      Color(0x601E293B),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ===========================================================================
  // UTILITY METHODS
  // ===========================================================================

  /// Get glass background color based on brightness
  static Color getGlassBackground(Brightness brightness) {
    return brightness == Brightness.light
        ? const Color(lightGlassBackground)
        : const Color(darkGlassBackground);
  }

  /// Get glass border color based on brightness
  static Color getGlassBorder(Brightness brightness) {
    return brightness == Brightness.light
        ? const Color(lightGlassBorder)
        : const Color(darkGlassBorder);
  }

  /// Get primary gradient based on brightness
  static LinearGradient getPrimaryGradient(Brightness brightness) {
    return brightness == Brightness.light
        ? lightPrimaryGradient
        : darkPrimaryGradient;
  }

  /// Get surface gradient based on brightness
  static LinearGradient getSurfaceGradient(Brightness brightness) {
    return brightness == Brightness.light
        ? lightSurfaceGradient
        : darkSurfaceGradient;
  }

  /// Get glass gradient based on brightness
  static LinearGradient getGlassGradient(Brightness brightness) {
    return brightness == Brightness.light
        ? lightGlassGradient
        : darkGlassGradient;
  }
}
