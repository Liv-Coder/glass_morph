import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Configuration class for glass morph widget persistence
class GlassMorphConfig {
  final double blur;
  final double opacity;
  final double borderRadius;
  final bool animate;
  final String? gradientType;
  final List<String>? gradientColors;
  final String? preset;

  const GlassMorphConfig({
    this.blur = 12.0,
    this.opacity = 0.2,
    this.borderRadius = 16.0,
    this.animate = true,
    this.gradientType,
    this.gradientColors,
    this.preset,
  });

  /// Create from JSON map
  factory GlassMorphConfig.fromJson(Map<String, dynamic> json) {
    return GlassMorphConfig(
      blur: json['blur'] ?? 12.0,
      opacity: json['opacity'] ?? 0.2,
      borderRadius: json['borderRadius'] ?? 16.0,
      animate: json['animate'] ?? true,
      gradientType: json['gradientType'],
      gradientColors:
          GlassMorphPersistence._parseGradientColors(json['gradientColors']),
      preset: json['preset'],
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'blur': blur,
      'opacity': opacity,
      'borderRadius': borderRadius,
      'animate': animate,
      'gradientType': gradientType,
      'gradientColors': gradientColors,
      'preset': preset,
    };
  }

  /// Create a copy with modified values
  GlassMorphConfig copyWith({
    double? blur,
    double? opacity,
    double? borderRadius,
    bool? animate,
    String? gradientType,
    List<String>? gradientColors,
    String? preset,
  }) {
    return GlassMorphConfig(
      blur: blur ?? this.blur,
      opacity: opacity ?? this.opacity,
      borderRadius: borderRadius ?? this.borderRadius,
      animate: animate ?? this.animate,
      gradientType: gradientType ?? this.gradientType,
      gradientColors: gradientColors ?? this.gradientColors,
      preset: preset ?? this.preset,
    );
  }
}

/// Utility class for persisting glass morph widget configurations
class GlassMorphPersistence {
  static const String _configKey = 'glass_morph_config';
  static const String _userPreferencesKey = 'glass_morph_user_prefs';

  /// Save configuration to persistent storage
  static Future<void> saveConfig(GlassMorphConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    final configJson = jsonEncode(config.toJson());
    await prefs.setString(_configKey, configJson);
  }

  /// Load configuration from persistent storage
  static Future<GlassMorphConfig?> loadConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final configJson = prefs.getString(_configKey);
    if (configJson != null) {
      try {
        final configMap = jsonDecode(configJson) as Map<String, dynamic>;
        return GlassMorphConfig.fromJson(configMap);
      } catch (e) {
        // Return null if parsing fails
        return null;
      }
    }
    return null;
  }

  /// Save user preferences (theme, accessibility settings, etc.)
  static Future<void> saveUserPreferences(
      Map<String, dynamic> preferences) async {
    final prefs = await SharedPreferences.getInstance();
    final prefsJson = jsonEncode(preferences);
    await prefs.setString(_userPreferencesKey, prefsJson);
  }

  /// Load user preferences
  static Future<Map<String, dynamic>?> loadUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final prefsJson = prefs.getString(_userPreferencesKey);
    if (prefsJson != null) {
      try {
        return jsonDecode(prefsJson) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Clear all saved configurations
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_configKey);
    await prefs.remove(_userPreferencesKey);
  }

  /// Helper function to safely parse gradient colors from JSON
  static List<String>? _parseGradientColors(dynamic value) {
    if (value == null) return null;

    try {
      if (value is List) {
        return value.map((e) => e.toString()).toList();
      } else if (value is String) {
        // Handle comma-separated string format
        final colors = value.split(',').map((e) => e.trim()).toList();
        // Validate that each color looks like a valid color format
        for (final color in colors) {
          if (!color.startsWith('#') || color.length != 7) {
            // Invalid color format, return null
            return null;
          }
        }
        return colors;
      } else {
        // Invalid format, return null
        return null;
      }
    } catch (e) {
      // Parsing failed, return null
      return null;
    }
  }

  /// Check if configuration exists
  static Future<bool> hasConfig() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_configKey);
  }

  /// Get last modified timestamp
  static Future<DateTime?> getLastModified() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt('${_configKey}_timestamp');
    if (timestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    return null;
  }

  /// Save with timestamp
  static Future<void> saveConfigWithTimestamp(GlassMorphConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    final configJson = jsonEncode(config.toJson());
    await prefs.setString(_configKey, configJson);
    await prefs.setInt(
        '${_configKey}_timestamp', DateTime.now().millisecondsSinceEpoch);
  }
}

/// Extension methods for easy integration with widgets
extension GlassMorphPersistenceExtension on GlassMorphConfig {
  /// Save this configuration
  Future<void> save() => GlassMorphPersistence.saveConfig(this);

  /// Save with timestamp
  Future<void> saveWithTimestamp() =>
      GlassMorphPersistence.saveConfigWithTimestamp(this);
}
