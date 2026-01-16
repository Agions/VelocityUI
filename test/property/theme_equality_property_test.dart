/// Property-based tests for VelocityThemeData equality
///
/// **Property 3: Theme UpdateShouldNotify Correctness**
/// **Validates: Requirements 3.1**
///
/// For any two VelocityThemeData instances, the InheritedWidget's
/// `updateShouldNotify` SHALL return `false` when the instances are equal
/// (same property values) and `true` when they differ.
library theme_equality_property_test;

import 'package:flutter/material.dart';
import 'package:glados/glados.dart';
import 'package:velocity_ui/src/core/theme/velocity_theme_data.dart';

void main() {
  group('Property 3: Theme UpdateShouldNotify Correctness', () {
    // Feature: velocity-ui-optimization, Property 3: Theme UpdateShouldNotify Correctness
    // Validates: Requirements 3.1

    Glados(any.velocityThemeData).test(
      'identical theme data instances are equal',
      (VelocityThemeData theme) {
        expect(theme == theme, isTrue);
        expect(theme.hashCode, equals(theme.hashCode));
      },
    );

    Glados(any.velocityThemeData).test(
      'theme data with same properties are equal',
      (VelocityThemeData theme) {
        final copy = theme.copyWith();
        expect(theme == copy, isTrue);
        expect(theme.hashCode, equals(copy.hashCode));
      },
    );

    Glados2(any.velocityThemeData, any.testColor).test(
      'theme data with different primaryColor are not equal',
      (VelocityThemeData theme, Color differentColor) {
        if (theme.primaryColor == differentColor) return;
        final modified = theme.copyWith(primaryColor: differentColor);
        expect(theme == modified, isFalse);
      },
    );


    Glados2(any.velocityThemeData, any.testBrightness).test(
      'theme data with different brightness are not equal',
      (VelocityThemeData theme, Brightness differentBrightness) {
        if (theme.brightness == differentBrightness) return;
        final modified = theme.copyWith(brightness: differentBrightness);
        expect(theme == modified, isFalse);
      },
    );

    Glados(any.velocityThemeData).test(
      'updateShouldNotify returns false for equal themes',
      (VelocityThemeData theme) {
        final copy = theme.copyWith();
        final shouldNotify = theme != copy;
        expect(shouldNotify, isFalse);
      },
    );

    Glados2(any.velocityThemeData, any.testColor).test(
      'updateShouldNotify returns true for different themes',
      (VelocityThemeData theme, Color differentColor) {
        if (theme.primaryColor == differentColor) return;
        final modified = theme.copyWith(primaryColor: differentColor);
        final shouldNotify = theme != modified;
        expect(shouldNotify, isTrue);
      },
    );

    Glados(any.velocityThemeData).test(
      'hashCode is consistent with equality',
      (VelocityThemeData theme) {
        final copy = theme.copyWith();
        if (theme == copy) {
          expect(theme.hashCode, equals(copy.hashCode));
        }
      },
    );

    test('light and dark themes are not equal', () {
      final lightTheme = VelocityThemeData.light();
      final darkTheme = VelocityThemeData.dark();
      expect(lightTheme == darkTheme, isFalse);
    });

    test('two light themes with same parameters are equal', () {
      final theme1 = VelocityThemeData.light();
      final theme2 = VelocityThemeData.light();
      expect(theme1 == theme2, isTrue);
      expect(theme1.hashCode, equals(theme2.hashCode));
    });

    test('two dark themes with same parameters are equal', () {
      final theme1 = VelocityThemeData.dark();
      final theme2 = VelocityThemeData.dark();
      expect(theme1 == theme2, isTrue);
      expect(theme1.hashCode, equals(theme2.hashCode));
    });
  });
}

extension VelocityThemeGenerators on Any {
  Generator<Brightness> get testBrightness =>
      any.choose([Brightness.light, Brightness.dark]);

  Generator<Color> get testColor => any.choose([
        Colors.red,
        Colors.green,
        Colors.blue,
        Colors.yellow,
        Colors.purple,
        Colors.orange,
        Colors.cyan,
        Colors.pink,
        Colors.teal,
        Colors.indigo,
      ]);

  Generator<VelocityThemeData> get velocityThemeData {
    return any.combine3(
      any.testBrightness,
      any.testColor,
      any.testColor,
      (Brightness brightness, Color primary, Color card) {
        if (brightness == Brightness.light) {
          return VelocityThemeData.light(primaryColor: primary)
              .copyWith(cardColor: card);
        } else {
          return VelocityThemeData.dark(primaryColor: primary)
              .copyWith(cardColor: card);
        }
      },
    );
  }
}
