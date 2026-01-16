/// Property-based tests for String Encoding Round-Trip
///
/// **Property 14: String Encoding Round-Trip**
/// **Validates: Requirements 3.6**
///
/// For any string value, Base64 encoding then decoding SHALL produce
/// the original string.
library string_encoding_roundtrip_property_test;

import 'package:glados/glados.dart';
import 'package:velocity_ui/src/utils/string/string_utils.dart';

void main() {
  group('Property 14: String Encoding Round-Trip', () {
    // Feature: flutter-project-refactoring, Property 14: String Encoding Round-Trip
    // Validates: Requirements 3.6

    Glados(any.nonEmptyLowercaseString).test(
      'Base64 encode then decode produces original string',
      (String original) {
        final encoded = StringUtils.base64Encode(original);
        final decoded = StringUtils.base64Decode(encoded);

        expect(decoded, equals(original));
      },
    );

    Glados(any.asciiString).test(
      'Base64 encode then decode preserves ASCII strings',
      (String original) {
        final encoded = StringUtils.base64Encode(original);
        final decoded = StringUtils.base64Decode(encoded);

        expect(decoded, equals(original));
      },
    );

    Glados(any.unicodeString).test(
      'Base64 encode then decode preserves Unicode strings',
      (String original) {
        final encoded = StringUtils.base64Encode(original);
        final decoded = StringUtils.base64Decode(encoded);

        expect(decoded, equals(original));
      },
    );

    Glados(any.nonEmptyLowercaseString).test(
      'tryBase64Decode returns same result as base64Decode for valid input',
      (String original) {
        final encoded = StringUtils.base64Encode(original);
        final decoded = StringUtils.base64Decode(encoded);
        final tryDecoded = StringUtils.tryBase64Decode(encoded);

        expect(tryDecoded, equals(decoded));
      },
    );

    // Additional string utility properties

    Glados(any.nonEmptyLowercaseString).test(
      'camelToSnake then snakeToCamel produces equivalent string for simple lowercase',
      (String input) {
        // For simple lowercase strings (no underscores), the round-trip should work
        final camelInput = input.toLowerCase();
        if (camelInput.isEmpty) return;

        final snake = StringUtils.camelToSnake(camelInput);
        final backToCamel = StringUtils.snakeToCamel(snake);

        expect(backToCamel, equals(camelInput));
      },
    );

    Glados(any.nonEmptyLowercaseString).test(
      'isBlank and isNotBlank are complementary',
      (String input) {
        expect(
          StringUtils.isBlank(input),
          equals(!StringUtils.isNotBlank(input)),
        );
      },
    );

    Glados(any.nonEmptyLowercaseString).test(
      'isEmpty and isNotEmpty are complementary',
      (String input) {
        expect(
          StringUtils.isEmpty(input),
          equals(!StringUtils.isNotEmpty(input)),
        );
      },
    );

    Glados(any.nonEmptyLowercaseString).test(
      'reverse applied twice produces original string',
      (String input) {
        final reversed = StringUtils.reverse(input);
        final doubleReversed = StringUtils.reverse(reversed);

        expect(doubleReversed, equals(input));
      },
    );

    Glados2(any.nonEmptyLowercaseString, any.positiveIntOrZero).test(
      'truncate produces string of at most maxLength',
      (String input, int maxLengthRaw) {
        final maxLength = (maxLengthRaw % 100) + 1; // Keep reasonable
        final truncated = StringUtils.truncate(input, maxLength);

        expect(truncated.length, lessThanOrEqualTo(maxLength));
      },
    );

    Glados(any.nonEmptyLowercaseString).test(
      'capitalize preserves string length',
      (String input) {
        final capitalized = StringUtils.capitalize(input);

        expect(capitalized.length, equals(input.length));
      },
    );

    Glados(any.nonEmptyLowercaseString).test(
      'uncapitalize preserves string length',
      (String input) {
        final uncapitalized = StringUtils.uncapitalize(input);

        expect(uncapitalized.length, equals(input.length));
      },
    );

    Glados(any.nonEmptyLowercaseString).test(
      'md5 produces 32-character hex string',
      (String input) {
        final hash = StringUtils.md5(input);

        expect(hash.length, equals(32));
        expect(hash, matches(RegExp(r'^[0-9a-f]{32}$')));
      },
    );

    Glados(any.nonEmptyLowercaseString).test(
      'md5 is deterministic - same input produces same hash',
      (String input) {
        final hash1 = StringUtils.md5(input);
        final hash2 = StringUtils.md5(input);

        expect(hash1, equals(hash2));
      },
    );
  });
}

/// Custom generators for String property tests
extension StringGenerators on Any {
  /// Generate a non-empty string of lowercase letters
  Generator<String> get nonEmptyLowercaseString {
    return lowercaseLetters.map((s) => s.isEmpty ? 'a' : s);
  }

  /// Generate an ASCII string (printable characters)
  Generator<String> get asciiString {
    return list(intInRange(32, 126)).map((codes) {
      return String.fromCharCodes(codes);
    });
  }

  /// Generate a Unicode string including non-ASCII characters
  Generator<String> get unicodeString {
    return list(intInRange(32, 1000)).map((codes) {
      // Filter out surrogate pairs to avoid invalid UTF-16
      final validCodes = codes.where((c) => c < 0xD800 || c > 0xDFFF).toList();
      return String.fromCharCodes(validCodes);
    });
  }
}
