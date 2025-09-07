import 'package:example/theme/app_colors.dart';
import 'package:example/theme/app_dimensions.dart';
import 'package:example/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Enhanced theme system with gradient support, smooth transitions, and modern design
class AppTheme {
  static const colors = AppColors;
  static const textStyles = AppTextStyles;
  static const dimensions = AppDimensions;

  // ===========================================================================
  // LIGHT THEME
  // ===========================================================================

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Enhanced color scheme with new palette
      colorScheme: ColorScheme.light(
        primary: Color(AppColors.lightPrimary),
        primaryContainer: Color(AppColors.lightPrimaryLight),
        secondary: Color(AppColors.lightSecondary),
        secondaryContainer: Color(AppColors.lightSecondaryLight),
        tertiary: Color(AppColors.lightInfo),
        surface: Color(AppColors.lightSurface),
        surfaceContainerHighest: Color(AppColors.lightSurfaceVariant),
        error: Color(AppColors.lightError),
        errorContainer: Color(AppColors.lightError).withValues(alpha: 0.1),
        onPrimary: Color(AppColors.lightOnPrimary),
        onSecondary: Color(AppColors.lightOnSecondary),
        onSurface: Color(AppColors.lightOnSurface),
        onSurfaceVariant: Color(AppColors.lightOnSurfaceVariant),
        onError: Color(AppColors.lightOnError),
        onErrorContainer: Color(AppColors.lightOnError),
        outline: Color(AppColors.lightOnSurfaceVariant).withValues(alpha: 0.5),
        outlineVariant:
            Color(AppColors.lightOnSurfaceVariant).withValues(alpha: 0.25),
        shadow: Colors.black.withValues(alpha: 0.1),
        scrim: Colors.black.withValues(alpha: 0.5),
        inverseSurface: Color(AppColors.darkSurface),
        onInverseSurface: Color(AppColors.darkOnSurface),
        inversePrimary: Color(AppColors.darkPrimary),
        surfaceTint: Color(AppColors.lightPrimary).withValues(alpha: 0.1),
      ),

      // Enhanced app bar with gradient support
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(AppColors.lightOnSurface),
        elevation: 0,
        centerTitle: true,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Color(AppColors.lightOnSurface),
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
      ),

      // Enhanced card theme with glass morphism support
      cardTheme: CardThemeData(
        color: Color(AppColors.lightCardBackground),
        shadowColor: Colors.black.withValues(alpha: 0.1),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.zero,
      ),

      // Enhanced button themes with smooth transitions
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(AppColors.lightPrimary),
          foregroundColor: Color(AppColors.lightOnPrimary),
          elevation: 2,
          shadowColor: Color(AppColors.lightPrimary).withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return Color(AppColors.lightOnPrimary).withValues(alpha: 0.1);
              }
              if (states.contains(WidgetState.hovered)) {
                return Color(AppColors.lightOnPrimary).withValues(alpha: 0.05);
              }
              return null;
            },
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Color(AppColors.lightPrimary),
          side: BorderSide(color: Color(AppColors.lightPrimary), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Color(AppColors.lightPrimary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.25,
          ),
        ),
      ),

      // Enhanced typography with better hierarchy
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: Color(AppColors.lightOnBackground),
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          height: 1.12,
        ),
        displayMedium: TextStyle(
          color: Color(AppColors.lightOnBackground),
          fontSize: 45,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.16,
        ),
        displaySmall: TextStyle(
          color: Color(AppColors.lightOnBackground),
          fontSize: 36,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.22,
        ),
        headlineLarge: TextStyle(
          color: Color(AppColors.lightOnBackground),
          fontSize: 32,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.25,
        ),
        headlineMedium: TextStyle(
          color: Color(AppColors.lightOnBackground),
          fontSize: 28,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.29,
        ),
        headlineSmall: TextStyle(
          color: Color(AppColors.lightOnBackground),
          fontSize: 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.33,
        ),
        titleLarge: TextStyle(
          color: Color(AppColors.lightOnBackground),
          fontSize: 22,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          height: 1.27,
        ),
        titleMedium: TextStyle(
          color: Color(AppColors.lightOnSurface),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.5,
        ),
        titleSmall: TextStyle(
          color: Color(AppColors.lightOnSurface),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        bodyLarge: TextStyle(
          color: Color(AppColors.lightOnSurface),
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          color: Color(AppColors.lightOnSurface),
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
        ),
        bodySmall: TextStyle(
          color: Color(AppColors.lightOnSurface),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.33,
        ),
        labelLarge: TextStyle(
          color: Color(AppColors.lightOnSurface),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        labelMedium: TextStyle(
          color: Color(AppColors.lightOnSurface),
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.33,
        ),
        labelSmall: TextStyle(
          color: Color(AppColors.lightOnSurface),
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.45,
        ),
      ),

      // Enhanced input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(AppColors.lightSurfaceVariant),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: Color(AppColors.lightOnSurfaceVariant)
                  .withValues(alpha: 0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: Color(AppColors.lightOnSurfaceVariant)
                  .withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: Color(AppColors.lightPrimary), width: 2),
        ),
        labelStyle: TextStyle(
          color: Color(AppColors.lightOnSurfaceVariant),
          fontSize: 16,
        ),
        hintStyle: TextStyle(
          color: Color(AppColors.lightOnSurfaceVariant).withValues(alpha: 0.7),
          fontSize: 16,
        ),
      ),

      // Smooth page transitions
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  // ===========================================================================
  // DARK THEME
  // ===========================================================================

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Enhanced color scheme with new palette
      colorScheme: ColorScheme.dark(
        primary: Color(AppColors.darkPrimary),
        primaryContainer: Color(AppColors.darkPrimaryLight),
        secondary: Color(AppColors.darkSecondary),
        secondaryContainer: Color(AppColors.darkSecondaryLight),
        tertiary: Color(AppColors.darkInfo),
        surface: Color(AppColors.darkSurface),
        surfaceContainerHighest: Color(AppColors.darkSurfaceVariant),
        error: Color(AppColors.darkError),
        errorContainer: Color(AppColors.darkError).withValues(alpha: 0.1),
        onPrimary: Color(AppColors.darkOnPrimary),
        onSecondary: Color(AppColors.darkOnSecondary),
        onSurface: Color(AppColors.darkOnSurface),
        onSurfaceVariant: Color(AppColors.darkOnSurfaceVariant),
        onError: Color(AppColors.darkOnError),
        onErrorContainer: Color(AppColors.darkOnError),
        outline: Color(AppColors.darkOnSurfaceVariant).withValues(alpha: 0.5),
        outlineVariant:
            Color(AppColors.darkOnSurfaceVariant).withValues(alpha: 0.25),
        shadow: Colors.black.withValues(alpha: 0.3),
        scrim: Colors.black.withValues(alpha: 0.6),
        inverseSurface: Color(AppColors.lightSurface),
        onInverseSurface: Color(AppColors.lightOnSurface),
        inversePrimary: Color(AppColors.lightPrimary),
        surfaceTint: Color(AppColors.darkPrimary).withValues(alpha: 0.1),
      ),

      // Enhanced app bar with gradient support
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(AppColors.darkOnSurface),
        elevation: 0,
        centerTitle: true,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Color(AppColors.darkOnSurface),
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
      ),

      // Enhanced card theme with glass morphism support
      cardTheme: CardThemeData(
        color: Color(AppColors.darkCardBackground),
        shadowColor: Colors.black.withValues(alpha: 0.3),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.zero,
      ),

      // Enhanced button themes with smooth transitions
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(AppColors.darkPrimary),
          foregroundColor: Color(AppColors.darkOnPrimary),
          elevation: 2,
          shadowColor: Color(AppColors.darkPrimary).withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return Color(AppColors.darkOnPrimary).withValues(alpha: 0.1);
              }
              if (states.contains(WidgetState.hovered)) {
                return Color(AppColors.darkOnPrimary).withValues(alpha: 0.05);
              }
              return null;
            },
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Color(AppColors.darkPrimary),
          side: BorderSide(color: Color(AppColors.darkPrimary), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Color(AppColors.darkPrimary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.25,
          ),
        ),
      ),

      // Enhanced typography with better hierarchy
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: Color(AppColors.darkOnBackground),
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          height: 1.12,
        ),
        displayMedium: TextStyle(
          color: Color(AppColors.darkOnBackground),
          fontSize: 45,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.16,
        ),
        displaySmall: TextStyle(
          color: Color(AppColors.darkOnBackground),
          fontSize: 36,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.22,
        ),
        headlineLarge: TextStyle(
          color: Color(AppColors.darkOnBackground),
          fontSize: 32,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.25,
        ),
        headlineMedium: TextStyle(
          color: Color(AppColors.darkOnBackground),
          fontSize: 28,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.29,
        ),
        headlineSmall: TextStyle(
          color: Color(AppColors.darkOnBackground),
          fontSize: 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.33,
        ),
        titleLarge: TextStyle(
          color: Color(AppColors.darkOnBackground),
          fontSize: 22,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          height: 1.27,
        ),
        titleMedium: TextStyle(
          color: Color(AppColors.darkOnSurface),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.5,
        ),
        titleSmall: TextStyle(
          color: Color(AppColors.darkOnSurface),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        bodyLarge: TextStyle(
          color: Color(AppColors.darkOnSurface),
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          color: Color(AppColors.darkOnSurface),
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
        ),
        bodySmall: TextStyle(
          color: Color(AppColors.darkOnSurface),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.33,
        ),
        labelLarge: TextStyle(
          color: Color(AppColors.darkOnSurface),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        labelMedium: TextStyle(
          color: Color(AppColors.darkOnSurface),
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.33,
        ),
        labelSmall: TextStyle(
          color: Color(AppColors.darkOnSurface),
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.45,
        ),
      ),

      // Enhanced input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(AppColors.darkSurfaceVariant),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color:
                  Color(AppColors.darkOnSurfaceVariant).withValues(alpha: 0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color:
                  Color(AppColors.darkOnSurfaceVariant).withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(AppColors.darkPrimary), width: 2),
        ),
        labelStyle: TextStyle(
          color: Color(AppColors.darkOnSurfaceVariant),
          fontSize: 16,
        ),
        hintStyle: TextStyle(
          color: Color(AppColors.darkOnSurfaceVariant).withValues(alpha: 0.7),
          fontSize: 16,
        ),
      ),

      // Smooth page transitions
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  // ===========================================================================
  // UTILITY METHODS
  // ===========================================================================

  /// Get theme data based on brightness
  static ThemeData getTheme(Brightness brightness) {
    return brightness == Brightness.light ? lightTheme : darkTheme;
  }

  /// Get gradient based on brightness
  static LinearGradient getGradient(Brightness brightness) {
    return AppColors.getPrimaryGradient(brightness);
  }

  /// Get glass background color based on brightness
  static Color getGlassBackground(Brightness brightness) {
    return AppColors.getGlassBackground(brightness);
  }

  /// Get glass border color based on brightness
  static Color getGlassBorder(Brightness brightness) {
    return AppColors.getGlassBorder(brightness);
  }

  /// Create a smooth theme transition animation
  static AnimatedTheme createAnimatedTheme({
    required Widget child,
    required ThemeData theme,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return AnimatedTheme(
      data: theme,
      duration: duration,
      curve: curve,
      child: child,
    );
  }

  AppTheme._();
}
