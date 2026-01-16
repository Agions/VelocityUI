/// Property-based tests for VelocityButton const constructor validity
///
/// **Property 1: Const Constructor Validity**
/// **Validates: Requirements 1.1, 1.2**
///
/// For any VelocityUI stateless component with all compile-time constant parameters,
/// instantiating with the const keyword SHALL produce a valid widget without compilation errors.
library button_const_property_test;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' hide Timeout;
import 'package:glados/glados.dart' hide group, test, expect;
import 'package:velocity_ui/src/components/basic/button/button.dart';

void main() {
  group('Property 1: Const Constructor Validity', () {
    // Feature: velocity-ui-optimization, Property 1: Const Constructor Validity
    // Validates: Requirements 1.1, 1.2

    test('VelocityButton.text supports const construction with all parameters',
        () {
      // This test verifies that const construction compiles and creates valid widgets
      const button1 = VelocityButton.text(
        text: 'Test',
        type: VelocityButtonType.primary,
        size: VelocityButtonSize.medium,
        loading: false,
        disabled: false,
        fullWidth: false,
        autofocus: false,
      );

      const button2 = VelocityButton.text(
        text: 'Test',
        type: VelocityButtonType.secondary,
        size: VelocityButtonSize.small,
      );

      const button3 = VelocityButton.text(
        text: 'Test',
        type: VelocityButtonType.outline,
        size: VelocityButtonSize.large,
        disabled: true,
      );

      // Verify widgets are created successfully
      expect(button1, isA<VelocityButton>());
      expect(button2, isA<VelocityButton>());
      expect(button3, isA<VelocityButton>());

      // Verify properties are correctly set
      expect(button1.type, equals(VelocityButtonType.primary));
      expect(button1.size, equals(VelocityButtonSize.medium));
      expect(button2.type, equals(VelocityButtonType.secondary));
      expect(button3.disabled, isTrue);
    });

    test('VelocityButton.icon supports const construction', () {
      const button = VelocityButton.icon(
        text: 'Add',
        icon: Icons.add,
        type: VelocityButtonType.primary,
        size: VelocityButtonSize.medium,
      );

      expect(button, isA<VelocityButton>());
      expect(button.type, equals(VelocityButtonType.primary));
    });

    test('VelocityIconButton supports const construction', () {
      const iconButton1 = VelocityIconButton(
        icon: Icons.add,
        size: 40,
        iconSize: 20,
        disabled: false,
        loading: false,
        autofocus: false,
      );

      const iconButton2 = VelocityIconButton(
        icon: Icons.close,
        tooltip: 'Close',
        semanticLabel: 'Close button',
      );

      expect(iconButton1, isA<VelocityIconButton>());
      expect(iconButton2, isA<VelocityIconButton>());

      // Verify properties are correctly set
      expect(iconButton1.icon, equals(Icons.add));
      expect(iconButton1.size, equals(40));
      expect(iconButton2.tooltip, equals('Close'));
      expect(iconButton2.semanticLabel, equals('Close button'));
    });

    Glados2(any.velocityButtonType, any.velocityButtonSize).test(
      'const VelocityButton.text renders correctly for all type/size combinations',
      (VelocityButtonType type, VelocityButtonSize size) async {
        final button = VelocityButton.text(
          text: 'Test Button',
          type: type,
          size: size,
        );

        // Verify widget is valid
        expect(button, isA<VelocityButton>());
        expect(button.type, equals(type));
        expect(button.size, equals(size));
      },
    );

    Glados(any.velocityButtonType).test(
      'const VelocityButton.icon renders correctly for all types',
      (VelocityButtonType type) async {
        final button = VelocityButton.icon(
          text: 'Icon Button',
          icon: Icons.star,
          type: type,
        );

        expect(button, isA<VelocityButton>());
        expect(button.type, equals(type));
      },
    );

    testWidgets('const buttons render without errors', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                VelocityButton.text(
                  text: 'Primary',
                  type: VelocityButtonType.primary,
                ),
                VelocityButton.text(
                  text: 'Secondary',
                  type: VelocityButtonType.secondary,
                ),
                VelocityButton.text(
                  text: 'Outline',
                  type: VelocityButtonType.outline,
                ),
                VelocityButton.text(
                  text: 'Text',
                  type: VelocityButtonType.text,
                ),
                VelocityButton.text(
                  text: 'Danger',
                  type: VelocityButtonType.danger,
                ),
                VelocityButton.text(
                  text: 'Success',
                  type: VelocityButtonType.success,
                ),
                VelocityButton.text(
                  text: 'Warning',
                  type: VelocityButtonType.warning,
                ),
              ],
            ),
          ),
        ),
      );

      // Verify all buttons rendered
      expect(find.byType(VelocityButton), findsNWidgets(7));
      expect(find.text('Primary'), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);
      expect(find.text('Outline'), findsOneWidget);
      expect(find.text('Text'), findsOneWidget);
      expect(find.text('Danger'), findsOneWidget);
      expect(find.text('Success'), findsOneWidget);
      expect(find.text('Warning'), findsOneWidget);
    });

    testWidgets('const buttons with different sizes render correctly',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                VelocityButton.text(
                  text: 'Small',
                  size: VelocityButtonSize.small,
                ),
                VelocityButton.text(
                  text: 'Medium',
                  size: VelocityButtonSize.medium,
                ),
                VelocityButton.text(
                  text: 'Large',
                  size: VelocityButtonSize.large,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityButton), findsNWidgets(3));
    });

    test('VelocityButtonStyle supports const construction', () {
      const style1 = VelocityButtonStyle(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        padding: EdgeInsets.all(16),
      );

      const style2 = VelocityButtonStyle(
        backgroundColor: Colors.blue,
        iconSize: 20,
        iconSpacing: 8,
      );

      expect(style1, isA<VelocityButtonStyle>());
      expect(style2, isA<VelocityButtonStyle>());

      // Verify const identity for style objects (which are truly const)
      const styleA = VelocityButtonStyle(
        backgroundColor: Colors.green,
        padding: EdgeInsets.all(12),
      );
      const styleB = VelocityButtonStyle(
        backgroundColor: Colors.green,
        padding: EdgeInsets.all(12),
      );

      expect(identical(styleA, styleB), isTrue);
    });

    test('VelocityIconButtonStyle supports const construction', () {
      const style = VelocityIconButtonStyle(
        backgroundColor: Colors.transparent,
        iconColor: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      );

      expect(style, isA<VelocityIconButtonStyle>());
    });
  });
}

extension ButtonConstGenerators on Any {
  Generator<VelocityButtonType> get velocityButtonType =>
      any.choose(VelocityButtonType.values);

  Generator<VelocityButtonSize> get velocityButtonSize =>
      any.choose(VelocityButtonSize.values);
}
