import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/basic/icon/icon.dart';
import 'package:velocity_ui/src/core/types/component_size.dart';

void main() {
  group('VelocityIcon Tests', () {
    testWidgets('displays icon correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: VelocityIcon(Icons.home),
        ),
      );

      expect(find.byType(VelocityIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('handles different unified sizes', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Column(
            children: [
              VelocityIcon(Icons.home, size: VelocitySize.small),
              VelocityIcon(Icons.star, size: VelocitySize.medium),
              VelocityIcon(Icons.settings, size: VelocitySize.large),
            ],
          ),
        ),
      );

      expect(find.byType(VelocityIcon), findsNWidgets(3));
    });

    testWidgets('handles extended sizes', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Column(
            children: [
              VelocityIcon.extended(Icons.home,
                  extendedSize: VelocityExtendedSize.xs),
              VelocityIcon.extended(Icons.star,
                  extendedSize: VelocityExtendedSize.medium),
              VelocityIcon.extended(Icons.settings,
                  extendedSize: VelocityExtendedSize.xl),
            ],
          ),
        ),
      );

      expect(find.byType(VelocityIcon), findsNWidgets(3));
    });

    testWidgets('handles different custom sizes', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Column(
            children: [
              VelocityIcon(Icons.home, customSize: 16),
              VelocityIcon(Icons.star, customSize: 24),
              VelocityIcon(Icons.settings, customSize: 32),
            ],
          ),
        ),
      );

      expect(find.byType(VelocityIcon), findsNWidgets(3));
    });

    testWidgets('handles different colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Column(
            children: [
              VelocityIcon(Icons.home, color: Colors.red),
              VelocityIcon(Icons.star, color: Colors.blue),
              VelocityIcon(Icons.settings, color: Colors.green),
            ],
          ),
        ),
      );

      expect(find.byType(VelocityIcon), findsNWidgets(3));
    });

    testWidgets('handles semantic label', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: VelocityIcon(
            Icons.home,
            semanticLabel: 'Home icon',
          ),
        ),
      );

      expect(find.bySemanticsLabel('Home icon'), findsOneWidget);
    });

    testWidgets('handles custom style', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: VelocityIcon(
            Icons.home,
            style: VelocityIconStyle(
              color: Colors.purple,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityIcon), findsOneWidget);
    });
  });
}
