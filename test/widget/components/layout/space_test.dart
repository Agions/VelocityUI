import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/layout/space/space.dart';

void main() {
  group('Space Widget', () {
    testWidgets('renders space with width and height',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySpace(
              width: 50,
              height: 50,
            ),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('renders horizontal space', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySpace.horizontal(20),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('renders vertical space', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySpace.vertical(20),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('renders preset space sizes', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                VelocitySpace.xs,
                VelocitySpace.sm,
                VelocitySpace.md,
                VelocitySpace.lg,
                VelocitySpace.xl,
              ],
            ),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('renders space with only width', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySpace(
              width: 100,
            ),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('renders space with only height', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySpace(
              height: 100,
            ),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });
  });
}
