import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/navigation/breadcrumb/breadcrumb.dart';

void main() {
  group('Breadcrumb Widget', () {
    testWidgets('renders breadcrumb with items', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: [
                VelocityBreadcrumbItem(label: 'Home'),
                VelocityBreadcrumbItem(label: 'Products'),
                VelocityBreadcrumbItem(label: 'Electronics'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Products'), findsOneWidget);
      expect(find.text('Electronics'), findsOneWidget);
    });

    testWidgets('renders breadcrumb with single item',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: [
                VelocityBreadcrumbItem(label: 'Home'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('renders breadcrumb with empty items',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: [],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBreadcrumb), findsOneWidget);
    });

    testWidgets('calls onItemTap when breadcrumb item is tapped',
        (WidgetTester tester) async {
      var tappedIndex = -1;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: const [
                VelocityBreadcrumbItem(label: 'Home'),
                VelocityBreadcrumbItem(label: 'Products'),
              ],
              onItemTap: (index) {
                tappedIndex = index;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      expect(tappedIndex, equals(0));
    });

    testWidgets('renders breadcrumb with custom separator',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: [
                VelocityBreadcrumbItem(label: 'Home'),
                VelocityBreadcrumbItem(label: 'Products'),
              ],
              separator: '/',
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Products'), findsOneWidget);
    });

    testWidgets('renders breadcrumb with wrap enabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: [
                VelocityBreadcrumbItem(label: 'Home'),
                VelocityBreadcrumbItem(label: 'Products'),
                VelocityBreadcrumbItem(label: 'Electronics'),
              ],
              wrap: true,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBreadcrumb), findsOneWidget);
    });
  });
}
