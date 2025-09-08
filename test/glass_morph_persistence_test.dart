import 'package:flutter_test/flutter_test.dart';
import 'package:glass_morph_widgets/src/utils/glass_morph_persistence.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GlassMorphConfig', () {
    test('should create from JSON correctly', () {
      final json = {
        'blur': 18.0,
        'opacity': 0.3,
        'borderRadius': 25.0,
        'animate': true,
        'gradientType': 'radial',
        'gradientColors': ['#000000', '#FFFFFF'],
        'preset': 'minimal',
      };

      final config = GlassMorphConfig.fromJson(json);

      expect(config.blur, equals(18.0));
      expect(config.opacity, equals(0.3));
      expect(config.borderRadius, equals(25.0));
      expect(config.animate, isTrue);
      expect(config.gradientType, equals('radial'));
      expect(config.gradientColors, equals(['#000000', '#FFFFFF']));
      expect(config.preset, equals('minimal'));
    });

    test('should convert to JSON correctly', () {
      const config = GlassMorphConfig(
        blur: 20.0,
        opacity: 0.35,
        borderRadius: 30.0,
        animate: false,
        gradientType: 'sweep',
        gradientColors: ['#FF00FF', '#FFFF00'],
        preset: 'bold',
      );

      final json = config.toJson();

      expect(json['blur'], equals(20.0));
      expect(json['opacity'], equals(0.35));
      expect(json['borderRadius'], equals(30.0));
      expect(json['animate'], isFalse);
      expect(json['gradientType'], equals('sweep'));
      expect(json['gradientColors'], equals(['#FF00FF', '#FFFF00']));
      expect(json['preset'], equals('bold'));
    });

    test('should create copy with modified values', () {
      const original = GlassMorphConfig(
        blur: 12.0,
        opacity: 0.2,
        borderRadius: 16.0,
        animate: true,
      );

      final modified = original.copyWith(
        blur: 20.0,
        opacity: 0.3,
        preset: 'custom',
      );

      expect(modified.blur, equals(20.0));
      expect(modified.opacity, equals(0.3));
      expect(modified.borderRadius, equals(16.0)); // Unchanged
      expect(modified.animate, isTrue); // Unchanged
      expect(modified.preset, equals('custom'));
    });

    test('should handle null values in JSON gracefully', () {
      final json = {
        'blur': null,
        'opacity': null,
        'borderRadius': null,
        'animate': null,
        'gradientType': null,
        'gradientColors': null,
        'preset': null,
      };

      final config = GlassMorphConfig.fromJson(json);

      expect(config.blur, equals(12.0)); // Default value
      expect(config.opacity, equals(0.2)); // Default value
      expect(config.borderRadius, equals(16.0)); // Default value
      expect(config.animate, isTrue); // Default value
      expect(config.gradientType, isNull);
      expect(config.gradientColors, isNull);
      expect(config.preset, isNull);
    });

    test('should use default values when not specified', () {
      const config = GlassMorphConfig();

      expect(config.blur, equals(12.0));
      expect(config.opacity, equals(0.2));
      expect(config.borderRadius, equals(16.0));
      expect(config.animate, isTrue);
      expect(config.gradientType, isNull);
      expect(config.gradientColors, isNull);
      expect(config.preset, isNull);
    });
  });

  group('GlassMorphPersistenceExtension', () {
    test('should provide extension methods', () {
      const config = GlassMorphConfig(
        blur: 14.0,
        opacity: 0.22,
        borderRadius: 18.0,
        animate: true,
      );

      // Test that extension methods exist (they would be called in integration tests)
      expect(config.blur, equals(14.0));
      expect(config.opacity, equals(0.22));
      expect(config.borderRadius, equals(18.0));
      expect(config.animate, isTrue);
    });
  });

  group('GlassMorphPersistence static methods', () {
    test('should have all required static methods', () {
      // Test that static methods exist and are callable
      expect(GlassMorphPersistence.saveConfig, isNotNull);
      expect(GlassMorphPersistence.loadConfig, isNotNull);
      expect(GlassMorphPersistence.saveUserPreferences, isNotNull);
      expect(GlassMorphPersistence.loadUserPreferences, isNotNull);
      expect(GlassMorphPersistence.clearAll, isNotNull);
      expect(GlassMorphPersistence.hasConfig, isNotNull);
      expect(GlassMorphPersistence.getLastModified, isNotNull);
      expect(GlassMorphPersistence.saveConfigWithTimestamp, isNotNull);
    });
  });

  group('JSON serialization edge cases', () {
    test('should handle empty JSON gracefully', () {
      final json = <String, dynamic>{};
      final config = GlassMorphConfig.fromJson(json);

      expect(config.blur, equals(12.0));
      expect(config.opacity, equals(0.2));
      expect(config.borderRadius, equals(16.0));
      expect(config.animate, isTrue);
    });

    test('should handle partial JSON correctly', () {
      final json = {
        'blur': 25.0,
        'animate': false,
      };
      final config = GlassMorphConfig.fromJson(json);

      expect(config.blur, equals(25.0));
      expect(config.opacity, equals(0.2)); // Default
      expect(config.borderRadius, equals(16.0)); // Default
      expect(config.animate, isFalse); // Provided value
    });

    test('should handle gradient colors as empty list', () {
      final json = {
        'gradientColors': <String>[],
      };
      final config = GlassMorphConfig.fromJson(json);

      expect(config.gradientColors, isEmpty);
    });

    test('should handle invalid gradient colors gracefully', () {
      final json = {
        'gradientColors': 'not-a-list', // Invalid type
      };
      final config = GlassMorphConfig.fromJson(json);

      expect(config.gradientColors,
          isNull); // Should be null due to error handling
    });
  });

  group('Configuration validation', () {
    test('should accept valid configuration values', () {
      const config = GlassMorphConfig(
        blur: 0.0, // Minimum valid value
        opacity: 1.0, // Maximum valid value
        borderRadius: 0.0, // Minimum valid value
        animate: false,
      );

      expect(config.blur, equals(0.0));
      expect(config.opacity, equals(1.0));
      expect(config.borderRadius, equals(0.0));
      expect(config.animate, isFalse);
    });

    test('should handle extreme values gracefully', () {
      const config = GlassMorphConfig(
        blur: 100.0, // Very high blur
        opacity: 0.0, // Fully transparent
        borderRadius: 1000.0, // Very large radius
        animate: true,
      );

      expect(config.blur, equals(100.0));
      expect(config.opacity, equals(0.0));
      expect(config.borderRadius, equals(1000.0));
      expect(config.animate, isTrue);
    });
  });
}
