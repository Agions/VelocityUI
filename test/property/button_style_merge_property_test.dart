/// Property-based tests for VelocityButtonStyle merge completeness
///
/// **Property 6: Style Merge Completeness**
/// **Validates: Requirements 4.2, 4.4**
///
/// For any custom style merged with default style, the resulting style SHALL contain
/// all properties from the default style where the custom style property is null,
/// and all properties from the custom style where they are non-null.
library button_style_merge_property_test;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' hide Timeout;
import 'package:glados/glados.dart' hide group, test, expect;
import 'package:velocity_ui/src/components/basic/button/button.dart';

void main() {
  group('Property 6: Style Merge Completeness', () {
    // Feature: velocity-ui-optimization, Property 6: Style Merge Completeness
    // Validates: Requirements 4.2, 4.4

    test('merge with null returns original style', () {
      final defaultStyle = VelocityButtonStyle.defaults();
      final merged = defaultStyle.merge(null);

      expect(merged.backgroundColor, equals(defaultStyle.backgroundColor));
      expect(merged.foregroundColor, equals(defaultStyle.foregroundColor));
      expect(merged.borderRadius, equals(defaultStyle.borderRadius));
      expect(merged.padding, equals(defaultStyle.padding));
    });

    Glados2(any.testColor, any.testColor).test(
      'custom colors override default colors',
      (Color customBg, Color customFg) {
        final defaultStyle = VelocityButtonStyle.defaults();
        final customStyle = VelocityButtonStyle(
          backgroundColor: customBg,
          foregroundColor: customFg,
        );

        final merged = defaultStyle.merge(customStyle);

        // Custom properties should override
        expect(merged.backgroundColor, equals(customBg));
        expect(merged.foregroundColor, equals(customFg));

        // Default properties should be preserved
        expect(merged.borderRadius, equals(defaultStyle.borderRadius));
        expect(merged.padding, equals(defaultStyle.padding));
        expect(merged.textStyle, equals(defaultStyle.textStyle));
        expect(merged.iconSize, equals(defaultStyle.iconSize));
        expect(merged.iconSpacing, equals(defaultStyle.iconSpacing));
      },
    );

    Glados(any.testEdgeInsets).test(
      'custom padding overrides default padding',
      (EdgeInsets customPadding) {
        final defaultStyle = VelocityButtonStyle.defaults();
        final customStyle = VelocityButtonStyle(
          padding: customPadding,
        );

        final merged = defaultStyle.merge(customStyle);

        expect(merged.padding, equals(customPadding));
        expect(merged.backgroundColor, equals(defaultStyle.backgroundColor));
      },
    );

    Glados(any.testBorderRadius).test(
      'custom borderRadius overrides default borderRadius',
      (BorderRadius customRadius) {
        final defaultStyle = VelocityButtonStyle.defaults();
        final customStyle = VelocityButtonStyle(
          borderRadius: customRadius,
        );

        final merged = defaultStyle.merge(customStyle);

        expect(merged.borderRadius, equals(customRadius));
        expect(merged.backgroundColor, equals(defaultStyle.backgroundColor));
      },
    );

    Glados2(any.testColor, any.testColor).test(
      'disabled colors can be customized',
      (Color disabledBg, Color disabledFg) {
        final defaultStyle = VelocityButtonStyle.defaults();
        final customStyle = VelocityButtonStyle(
          disabledBackgroundColor: disabledBg,
          disabledForegroundColor: disabledFg,
        );

        final merged = defaultStyle.merge(customStyle);

        expect(merged.disabledBackgroundColor, equals(disabledBg));
        expect(merged.disabledForegroundColor, equals(disabledFg));
      },
    );

    test('merge is associative for non-null properties', () {
      const style1 = VelocityButtonStyle(
        backgroundColor: Colors.red,
      );
      const style2 = VelocityButtonStyle(
        foregroundColor: Colors.white,
      );
      const style3 = VelocityButtonStyle(
        padding: EdgeInsets.all(20),
      );

      // (style1.merge(style2)).merge(style3) should equal style1.merge(style2.merge(style3))
      // for non-overlapping properties
      final merged1 = style1.merge(style2).merge(style3);
      final merged2 = style1.merge(style2.merge(style3));

      expect(merged1.backgroundColor, equals(merged2.backgroundColor));
      expect(merged1.foregroundColor, equals(merged2.foregroundColor));
      expect(merged1.padding, equals(merged2.padding));
    });

    test('later merge overrides earlier values', () {
      const style1 = VelocityButtonStyle(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      );
      const style2 = VelocityButtonStyle(
        backgroundColor: Colors.blue,
      );

      final merged = style1.merge(style2);

      // style2's backgroundColor should override style1's
      expect(merged.backgroundColor, equals(Colors.blue));
      // style1's foregroundColor should be preserved
      expect(merged.foregroundColor, equals(Colors.white));
    });

    Glados2(any.velocityButtonType, any.velocityButtonSize).test(
      'resolve merges type, size, and custom styles correctly',
      (VelocityButtonType type, VelocityButtonSize size) {
        const customStyle = VelocityButtonStyle(
          backgroundColor: Colors.purple,
        );

        final resolved = VelocityButtonStyle.resolve(
          type: type,
          size: size,
          customStyle: customStyle,
        );

        // Custom backgroundColor should override type's default
        expect(resolved.backgroundColor, equals(Colors.purple));

        // Size-based properties should be present
        expect(resolved.padding, isNotNull);
        expect(resolved.borderRadius, isNotNull);
        expect(resolved.textStyle, isNotNull);
      },
    );

    test('VelocityIconButtonStyle merge works correctly', () {
      final defaultStyle = VelocityIconButtonStyle.defaults();
      const customStyle = VelocityIconButtonStyle(
        backgroundColor: Colors.blue,
        iconColor: Colors.white,
      );

      final merged = defaultStyle.merge(customStyle);

      expect(merged.backgroundColor, equals(Colors.blue));
      expect(merged.iconColor, equals(Colors.white));
      expect(merged.splashColor, equals(defaultStyle.splashColor));
      expect(merged.highlightColor, equals(defaultStyle.highlightColor));
    });

    test('VelocityIconButtonStyle merge with null returns original', () {
      final defaultStyle = VelocityIconButtonStyle.defaults();
      final merged = defaultStyle.merge(null);

      expect(merged.backgroundColor, equals(defaultStyle.backgroundColor));
      expect(merged.iconColor, equals(defaultStyle.iconColor));
    });

    Glados2(any.testColor, any.testColor).test(
      'VelocityIconButtonStyle custom colors override defaults',
      (Color customBg, Color customIcon) {
        final defaultStyle = VelocityIconButtonStyle.defaults();
        final customStyle = VelocityIconButtonStyle(
          backgroundColor: customBg,
          iconColor: customIcon,
        );

        final merged = defaultStyle.merge(customStyle);

        expect(merged.backgroundColor, equals(customBg));
        expect(merged.iconColor, equals(customIcon));
        expect(merged.splashColor, equals(defaultStyle.splashColor));
      },
    );
  });
}

extension StyleMergeGenerators on Any {
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

  Generator<EdgeInsets> get testEdgeInsets => any.choose([
        const EdgeInsets.all(8),
        const EdgeInsets.all(12),
        const EdgeInsets.all(16),
        const EdgeInsets.all(20),
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ]);

  Generator<BorderRadius> get testBorderRadius => any.choose([
        const BorderRadius.all(Radius.circular(4)),
        const BorderRadius.all(Radius.circular(8)),
        const BorderRadius.all(Radius.circular(12)),
        const BorderRadius.all(Radius.circular(16)),
        const BorderRadius.all(Radius.circular(20)),
      ]);

  Generator<VelocityButtonType> get velocityButtonType =>
      any.choose(VelocityButtonType.values);

  Generator<VelocityButtonSize> get velocityButtonSize =>
      any.choose(VelocityButtonSize.values);
}
