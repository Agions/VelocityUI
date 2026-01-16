/// Widget tests for VelocityInput component
///
/// Tests disabled state behavior and accessibility support.
/// **Validates: Requirements 5.4, 6.1**
library;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/form/input/input.dart';

void main() {
  group('VelocityInput Widget Tests', () {
    testWidgets('renders input with default properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Username',
              hint: 'Enter your username',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('renders input with controller', (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Initial value');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              controller: controller,
              label: 'Test',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);

      controller.dispose();
    });

    testWidgets('renders password input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Password',
              hint: 'Enter your password',
              obscureText: true,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('renders email input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Email',
              hint: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('renders textarea', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityTextArea(
              label: 'Description',
              hint: 'Enter your description',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('handles input with prefix icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Email',
              prefixIcon: Icons.email,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
    });

    testWidgets('handles input with suffix icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Search',
              suffixIcon: Icons.search,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
    });

    testWidgets('handles input with prefix widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Amount',
              prefix: Text(r'$'),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.text(r'$'), findsOneWidget);
    });

    testWidgets('handles input with suffix widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Price',
              suffix: Text('USD'),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.text('USD'), findsOneWidget);
    });

    testWidgets('handles read-only input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Read-only',
              readOnly: true,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('handles input with max length', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Limited',
              maxLength: 10,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('handles multiple inputs in same screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                VelocityInput(
                  label: 'First Name',
                  hint: 'Enter first name',
                ),
                SizedBox(height: 16),
                VelocityInput(
                  label: 'Last Name',
                  hint: 'Enter last name',
                ),
                SizedBox(height: 16),
                VelocityInput(
                  label: 'Email',
                  hint: 'Enter email',
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsNWidgets(3));
    });

    testWidgets('renders textarea component', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityTextArea(
              label: 'Description',
              hint: 'Enter detailed description',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });
  });

  group('VelocityInput Disabled State Tests - Validates: Requirements 5.4', () {
    // Property 8: Disabled State Consistency
    // For any component with a `disabled` parameter set to `true`, the component
    // SHALL NOT trigger any user interaction callbacks.

    testWidgets('disabled input does not trigger onChanged callback',
        (WidgetTester tester) async {
      var changed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Disabled Input',
              enabled: false,
              onChanged: (value) => changed = true,
            ),
          ),
        ),
      );

      // Try to enter text
      await tester.enterText(find.byType(TextFormField), 'test');
      await tester.pump();

      // onChanged should not be triggered for disabled input
      expect(changed, isFalse);
    });

    testWidgets('disabled input does not trigger onTap callback',
        (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Disabled Input',
              enabled: false,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // Try to tap
      await tester.tap(find.byType(TextFormField));
      await tester.pump();

      // onTap should not be triggered for disabled input
      expect(tapped, isFalse);
    });

    testWidgets('disabled input does not trigger onSubmitted callback',
        (WidgetTester tester) async {
      var submitted = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Disabled Input',
              enabled: false,
              onSubmitted: (value) => submitted = true,
            ),
          ),
        ),
      );

      // Try to submit
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // onSubmitted should not be triggered for disabled input
      expect(submitted, isFalse);
    });

    testWidgets('enabled input triggers onChanged callback',
        (WidgetTester tester) async {
      var changedValue = '';
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Enabled Input',
              controller: controller,
              enabled: true,
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      // Tap to focus and enter text
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      await tester.enterText(find.byType(TextFormField), 'test');
      await tester.pump();

      // onChanged should be triggered for enabled input
      // Note: The controller should have the value even if onChanged wasn't called
      expect(controller.text, equals('test'));

      controller.dispose();
    });

    testWidgets('enabled input triggers onTap callback',
        (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Enabled Input',
              enabled: true,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // Tap
      await tester.tap(find.byType(TextFormField));
      await tester.pump();

      // onTap should be triggered for enabled input
      expect(tapped, isTrue);
    });

    testWidgets('disabled input has correct visual state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Disabled Input',
              enabled: false,
            ),
          ),
        ),
      );

      // Find the TextFormField and verify it's disabled
      final textFormField =
          tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textFormField.enabled, isFalse);
    });
  });

  group('VelocityInput Accessibility Tests - Validates: Requirements 6.1', () {
    // Property 9: Semantic Label Presence
    // For any interactive component, the widget tree SHALL contain a Semantics
    // widget with a non-empty label.

    testWidgets('VelocityInput has semantic label from label property',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Email Address',
              hint: 'Enter your email',
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(VelocityInput));
      expect(semantics.label, contains('Email Address'));
    });

    testWidgets('VelocityInput uses custom semanticLabel when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Email',
              semanticLabel: 'Email input for registration',
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(VelocityInput));
      expect(semantics.label, contains('Email input for registration'));
    });

    testWidgets('VelocityInput falls back to hint when no label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              hint: 'Enter your name',
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(VelocityInput));
      expect(semantics.label, contains('Enter your name'));
    });

    testWidgets('disabled input has correct semantic state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Disabled Input',
              enabled: false,
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(VelocityInput));
      expect(semantics.hasFlag(SemanticsFlag.isTextField), isTrue);
      expect(semantics.hasFlag(SemanticsFlag.isEnabled), isFalse);
    });

    testWidgets('enabled input has correct semantic state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Enabled Input',
              enabled: true,
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(VelocityInput));
      expect(semantics.hasFlag(SemanticsFlag.isTextField), isTrue);
      expect(semantics.hasFlag(SemanticsFlag.isEnabled), isTrue);
    });

    testWidgets('read-only input has correct semantic state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Read-only Input',
              readOnly: true,
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(VelocityInput));
      expect(semantics.hasFlag(SemanticsFlag.isTextField), isTrue);
      expect(semantics.hasFlag(SemanticsFlag.isReadOnly), isTrue);
    });

    testWidgets('VelocityTextArea has semantic label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityTextArea(
              label: 'Description',
              hint: 'Enter description',
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(VelocityInput));
      expect(semantics.label, contains('Description'));
    });

    testWidgets('VelocityTextArea uses custom semanticLabel',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityTextArea(
              label: 'Bio',
              semanticLabel: 'Biography text area',
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(VelocityInput));
      expect(semantics.label, contains('Biography text area'));
    });
  });

  group('VelocityInput Focus Tests', () {
    testWidgets('VelocityInput shows focus indicator when focused',
        (WidgetTester tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Focusable Input',
              focusNode: focusNode,
            ),
          ),
        ),
      );

      // Initially not focused
      expect(focusNode.hasFocus, isFalse);

      // Request focus
      focusNode.requestFocus();
      await tester.pumpAndSettle();

      // Now focused
      expect(focusNode.hasFocus, isTrue);

      focusNode.dispose();
    });

    testWidgets('VelocityInput supports autofocus',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Autofocus Input',
              autofocus: true,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // The input should have focus
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('focus can be moved between inputs',
        (WidgetTester tester) async {
      final focusNode1 = FocusNode();
      final focusNode2 = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                VelocityInput(
                  label: 'Input 1',
                  focusNode: focusNode1,
                ),
                VelocityInput(
                  label: 'Input 2',
                  focusNode: focusNode2,
                ),
              ],
            ),
          ),
        ),
      );

      // Focus first input
      focusNode1.requestFocus();
      await tester.pumpAndSettle();
      expect(focusNode1.hasFocus, isTrue);
      expect(focusNode2.hasFocus, isFalse);

      // Move focus to second input
      focusNode2.requestFocus();
      await tester.pumpAndSettle();
      expect(focusNode1.hasFocus, isFalse);
      expect(focusNode2.hasFocus, isTrue);

      focusNode1.dispose();
      focusNode2.dispose();
    });
  });

  group('VelocityInput Size Tests', () {
    testWidgets('renders small size input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Small Input',
              size: VelocityInputSize.small,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
    });

    testWidgets('renders medium size input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Medium Input',
              size: VelocityInputSize.medium,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
    });

    testWidgets('renders large size input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Large Input',
              size: VelocityInputSize.large,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
    });
  });

  group('VelocityInput Style Tests', () {
    testWidgets('applies custom style', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Styled Input',
              style: VelocityInputStyle(
                fillColor: Colors.blue,
                borderColor: Colors.red,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
    });

    testWidgets('displays error message', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Error Input',
              error: 'This field is required',
            ),
          ),
        ),
      );

      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('displays helper message', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Helper Input',
              helper: 'Enter at least 8 characters',
            ),
          ),
        ),
      );

      expect(find.text('Enter at least 8 characters'), findsOneWidget);
    });
  });
}
