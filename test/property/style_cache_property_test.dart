/// Property-based tests for StyleCache consistency
///
/// **Property 5: Style Cache Consistency**
/// **Validates: Requirements 3.5, 4.5**
///
/// For any style resolution with identical parameters (theme, type, size, custom style),
/// repeated calls SHALL return the same cached object instance (object identity equality).
library style_cache_property_test;

import 'package:flutter/material.dart';
import 'package:glados/glados.dart';
import 'package:velocity_ui/src/core/theme/velocity_theme_data.dart';
import 'package:velocity_ui/src/core/theme/style_cache.dart';

void main() {
  group('Property 5: Style Cache Consistency', () {
    // Feature: velocity-ui-optimization, Property 5: Style Cache Consistency
    // Validates: Requirements 3.5, 4.5

    setUp(() {
      // Clear cache before each test to ensure clean state
      StyleCache.instance.clearCache();
    });

    Glados2(any.velocityButtonType, any.velocityButtonSize).test(
      'button style cache returns same instance for identical parameters',
      (VelocityButtonType type, VelocityButtonSize size) {
        final theme = VelocityThemeData.light();

        final style1 = StyleCache.instance.resolveButtonStyle(
          theme: theme,
          type: type,
          size: size,
        );
        final style2 = StyleCache.instance.resolveButtonStyle(
          theme: theme,
          type: type,
          size: size,
        );

        // Object identity check - same cached instance
        expect(identical(style1, style2), isTrue);
      },
    );

    Glados(any.velocityInputSize).test(
      'input style cache returns same instance for identical parameters',
      (VelocityInputSize size) {
        final theme = VelocityThemeData.light();

        final style1 = StyleCache.instance.resolveInputStyle(
          theme: theme,
          size: size,
        );
        final style2 = StyleCache.instance.resolveInputStyle(
          theme: theme,
          size: size,
        );

        // Object identity check - same cached instance
        expect(identical(style1, style2), isTrue);
      },
    );

    Glados(any.velocityCardSize).test(
      'card style cache returns same instance for identical parameters',
      (VelocityCardSize size) {
        final theme = VelocityThemeData.light();

        final style1 = StyleCache.instance.resolveCardStyle(
          theme: theme,
          size: size,
        );
        final style2 = StyleCache.instance.resolveCardStyle(
          theme: theme,
          size: size,
        );

        // Object identity check - same cached instance
        expect(identical(style1, style2), isTrue);
      },
    );

    Glados2(any.velocityButtonType, any.velocityButtonSize).test(
      'different button parameters produce different cache entries',
      (VelocityButtonType type1, VelocityButtonSize size1) {
        final theme = VelocityThemeData.light();

        // Get all other types and sizes
        final otherTypes = VelocityButtonType.values.where((t) => t != type1);
        final otherSizes = VelocityButtonSize.values.where((s) => s != size1);

        final style1 = StyleCache.instance.resolveButtonStyle(
          theme: theme,
          type: type1,
          size: size1,
        );

        // Different type should produce different instance
        for (final type2 in otherTypes) {
          final style2 = StyleCache.instance.resolveButtonStyle(
            theme: theme,
            type: type2,
            size: size1,
          );
          expect(identical(style1, style2), isFalse);
        }

        // Different size should produce different instance
        for (final size2 in otherSizes) {
          final style3 = StyleCache.instance.resolveButtonStyle(
            theme: theme,
            type: type1,
            size: size2,
          );
          expect(identical(style1, style3), isFalse);
        }
      },
    );

    Glados2(any.velocityButtonType, any.velocityButtonSize).test(
      'different themes produce different cache entries',
      (VelocityButtonType type, VelocityButtonSize size) {
        final lightTheme = VelocityThemeData.light();
        final darkTheme = VelocityThemeData.dark();

        final lightStyle = StyleCache.instance.resolveButtonStyle(
          theme: lightTheme,
          type: type,
          size: size,
        );
        final darkStyle = StyleCache.instance.resolveButtonStyle(
          theme: darkTheme,
          type: type,
          size: size,
        );

        // Different themes should produce different instances
        expect(identical(lightStyle, darkStyle), isFalse);
      },
    );

    test('clearCache removes all cached styles', () {
      final theme = VelocityThemeData.light();

      // Populate cache
      StyleCache.instance.resolveButtonStyle(
        theme: theme,
        type: VelocityButtonType.primary,
        size: VelocityButtonSize.medium,
      );
      StyleCache.instance.resolveInputStyle(
        theme: theme,
        size: VelocityInputSize.medium,
      );
      StyleCache.instance.resolveCardStyle(
        theme: theme,
        size: VelocityCardSize.medium,
      );

      expect(StyleCache.instance.buttonCacheSize, greaterThan(0));
      expect(StyleCache.instance.inputCacheSize, greaterThan(0));
      expect(StyleCache.instance.cardCacheSize, greaterThan(0));

      // Clear cache
      StyleCache.instance.clearCache();

      expect(StyleCache.instance.buttonCacheSize, equals(0));
      expect(StyleCache.instance.inputCacheSize, equals(0));
      expect(StyleCache.instance.cardCacheSize, equals(0));
    });

    test('clearButtonCache only clears button styles', () {
      final theme = VelocityThemeData.light();

      // Populate cache
      StyleCache.instance.resolveButtonStyle(
        theme: theme,
        type: VelocityButtonType.primary,
        size: VelocityButtonSize.medium,
      );
      StyleCache.instance.resolveInputStyle(
        theme: theme,
        size: VelocityInputSize.medium,
      );

      // Clear only button cache
      StyleCache.instance.clearButtonCache();

      expect(StyleCache.instance.buttonCacheSize, equals(0));
      expect(StyleCache.instance.inputCacheSize, greaterThan(0));
    });

    Glados2(any.velocityButtonType, any.velocityButtonSize).test(
      'custom style affects cache key',
      (VelocityButtonType type, VelocityButtonSize size) {
        final theme = VelocityThemeData.light();
        final customStyle = const VelocityButtonThemeData(
          backgroundColor: Colors.purple,
        );

        final styleWithoutCustom = StyleCache.instance.resolveButtonStyle(
          theme: theme,
          type: type,
          size: size,
        );
        final styleWithCustom = StyleCache.instance.resolveButtonStyle(
          theme: theme,
          type: type,
          size: size,
          customStyle: customStyle,
        );

        // Custom style should produce different instance
        expect(identical(styleWithoutCustom, styleWithCustom), isFalse);
      },
    );

    Glados2(any.velocityButtonType, any.velocityButtonSize).test(
      'same custom style produces same cached instance',
      (VelocityButtonType type, VelocityButtonSize size) {
        final theme = VelocityThemeData.light();
        final customStyle = const VelocityButtonThemeData(
          backgroundColor: Colors.purple,
        );

        final style1 = StyleCache.instance.resolveButtonStyle(
          theme: theme,
          type: type,
          size: size,
          customStyle: customStyle,
        );
        final style2 = StyleCache.instance.resolveButtonStyle(
          theme: theme,
          type: type,
          size: size,
          customStyle: customStyle,
        );

        // Same custom style should produce same cached instance
        expect(identical(style1, style2), isTrue);
      },
    );
  });
}

extension StyleCacheGenerators on Any {
  Generator<VelocityButtonType> get velocityButtonType =>
      any.choose(VelocityButtonType.values);

  Generator<VelocityButtonSize> get velocityButtonSize =>
      any.choose(VelocityButtonSize.values);

  Generator<VelocityInputSize> get velocityInputSize =>
      any.choose(VelocityInputSize.values);

  Generator<VelocityCardSize> get velocityCardSize =>
      any.choose(VelocityCardSize.values);
}
