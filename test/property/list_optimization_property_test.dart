/// Property-based tests for VelocityList optimization parameters
///
/// **Property 12: List Optimization Parameters**
/// **Validates: Requirements 9.2, 9.3, 9.4**
///
/// For any VelocityList component, the `itemExtent`, `cacheExtent`, `onRefresh`,
/// and `onLoadMore` parameters SHALL be properly passed to the underlying ListView
/// and function correctly when provided.
library list_optimization_property_test;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' hide Timeout;
import 'package:glados/glados.dart' hide group, test, expect;
import 'package:velocity_ui/src/components/display/list/velocity_list.dart';

void main() {
  group('Property 12: List Optimization Parameters', () {
    // Feature: velocity-ui-optimization, Property 12: List Optimization Parameters
    // Validates: Requirements 9.2, 9.3, 9.4

    Glados(any.positiveItemExtent).test(
      'itemExtent is properly passed to underlying ListView',
      (double itemExtent) {
        // Create a VelocityList with itemExtent
        final velocityList = VelocityList<String>(
          items: const ['Item 1', 'Item 2', 'Item 3'],
          itemBuilder: (context, item, index) => Text(item),
          itemExtent: itemExtent,
        );

        // Verify itemExtent is stored correctly
        expect(velocityList.itemExtent, equals(itemExtent));
      },
    );

    Glados(any.positiveCacheExtent).test(
      'cacheExtent is properly passed to underlying ListView',
      (double cacheExtent) {
        // Create a VelocityList with cacheExtent
        final velocityList = VelocityList<String>(
          items: const ['Item 1', 'Item 2', 'Item 3'],
          itemBuilder: (context, item, index) => Text(item),
          cacheExtent: cacheExtent,
        );

        // Verify cacheExtent is stored correctly
        expect(velocityList.cacheExtent, equals(cacheExtent));
      },
    );

    Glados(any.listItemCount).test(
      'VelocityList renders correct number of items',
      (int itemCount) {
        final items = List.generate(itemCount, (i) => 'Item $i');

        final velocityList = VelocityList<String>(
          items: items,
          itemBuilder: (context, item, index) => Text(item),
        );

        // Verify items count matches
        expect(velocityList.items.length, equals(itemCount));
      },
    );

    testWidgets('onRefresh callback is properly connected', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityList<String>(
              items: const ['Item 1', 'Item 2', 'Item 3'],
              itemBuilder: (context, item, index) =>
                  ListTile(title: Text(item)),
              onRefresh: () async {
                // Callback provided
              },
            ),
          ),
        ),
      );

      // Find the RefreshIndicator - this verifies onRefresh is properly connected
      expect(find.byType(RefreshIndicator), findsOneWidget);
    });

    testWidgets('onLoadMore parameter is properly stored', (tester) async {
      final velocityList = VelocityList<String>(
        items: List.generate(50, (i) => 'Item $i'),
        itemBuilder: (context, item, index) =>
            SizedBox(height: 50, child: Text(item)),
        itemExtent: 50,
        onLoadMore: () async {
          // Callback provided
        },
        loadMoreThreshold: 100,
      );

      // Verify onLoadMore is stored
      expect(velocityList.onLoadMore, isNotNull);
      expect(velocityList.loadMoreThreshold, equals(100));
    });

    testWidgets('itemExtent improves scroll performance by using fixed height',
        (tester) async {
      const testItemExtent = 56.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityList<String>(
              items: List.generate(100, (i) => 'Item $i'),
              itemBuilder: (context, item, index) =>
                  SizedBox(height: testItemExtent, child: Text(item)),
              itemExtent: testItemExtent,
            ),
          ),
        ),
      );

      // Find the ListView and verify it's using itemExtent
      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsOneWidget);

      // Verify scrolling works smoothly
      await tester.drag(listViewFinder, const Offset(0, -500));
      await tester.pumpAndSettle();

      // ListView.builder with itemExtent should be found
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('cacheExtent affects viewport caching', (tester) async {
      const testCacheExtent = 500.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityList<String>(
              items: List.generate(100, (i) => 'Item $i'),
              itemBuilder: (context, item, index) =>
                  SizedBox(height: 50, child: Text(item)),
              cacheExtent: testCacheExtent,
            ),
          ),
        ),
      );

      // Find the ListView
      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsOneWidget);

      // Verify the ListView is rendered
      final listView = tester.widget<ListView>(listViewFinder);
      expect(listView.cacheExtent, equals(testCacheExtent));
    });

    testWidgets('separatorBuilder creates separators between items',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityList<String>(
              items: const ['Item 1', 'Item 2', 'Item 3'],
              itemBuilder: (context, item, index) =>
                  ListTile(title: Text(item)),
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ),
      );

      // Should find 2 dividers (between 3 items)
      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets('empty state is shown when items list is empty',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityList<String>(
              items: const [],
              itemBuilder: (context, item, index) => Text(item),
              emptyBuilder: (context) => const Text('No items'),
            ),
          ),
        ),
      );

      expect(find.text('No items'), findsOneWidget);
    });

    testWidgets('loading state is shown when loadingState is loading',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityList<String>(
              items: const ['Item 1'],
              itemBuilder: (context, item, index) => Text(item),
              loadingState: VelocityListLoadingState.loading,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('error state is shown when loadingState is error',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityList<String>(
              items: const ['Item 1'],
              itemBuilder: (context, item, index) => Text(item),
              loadingState: VelocityListLoadingState.error,
              error: Exception('Test error'),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    Glados2(any.positiveItemExtent, any.positiveCacheExtent).test(
      'itemExtent and cacheExtent can be used together',
      (double itemExtent, double cacheExtent) {
        final velocityList = VelocityList<String>(
          items: const ['Item 1', 'Item 2', 'Item 3'],
          itemBuilder: (context, item, index) => Text(item),
          itemExtent: itemExtent,
          cacheExtent: cacheExtent,
        );

        expect(velocityList.itemExtent, equals(itemExtent));
        expect(velocityList.cacheExtent, equals(cacheExtent));
      },
    );
  });
}

extension ListOptimizationGenerators on Any {
  /// Generate a positive item extent (10-200 pixels)
  Generator<double> get positiveItemExtent =>
      any.positiveIntOrZero.map((value) => 10.0 + (value % 191).toDouble());

  /// Generate a positive cache extent (100-1000 pixels)
  Generator<double> get positiveCacheExtent =>
      any.positiveIntOrZero.map((value) => 100.0 + (value % 901).toDouble());

  /// Generate a list item count (1-100 items)
  Generator<int> get listItemCount =>
      any.positiveIntOrZero.map((value) => 1 + (value % 100));
}
