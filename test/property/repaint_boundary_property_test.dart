/// Property-based tests for VelocityRepaintBoundary
///
/// **Property 2: RepaintBoundary Parameter Effect**
/// **Validates: Requirements 2.2**
///
/// For any component that supports the `useRepaintBoundary` parameter,
/// setting it to `true` SHALL result in a widget tree that contains a
/// RepaintBoundary ancestor, and setting it to `false` SHALL result in
/// no RepaintBoundary being added.
library repaint_boundary_property_test;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' hide Timeout;
import 'package:glados/glados.dart' hide group, test, expect;
import 'package:velocity_ui/src/core/utils/velocity_repaint_boundary.dart';

void main() {
  group('Property 2: RepaintBoundary Parameter Effect', () {
    // Feature: velocity-ui-optimization, Property 2: RepaintBoundary Parameter Effect
    // Validates: Requirements 2.2

    Glados(any.bool).test(
      'VelocityRepaintBoundary enabled parameter controls RepaintBoundary presence',
      (bool enabled) {
        final widget = VelocityRepaintBoundary(
          enabled: enabled,
          child: const Text('Test'),
        );

        final builtWidget = widget.build(MockBuildContext());

        if (enabled) {
          expect(builtWidget, isA<RepaintBoundary>());
        } else {
          expect(builtWidget, isA<Text>());
          expect(builtWidget, isNot(isA<RepaintBoundary>()));
        }
      },
    );

    test('enabled=true wraps child with RepaintBoundary', () {
      const widget = VelocityRepaintBoundary(
        enabled: true,
        child: Text('Test'),
      );

      final builtWidget = widget.build(MockBuildContext());

      expect(builtWidget, isA<RepaintBoundary>());
      final repaintBoundary = builtWidget as RepaintBoundary;
      expect(repaintBoundary.child, isA<Text>());
    });

    test('enabled=false returns child directly without RepaintBoundary', () {
      const widget = VelocityRepaintBoundary(
        enabled: false,
        child: Text('Test'),
      );

      final builtWidget = widget.build(MockBuildContext());

      expect(builtWidget, isA<Text>());
      expect(builtWidget, isNot(isA<RepaintBoundary>()));
    });

    test('default enabled value is true', () {
      const widget = VelocityRepaintBoundary(
        child: Text('Test'),
      );

      expect(widget.enabled, isTrue);
      final builtWidget = widget.build(MockBuildContext());
      expect(builtWidget, isA<RepaintBoundary>());
    });

    testWidgets('RepaintBoundary is present in widget tree when enabled',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityRepaintBoundary(
              enabled: true,
              child: Text('Test'),
            ),
          ),
        ),
      );

      // Find RepaintBoundary that is a descendant of VelocityRepaintBoundary
      final repaintBoundaryFinder = find.descendant(
        of: find.byType(VelocityRepaintBoundary),
        matching: find.byType(RepaintBoundary),
      );

      expect(repaintBoundaryFinder, findsOneWidget);
    });

    testWidgets('RepaintBoundary is not present in widget tree when disabled',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityRepaintBoundary(
              enabled: false,
              child: Text('Test Content'),
            ),
          ),
        ),
      );

      // Find RepaintBoundary that is a direct child of VelocityRepaintBoundary
      // We need to check that VelocityRepaintBoundary doesn't add its own RepaintBoundary
      final velocityRepaintBoundary = tester.widget<VelocityRepaintBoundary>(
          find.byType(VelocityRepaintBoundary));
      final builtWidget = velocityRepaintBoundary
          .build(tester.element(find.byType(VelocityRepaintBoundary)));

      expect(builtWidget, isNot(isA<RepaintBoundary>()));
      expect(builtWidget, isA<Text>());
    });
  });

  group('VelocityAnimatedMixin', () {
    // Feature: velocity-ui-optimization, Property 2: RepaintBoundary Parameter Effect
    // Validates: Requirements 2.2

    test(
        'wrapWithRepaintBoundary adds RepaintBoundary when useRepaintBoundary is true',
        () {
      final state = _TestAnimatedWidgetState(useRepaintBoundary: true);
      const child = Text('Test');

      final wrapped = state.wrapWithRepaintBoundary(child);

      expect(wrapped, isA<RepaintBoundary>());
      final repaintBoundary = wrapped as RepaintBoundary;
      expect(repaintBoundary.child, equals(child));
    });

    test(
        'wrapWithRepaintBoundary returns child directly when useRepaintBoundary is false',
        () {
      final state = _TestAnimatedWidgetState(useRepaintBoundary: false);
      const child = Text('Test');

      final wrapped = state.wrapWithRepaintBoundary(child);

      expect(wrapped, equals(child));
      expect(wrapped, isNot(isA<RepaintBoundary>()));
    });

    Glados(any.bool).test(
      'wrapWithRepaintBoundary behavior matches useRepaintBoundary value',
      (bool useRepaintBoundary) {
        final state =
            _TestAnimatedWidgetState(useRepaintBoundary: useRepaintBoundary);
        const child = Text('Test');

        final wrapped = state.wrapWithRepaintBoundary(child);

        if (useRepaintBoundary) {
          expect(wrapped, isA<RepaintBoundary>());
        } else {
          expect(wrapped, equals(child));
          expect(wrapped, isNot(isA<RepaintBoundary>()));
        }
      },
    );

    test('default useRepaintBoundary is true', () {
      final state = _TestAnimatedWidgetStateDefault();
      expect(state.useRepaintBoundary, isTrue);
    });
  });
}

/// Mock BuildContext for testing widget build methods
class MockBuildContext extends Fake implements BuildContext {}

/// Test widget for VelocityAnimatedMixin
class _TestAnimatedWidget extends StatefulWidget {
  const _TestAnimatedWidget();

  @override
  State<_TestAnimatedWidget> createState() =>
      _TestAnimatedWidgetState(useRepaintBoundary: true);
}

/// Test state with configurable useRepaintBoundary
class _TestAnimatedWidgetState extends State<_TestAnimatedWidget>
    with VelocityAnimatedMixin<_TestAnimatedWidget> {
  _TestAnimatedWidgetState({required bool useRepaintBoundary})
      : _useRepaintBoundary = useRepaintBoundary;

  final bool _useRepaintBoundary;

  @override
  bool get useRepaintBoundary => _useRepaintBoundary;

  @override
  Widget build(BuildContext context) {
    return wrapWithRepaintBoundary(const Text('Test'));
  }
}

/// Test state with default useRepaintBoundary
class _TestAnimatedWidgetStateDefault extends State<_TestAnimatedWidget>
    with VelocityAnimatedMixin<_TestAnimatedWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithRepaintBoundary(const Text('Test'));
  }
}
