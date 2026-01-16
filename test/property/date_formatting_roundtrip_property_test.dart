/// Property-based tests for Date Formatting Round-Trip
///
/// **Property 12: Date Formatting Round-Trip**
/// **Validates: Requirements 3.2**
///
/// For any DateTime value and format pattern, formatting then parsing
/// SHALL produce an equivalent DateTime (within the precision of the format).
library date_formatting_roundtrip_property_test;

import 'package:glados/glados.dart';
import 'package:velocity_ui/src/utils/date/date_utils.dart';

void main() {
  group('Property 12: Date Formatting Round-Trip', () {
    // Feature: flutter-project-refactoring, Property 12: Date Formatting Round-Trip
    // Validates: Requirements 3.2

    Glados(any.localDateTime).test(
      'format then parse with yyyy-MM-dd HH:mm:ss produces equivalent DateTime',
      (DateTime dateTime) {
        const pattern = 'yyyy-MM-dd HH:mm:ss';

        final formatted = VelocityDateUtils.format(dateTime, pattern);
        final parsed = VelocityDateUtils.parse(formatted, pattern);

        expect(parsed, isNotNull);
        expect(parsed!.year, equals(dateTime.year));
        expect(parsed.month, equals(dateTime.month));
        expect(parsed.day, equals(dateTime.day));
        expect(parsed.hour, equals(dateTime.hour));
        expect(parsed.minute, equals(dateTime.minute));
        expect(parsed.second, equals(dateTime.second));
      },
    );

    Glados(any.localDateTime).test(
      'format then parse with yyyy-MM-dd produces equivalent date',
      (DateTime dateTime) {
        const pattern = 'yyyy-MM-dd';

        final formatted = VelocityDateUtils.format(dateTime, pattern);
        final parsed = VelocityDateUtils.parse(formatted, pattern);

        expect(parsed, isNotNull);
        expect(parsed!.year, equals(dateTime.year));
        expect(parsed.month, equals(dateTime.month));
        expect(parsed.day, equals(dateTime.day));
      },
    );

    Glados(any.localDateTime).test(
      'format then parse with HH:mm:ss produces equivalent time',
      (DateTime dateTime) {
        const pattern = 'HH:mm:ss';

        final formatted = VelocityDateUtils.format(dateTime, pattern);
        final parsed = VelocityDateUtils.parse(formatted, pattern);

        expect(parsed, isNotNull);
        expect(parsed!.hour, equals(dateTime.hour));
        expect(parsed.minute, equals(dateTime.minute));
        expect(parsed.second, equals(dateTime.second));
      },
    );

    Glados(any.localDateTime).test(
      'format then parse with yyyy-MM-dd HH:mm:ss.SSS preserves milliseconds',
      (DateTime dateTime) {
        const pattern = 'yyyy-MM-dd HH:mm:ss.SSS';

        final formatted = VelocityDateUtils.format(dateTime, pattern);
        final parsed = VelocityDateUtils.parse(formatted, pattern);

        expect(parsed, isNotNull);
        expect(parsed!.year, equals(dateTime.year));
        expect(parsed.month, equals(dateTime.month));
        expect(parsed.day, equals(dateTime.day));
        expect(parsed.hour, equals(dateTime.hour));
        expect(parsed.minute, equals(dateTime.minute));
        expect(parsed.second, equals(dateTime.second));
        expect(parsed.millisecond, equals(dateTime.millisecond));
      },
    );

    Glados(any.localDateTime).test(
      'isSameDay is reflexive - any date is same day as itself',
      (DateTime dateTime) {
        expect(VelocityDateUtils.isSameDay(dateTime, dateTime), isTrue);
      },
    );

    Glados2(any.localDateTime, any.localDateTime).test(
      'isSameDay is symmetric',
      (DateTime a, DateTime b) {
        expect(
          VelocityDateUtils.isSameDay(a, b),
          equals(VelocityDateUtils.isSameDay(b, a)),
        );
      },
    );

    Glados2(any.localDateTime, any.localDateTime).test(
      'difference is antisymmetric',
      (DateTime from, DateTime to) {
        final diff1 = VelocityDateUtils.difference(from, to);
        final diff2 = VelocityDateUtils.difference(to, from);

        expect(diff1.inMicroseconds, equals(-diff2.inMicroseconds));
      },
    );

    Glados(any.localDateTime).test(
      'difference from self is zero',
      (DateTime dateTime) {
        final diff = VelocityDateUtils.difference(dateTime, dateTime);
        expect(diff, equals(Duration.zero));
      },
    );
  });
}

/// Custom generators for DateTime property tests
extension DateTimeGenerators on Any {
  /// Generate a random local DateTime within a reasonable range
  /// This avoids timezone issues by creating local DateTimes directly
  Generator<DateTime> get localDateTime {
    // Use nested flatMap to combine multiple generators
    return any.intInRange(1970, 2100).bind((year) {
      return any.intInRange(1, 12).bind((month) {
        return any.intInRange(1, 28).bind((day) {
          return any.intInRange(0, 23).bind((hour) {
            return any.intInRange(0, 59).bind((minute) {
              return any.intInRange(0, 59).bind((second) {
                return any.intInRange(0, 999).map((millisecond) {
                  return DateTime(
                    year,
                    month,
                    day,
                    hour,
                    minute,
                    second,
                    millisecond,
                  );
                });
              });
            });
          });
        });
      });
    });
  }
}
