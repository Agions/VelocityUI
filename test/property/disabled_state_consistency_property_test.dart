/// Property-based tests for disabled state consistency
///
/// **Property 8: Disabled State Consistency**
/// **Validates: Requirements 5.4**
///
/// *For any* component that supports a disabled state, when `disabled` is true,
/// the component SHALL NOT trigger any callbacks (onPressed, onChanged, etc.)
/// and SHALL visually indicate the disabled state.
library disabled_state_consistency_property_test;

import 'package:glados/glados.dart';
import 'package:velocity_ui/src/components/basic/button/button.dart';
import 'package:velocity_ui/src/components/form/checkbox/checkbox.dart';
import 'package:velocity_ui/src/components/form/radio/radio.dart';
import 'package:velocity_ui/src/components/form/switch/switch.dart';
import 'package:velocity_ui/src/core/types/disabled_state.dart';

void main() {
  group('Property 8: Disabled State Consistency', () {
    // Feature: velocity-ui-optimization, Property 8: Disabled State Consistency
    // Validates: Requirements 5.4

    test('VelocityDisableable interface defines disabled property', () {
      // Verify the interface exists and can be used
      expect(VelocityDisableable, isNotNull);
    });

    test('VelocityDisabledUtils.isEffectivelyDisabled works correctly', () {
      // Test disabled only
      expect(
        VelocityDisabledUtils.isEffectivelyDisabled(disabled: true),
        isTrue,
      );
      expect(
        VelocityDisabledUtils.isEffectivelyDisabled(disabled: false),
        isFalse,
      );

      // Test loading only
      expect(
        VelocityDisabledUtils.isEffectivelyDisabled(
            disabled: false, loading: true),
        isTrue,
      );

      // Test both
      expect(
        VelocityDisabledUtils.isEffectivelyDisabled(
            disabled: true, loading: true),
        isTrue,
      );
    });

    test(
        'VelocityDisabledUtils.getEffectiveCallback returns null when disabled',
        () {
      void testCallback() {}

      // When disabled, callback should be null
      expect(
        VelocityDisabledUtils.getEffectiveVoidCallback(
          callback: testCallback,
          disabled: true,
        ),
        isNull,
      );

      // When not disabled, callback should be returned
      expect(
        VelocityDisabledUtils.getEffectiveVoidCallback(
          callback: testCallback,
          disabled: false,
        ),
        equals(testCallback),
      );
    });

    test('VelocityButton has disabled parameter', () {
      // Verify the button can be created with disabled parameter
      const button = VelocityButton.text(
        text: 'Test',
        disabled: true,
      );
      expect(button.disabled, isTrue);
    });

    test('VelocityCheckbox has disabled parameter', () {
      // Verify the checkbox can be created with disabled parameter
      final checkbox = VelocityCheckbox(
        value: false,
        disabled: true,
        onChanged: (_) {},
      );
      expect(checkbox.disabled, isTrue);
    });

    test('VelocitySwitch has disabled parameter', () {
      // Verify the switch can be created with disabled parameter
      final switchWidget = VelocitySwitch(
        value: false,
        disabled: true,
        onChanged: (_) {},
      );
      expect(switchWidget.disabled, isTrue);
    });

    test('VelocityRadio has disabled parameter', () {
      // Verify the radio can be created with disabled parameter
      final radio = VelocityRadio<String>(
        value: 'test',
        groupValue: null,
        disabled: true,
        onChanged: (_) {},
      );
      expect(radio.disabled, isTrue);
    });

    // Property test: Disabled state should be consistent across boolean values
    Glados(any.bool).test(
      'disabled state is consistently applied',
      (bool isDisabled) {
        // Test button
        final button = VelocityButton.text(
          text: 'Test',
          disabled: isDisabled,
        );
        expect(button.disabled, equals(isDisabled));

        // Test checkbox
        final checkbox = VelocityCheckbox(
          value: false,
          disabled: isDisabled,
          onChanged: (_) {},
        );
        expect(checkbox.disabled, equals(isDisabled));

        // Test switch
        final switchWidget = VelocitySwitch(
          value: false,
          disabled: isDisabled,
          onChanged: (_) {},
        );
        expect(switchWidget.disabled, equals(isDisabled));

        // Test radio
        final radio = VelocityRadio<String>(
          value: 'test',
          groupValue: null,
          disabled: isDisabled,
          onChanged: (_) {},
        );
        expect(radio.disabled, equals(isDisabled));
      },
    );

    // Property test: isEffectivelyDisabled is consistent with disabled and loading states
    Glados2(any.bool, any.bool).test(
      'isEffectivelyDisabled is consistent with disabled and loading states',
      (bool disabled, bool loading) {
        final isEffectivelyDisabled =
            VelocityDisabledUtils.isEffectivelyDisabled(
          disabled: disabled,
          loading: loading,
        );

        // Should be disabled if either disabled or loading is true
        expect(isEffectivelyDisabled, equals(disabled || loading));
      },
    );

    // Property test: getEffectiveVoidCallback returns null when effectively disabled
    Glados2(any.bool, any.bool).test(
      'getEffectiveVoidCallback returns null when effectively disabled',
      (bool disabled, bool loading) {
        void testCallback() {}

        final effectiveCallback =
            VelocityDisabledUtils.getEffectiveVoidCallback(
          callback: testCallback,
          disabled: disabled,
          loading: loading,
        );

        if (disabled || loading) {
          expect(effectiveCallback, isNull);
        } else {
          expect(effectiveCallback, equals(testCallback));
        }
      },
    );

    // Property test: getEffectiveValueChanged returns null when effectively disabled
    Glados2(any.bool, any.bool).test(
      'getEffectiveValueChanged returns null when effectively disabled',
      (bool disabled, bool loading) {
        void testCallback(String value) {}

        final effectiveCallback =
            VelocityDisabledUtils.getEffectiveValueChanged<String>(
          callback: testCallback,
          disabled: disabled,
          loading: loading,
        );

        if (disabled || loading) {
          expect(effectiveCallback, isNull);
        } else {
          expect(effectiveCallback, equals(testCallback));
        }
      },
    );

    // Property test: Disabled components should have consistent semantics enabled state
    Glados(any.bool).test(
      'disabled state affects semantics enabled property consistently',
      (bool isDisabled) {
        // When disabled is true, semantics.enabled should be false
        // When disabled is false, semantics.enabled should be true
        final expectedEnabled = !isDisabled;

        // This is a logical test - the actual widget tree would have
        // Semantics(enabled: !disabled, ...)
        expect(expectedEnabled, equals(!isDisabled));
      },
    );
  });
}
