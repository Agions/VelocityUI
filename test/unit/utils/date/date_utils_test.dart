import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/utils/date/date_utils.dart';

void main() {
  group('VelocityDateUtils', () {
    group('format', () {
      test('formats date with default pattern', () {
        final dateTime = DateTime(2024, 1, 15, 14, 30, 45);
        final formatted = VelocityDateUtils.format(dateTime);
        expect(formatted, equals('2024-01-15 14:30:45'));
      });

      test('formats date with custom pattern', () {
        final dateTime = DateTime(2024, 1, 15, 14, 30, 45);
        final formatted = VelocityDateUtils.format(dateTime, 'yyyy-MM-dd');
        expect(formatted, equals('2024-01-15'));
      });

      test('formats time with HH:mm:ss pattern', () {
        final dateTime = DateTime(2024, 1, 15, 14, 30, 45);
        final formatted = VelocityDateUtils.format(dateTime, 'HH:mm:ss');
        expect(formatted, equals('14:30:45'));
      });

      test('formats with two-digit year', () {
        final dateTime = DateTime(2024, 1, 15);
        final formatted = VelocityDateUtils.format(dateTime, 'yy-MM-dd');
        expect(formatted, equals('24-01-15'));
      });

      test('formats with single-digit month and day', () {
        final dateTime = DateTime(2024, 1, 5);
        final formatted = VelocityDateUtils.format(dateTime, 'yyyy-M-d');
        expect(formatted, equals('2024-1-5'));
      });

      test('formats with milliseconds', () {
        final dateTime = DateTime(2024, 1, 15, 14, 30, 45, 123);
        final formatted = VelocityDateUtils.format(dateTime, 'HH:mm:ss.SSS');
        expect(formatted, equals('14:30:45.123'));
      });
    });

    group('parse', () {
      test('parses date string with default pattern', () {
        final parsed = VelocityDateUtils.parse('2024-01-15 14:30:45');
        expect(parsed, isNotNull);
        expect(parsed!.year, equals(2024));
        expect(parsed.month, equals(1));
        expect(parsed.day, equals(15));
        expect(parsed.hour, equals(14));
        expect(parsed.minute, equals(30));
        expect(parsed.second, equals(45));
      });

      test('parses date string with custom pattern', () {
        final parsed = VelocityDateUtils.parse('2024-01-15', 'yyyy-MM-dd');
        expect(parsed, isNotNull);
        expect(parsed!.year, equals(2024));
        expect(parsed.month, equals(1));
        expect(parsed.day, equals(15));
      });

      test('returns null for invalid date string', () {
        final parsed = VelocityDateUtils.parse('invalid', 'yyyy-MM-dd');
        expect(parsed, isNull);
      });

      test('parses time string', () {
        final parsed = VelocityDateUtils.parse('14:30:45', 'HH:mm:ss');
        expect(parsed, isNotNull);
        expect(parsed!.hour, equals(14));
        expect(parsed.minute, equals(30));
        expect(parsed.second, equals(45));
      });
    });

    group('difference', () {
      test('calculates difference between two dates', () {
        final from = DateTime(2024, 1, 15);
        final to = DateTime(2024, 1, 20);
        final diff = VelocityDateUtils.difference(from, to);
        expect(diff.inDays, equals(5));
      });

      test('calculates negative difference', () {
        final from = DateTime(2024, 1, 20);
        final to = DateTime(2024, 1, 15);
        final diff = VelocityDateUtils.difference(from, to);
        expect(diff.inDays, equals(-5));
      });

      test('calculates difference in hours', () {
        final from = DateTime(2024, 1, 15, 10, 0);
        final to = DateTime(2024, 1, 15, 14, 0);
        final diff = VelocityDateUtils.difference(from, to);
        expect(diff.inHours, equals(4));
      });

      test('calculates difference in minutes', () {
        final from = DateTime(2024, 1, 15, 10, 0);
        final to = DateTime(2024, 1, 15, 10, 30);
        final diff = VelocityDateUtils.difference(from, to);
        expect(diff.inMinutes, equals(30));
      });
    });

    group('isSameDay', () {
      test('returns true for same day', () {
        final date1 = DateTime(2024, 1, 15, 10, 0);
        final date2 = DateTime(2024, 1, 15, 14, 0);
        expect(VelocityDateUtils.isSameDay(date1, date2), isTrue);
      });

      test('returns false for different days', () {
        final date1 = DateTime(2024, 1, 15);
        final date2 = DateTime(2024, 1, 16);
        expect(VelocityDateUtils.isSameDay(date1, date2), isFalse);
      });

      test('returns false for different months', () {
        final date1 = DateTime(2024, 1, 15);
        final date2 = DateTime(2024, 2, 15);
        expect(VelocityDateUtils.isSameDay(date1, date2), isFalse);
      });

      test('returns false for different years', () {
        final date1 = DateTime(2024, 1, 15);
        final date2 = DateTime(2025, 1, 15);
        expect(VelocityDateUtils.isSameDay(date1, date2), isFalse);
      });
    });

    group('isSameMonth', () {
      test('returns true for same month', () {
        final date1 = DateTime(2024, 1, 15);
        final date2 = DateTime(2024, 1, 20);
        expect(VelocityDateUtils.isSameMonth(date1, date2), isTrue);
      });

      test('returns false for different months', () {
        final date1 = DateTime(2024, 1, 15);
        final date2 = DateTime(2024, 2, 15);
        expect(VelocityDateUtils.isSameMonth(date1, date2), isFalse);
      });
    });

    group('isSameYear', () {
      test('returns true for same year', () {
        final date1 = DateTime(2024, 1, 15);
        final date2 = DateTime(2024, 12, 20);
        expect(VelocityDateUtils.isSameYear(date1, date2), isTrue);
      });

      test('returns false for different years', () {
        final date1 = DateTime(2024, 1, 15);
        final date2 = DateTime(2025, 1, 15);
        expect(VelocityDateUtils.isSameYear(date1, date2), isFalse);
      });
    });

    group('firstDayOfMonth', () {
      test('returns first day of month', () {
        final dateTime = DateTime(2024, 1, 15);
        final firstDay = VelocityDateUtils.firstDayOfMonth(dateTime);
        expect(firstDay.day, equals(1));
        expect(firstDay.month, equals(1));
        expect(firstDay.year, equals(2024));
      });
    });

    group('lastDayOfMonth', () {
      test('returns last day of month', () {
        final dateTime = DateTime(2024, 1, 15);
        final lastDay = VelocityDateUtils.lastDayOfMonth(dateTime);
        expect(lastDay.day, equals(31));
        expect(lastDay.month, equals(1));
      });

      test('handles February in leap year', () {
        final dateTime = DateTime(2024, 2, 15);
        final lastDay = VelocityDateUtils.lastDayOfMonth(dateTime);
        expect(lastDay.day, equals(29));
      });
    });

    group('addDays', () {
      test('adds days to date', () {
        final dateTime = DateTime(2024, 1, 15);
        final result = VelocityDateUtils.addDays(dateTime, 5);
        expect(result.day, equals(20));
      });

      test('subtracts days from date', () {
        final dateTime = DateTime(2024, 1, 15);
        final result = VelocityDateUtils.addDays(dateTime, -5);
        expect(result.day, equals(10));
      });
    });

    group('addMonths', () {
      test('adds months to date', () {
        final dateTime = DateTime(2024, 1, 15);
        final result = VelocityDateUtils.addMonths(dateTime, 3);
        expect(result.month, equals(4));
      });

      test('handles year overflow', () {
        final dateTime = DateTime(2024, 11, 15);
        final result = VelocityDateUtils.addMonths(dateTime, 3);
        expect(result.year, equals(2025));
        expect(result.month, equals(2));
      });
    });

    group('addYears', () {
      test('adds years to date', () {
        final dateTime = DateTime(2024, 1, 15);
        final result = VelocityDateUtils.addYears(dateTime, 2);
        expect(result.year, equals(2026));
      });
    });
  });
}
