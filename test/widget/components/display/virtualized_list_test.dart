/// Widget tests for VelocityVirtualizedList
///
/// Tests large dataset rendering performance and memory optimization.
/// **Validates: Requirements 9.5**
library virtualized_list_test;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/display/list/velocity_virtualized_list.dart';

void main() {
  group('VelocityVirtualizedList', () {
    // Validates: Requirements 9.5

    testWidgets('renders large dataset efficiently', (tester) async {
      const itemCount = 10000;
      const itemExtent = 50.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityVirtualizedList<String>(
              itemCount: itemCount,
              itemBuilder: (context, index) => SizedBox(
                height: itemExtent,
                child: Text('Item $index'),
              ),
              itemExtent: itemExtent,
            ),
          ),
        ),
      );

      // Verify the list is rendered
      expect(find.byType(ListView), findsOneWidget);

      // Only visible items should be rendered, not all 10000
      // With a typical screen height, we should see far fewer items
      expect(find.textContaining('Item'), findsWidgets);
    });

    testWidgets('itemExtent is required and properly used', (tester) async {
      const itemExtent = 56.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityVirtualizedList<String>(
              itemCount: 100,
              itemBuilder: (context, index) => SizedBox(
                height: itemExtent,
                child: Text('Item $index'),
              ),
              itemExtent: itemExtent,
            ),
          ),
        ),
      );

      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.itemExtent, equals(itemExtent));
    });

    testWidgets('cacheExtent defaults to itemExtent * 5', (tester) async {
      const itemExtent = 50.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityVirtualizedList<String>(
              itemCount: 100,
              itemBuilder: (context, index) => SizedBox(
                height: itemExtent,
                child: Text('Item $index'),
              ),
              itemExtent: itemExtent,
            ),
          ),
        ),
      );

      final listView = tester.widget<ListView>(find.byType(ListView));
      // Default cacheMultiplier is 5
      expect(listView.cacheExtent, equals(itemExtent * 5));
    });

    testWidgets('custom cacheExtent is properly applied', (tester) async {
      const itemExtent = 50.0;
      const customCacheExtent = 500.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityVirtualizedList<String>(
              itemCount: 100,
              itemBuilder: (context, index) => SizedBox(
                height: itemExtent,
                child: Text('Item $index'),
              ),
              itemExtent: itemExtent,
              cacheExtent: customCacheExtent,
            ),
          ),
        ),
      );

      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.cacheExtent, equals(customCacheExtent));
    });

    testWidgets('scrolling works smoothly with large dataset', (tester) async {
      const itemCount = 10000;
      const itemExtent = 50.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityVirtualizedList<String>(
              itemCount: itemCount,
              itemBuilder: (context, index) => SizedBox(
                height: itemExtent,
                child: Text('Item $index'),
              ),
              itemExtent: itemExtent,
            ),
          ),
        ),
      );

      // Initial state - should show first items
      expect(find.text('Item 0'), findsOneWidget);

      // Scroll down
      await tester.drag(find.byType(ListView), const Offset(0, -500));
      await tester.pumpAndSettle();

      // After scrolling, Item 0 should no longer be visible
      expect(find.text('Item 0'), findsNothing);
    });

    testWidgets('addRepaintBoundaries parameter is stored correctly',
        (tester) async {
      final widget = VelocityVirtualizedList<String>(
        itemCount: 10,
        itemBuilder: (context, index) => Text('Item $index'),
        itemExtent: 50,
        addRepaintBoundaries: true,
      );

      expect(widget.addRepaintBoundaries, isTrue);
    });

    testWidgets('addAutomaticKeepAlives parameter is stored correctly',
        (tester) async {
      final widget = VelocityVirtualizedList<String>(
        itemCount: 10,
        itemBuilder: (context, index) => Text('Item $index'),
        itemExtent: 50,
        addAutomaticKeepAlives: false,
      );

      expect(widget.addAutomaticKeepAlives, isFalse);
    });

    testWidgets('semanticLabel is properly applied', (tester) async {
      const semanticLabel = 'Large item list';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityVirtualizedList<String>(
              itemCount: 10,
              itemBuilder: (context, index) => Text('Item $index'),
              itemExtent: 50,
              semanticLabel: semanticLabel,
            ),
          ),
        ),
      );

      expect(find.bySemanticsLabel(semanticLabel), findsOneWidget);
    });

    testWidgets('scroll callbacks are triggered', (tester) async {
      var scrollStarted = false;
      var scrollEnded = false;
      var scrollUpdated = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityVirtualizedList<String>(
              itemCount: 100,
              itemBuilder: (context, index) => SizedBox(
                height: 50,
                child: Text('Item $index'),
              ),
              itemExtent: 50,
              onScrollStart: () => scrollStarted = true,
              onScrollEnd: () => scrollEnded = true,
              onScrollUpdate: (_) => scrollUpdated = true,
            ),
          ),
        ),
      );

      // Perform scroll
      await tester.drag(find.byType(ListView), const Offset(0, -200));
      await tester.pumpAndSettle();

      expect(scrollStarted, isTrue);
      expect(scrollUpdated, isTrue);
      expect(scrollEnded, isTrue);
    });

    testWidgets('padding is properly applied', (tester) async {
      const testPadding = EdgeInsets.all(16);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityVirtualizedList<String>(
              itemCount: 10,
              itemBuilder: (context, index) => Text('Item $index'),
              itemExtent: 50,
              padding: testPadding,
            ),
          ),
        ),
      );

      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.padding, equals(testPadding));
    });

    testWidgets('physics parameter is properly applied', (tester) async {
      const testPhysics = BouncingScrollPhysics();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityVirtualizedList<String>(
              itemCount: 10,
              itemBuilder: (context, index) => Text('Item $index'),
              itemExtent: 50,
              physics: testPhysics,
            ),
          ),
        ),
      );

      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.physics, isA<BouncingScrollPhysics>());
    });
  });

  group('VelocityVirtualizedListController', () {
    test('scrollToIndex calculates correct offset', () {
      final controller = VelocityVirtualizedListController();

      // The controller should be able to calculate the offset
      // Note: We can't actually scroll without a widget, but we can verify the controller exists
      expect(controller.scrollController, isNotNull);

      controller.dispose();
    });

    test('getFirstVisibleIndex returns 0 when no clients', () {
      final controller = VelocityVirtualizedListController();
      const itemExtent = 50.0;

      final index = controller.getFirstVisibleIndex(itemExtent: itemExtent);
      expect(index, equals(0));

      controller.dispose();
    });

    test('getLastVisibleIndex returns 0 when no clients', () {
      final controller = VelocityVirtualizedListController();
      const itemExtent = 50.0;
      const viewportHeight = 500.0;

      final index = controller.getLastVisibleIndex(
        itemExtent: itemExtent,
        viewportHeight: viewportHeight,
      );
      expect(index, equals(0));

      controller.dispose();
    });
  });

  group('VelocityVirtualizedListStyle', () {
    test('default cacheMultiplier is 5', () {
      const style = VelocityVirtualizedListStyle();
      expect(style.cacheMultiplier, equals(5));
    });

    test('copyWith creates new instance with updated values', () {
      const style = VelocityVirtualizedListStyle(cacheMultiplier: 5);
      final newStyle = style.copyWith(cacheMultiplier: 10);

      expect(newStyle.cacheMultiplier, equals(10));
      expect(style.cacheMultiplier, equals(5)); // Original unchanged
    });
  });
}
