/// Property-based tests for size enum consistency
///
/// **Property 7: Size Enum Consistency**
/// **Validates: Requirements 5.3**
///
/// *For any* component that uses size enums, the enum SHALL contain exactly
/// the values `small`, `medium`, and `large`, and the visual output SHALL be
/// ordered such that small < medium < large in terms of dimensions.
library size_enum_consistency_property_test;

import 'package:glados/glados.dart';
import 'package:velocity_ui/src/core/types/component_size.dart';

void main() {
  group('Property 7: Size Enum Consistency', () {
    // Feature: velocity-ui-optimization, Property 7: Size Enum Consistency
    // Validates: Requirements 5.3

    test('VelocitySize enum contains exactly small, medium, large', () {
      // Verify the enum has exactly 3 values
      expect(VelocitySize.values.length, equals(3));

      // Verify the values are small, medium, large
      expect(VelocitySize.values, contains(VelocitySize.small));
      expect(VelocitySize.values, contains(VelocitySize.medium));
      expect(VelocitySize.values, contains(VelocitySize.large));
    });

    test('VelocitySize enum values are ordered small < medium < large', () {
      // Verify the index ordering
      expect(VelocitySize.small.index, lessThan(VelocitySize.medium.index));
      expect(VelocitySize.medium.index, lessThan(VelocitySize.large.index));
    });

    test('VelocityExtendedSize enum contains xs, small, medium, large, xl', () {
      // Verify the enum has exactly 5 values
      expect(VelocityExtendedSize.values.length, equals(5));

      // Verify the values
      expect(VelocityExtendedSize.values, contains(VelocityExtendedSize.xs));
      expect(VelocityExtendedSize.values, contains(VelocityExtendedSize.small));
      expect(
          VelocityExtendedSize.values, contains(VelocityExtendedSize.medium));
      expect(VelocityExtendedSize.values, contains(VelocityExtendedSize.large));
      expect(VelocityExtendedSize.values, contains(VelocityExtendedSize.xl));
    });

    test(
        'VelocityExtendedSize enum values are ordered xs < small < medium < large < xl',
        () {
      // Verify the index ordering
      expect(VelocityExtendedSize.xs.index,
          lessThan(VelocityExtendedSize.small.index));
      expect(VelocityExtendedSize.small.index,
          lessThan(VelocityExtendedSize.medium.index));
      expect(VelocityExtendedSize.medium.index,
          lessThan(VelocityExtendedSize.large.index));
      expect(VelocityExtendedSize.large.index,
          lessThan(VelocityExtendedSize.xl.index));
    });

    // Property test: For any two sizes, comparison should be consistent
    Glados2(any.always(VelocitySize.values), any.always(VelocitySize.values))
        .test(
      'size comparison is consistent with index ordering',
      (List<VelocitySize> sizes1, List<VelocitySize> sizes2) {
        for (final size1 in sizes1) {
          for (final size2 in sizes2) {
            final comparison = VelocitySizeUtils.compare(size1, size2);
            if (size1.index < size2.index) {
              expect(comparison, lessThan(0),
                  reason: '$size1 should be less than $size2');
            } else if (size1.index > size2.index) {
              expect(comparison, greaterThan(0),
                  reason: '$size1 should be greater than $size2');
            } else {
              expect(comparison, equals(0),
                  reason: '$size1 should equal $size2');
            }
          }
        }
      },
    );

    // Property test: isSmaller and isLarger are consistent
    Glados(any.choose(VelocitySize.values)).test(
      'isSmaller and isLarger are mutually exclusive for different sizes',
      (VelocitySize size) {
        for (final otherSize in VelocitySize.values) {
          if (size != otherSize) {
            final isSmaller = VelocitySizeUtils.isSmaller(size, otherSize);
            final isLarger = VelocitySizeUtils.isLarger(size, otherSize);

            // They should be mutually exclusive
            expect(isSmaller != isLarger, isTrue,
                reason:
                    'isSmaller and isLarger should be mutually exclusive for $size vs $otherSize');
          }
        }
      },
    );

    // Property test: toBaseSize and toExtendedSize are consistent
    Glados(any.choose(VelocitySize.values)).test(
      'toExtendedSize preserves size semantics',
      (VelocitySize baseSize) {
        final extendedSize = VelocitySizeUtils.toExtendedSize(baseSize);

        // Verify the mapping is correct
        switch (baseSize) {
          case VelocitySize.small:
            expect(extendedSize, equals(VelocityExtendedSize.small));
            break;
          case VelocitySize.medium:
            expect(extendedSize, equals(VelocityExtendedSize.medium));
            break;
          case VelocitySize.large:
            expect(extendedSize, equals(VelocityExtendedSize.large));
            break;
        }
      },
    );

    // Property test: toBaseSize maps extended sizes correctly
    Glados(any.choose(VelocityExtendedSize.values)).test(
      'toBaseSize maps extended sizes to base sizes correctly',
      (VelocityExtendedSize extendedSize) {
        final baseSize = VelocitySizeUtils.toBaseSize(extendedSize);

        // Verify the mapping is correct
        switch (extendedSize) {
          case VelocityExtendedSize.xs:
          case VelocityExtendedSize.small:
            expect(baseSize, equals(VelocitySize.small));
            break;
          case VelocityExtendedSize.medium:
            expect(baseSize, equals(VelocitySize.medium));
            break;
          case VelocityExtendedSize.large:
          case VelocityExtendedSize.xl:
            expect(baseSize, equals(VelocitySize.large));
            break;
        }
      },
    );

    // Property test: Extended size comparison is consistent
    Glados(any.choose(VelocityExtendedSize.values)).test(
      'extended size comparison is consistent with index ordering',
      (VelocityExtendedSize size1) {
        for (final size2 in VelocityExtendedSize.values) {
          final comparison = VelocitySizeUtils.compareExtended(size1, size2);
          if (size1.index < size2.index) {
            expect(comparison, lessThan(0),
                reason: '$size1 should be less than $size2');
          } else if (size1.index > size2.index) {
            expect(comparison, greaterThan(0),
                reason: '$size1 should be greater than $size2');
          } else {
            expect(comparison, equals(0), reason: '$size1 should equal $size2');
          }
        }
      },
    );
  });
}
