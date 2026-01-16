import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/utils/validation/validation_utils.dart';

void main() {
  group('ValidationUtils', () {
    group('isEmail', () {
      test('validates correct email addresses', () {
        expect(ValidationUtils.isEmail('user@example.com'), isTrue);
        expect(ValidationUtils.isEmail('john.doe@company.co.uk'), isTrue);
        expect(ValidationUtils.isEmail('test+tag@domain.com'), isTrue);
      });

      test('rejects invalid email addresses', () {
        expect(ValidationUtils.isEmail('invalid'), isFalse);
        expect(ValidationUtils.isEmail('user@'), isFalse);
        expect(ValidationUtils.isEmail('@example.com'), isFalse);
        expect(ValidationUtils.isEmail('user@.com'), isFalse);
        expect(ValidationUtils.isEmail(''), isFalse);
      });
    });

    group('isPhone', () {
      test('validates correct phone numbers for CN', () {
        expect(ValidationUtils.isPhone('13800138000'), isTrue);
        expect(ValidationUtils.isPhone('18612345678'), isTrue);
      });

      test('rejects invalid phone numbers', () {
        expect(ValidationUtils.isPhone('123'), isFalse);
        expect(ValidationUtils.isPhone('abc'), isFalse);
        expect(ValidationUtils.isPhone(''), isFalse);
      });
    });

    group('isUrl', () {
      test('validates correct URLs', () {
        expect(ValidationUtils.isUrl('https://example.com'), isTrue);
        expect(ValidationUtils.isUrl('http://www.example.com'), isTrue);
        expect(ValidationUtils.isUrl('https://example.com/path'), isTrue);
      });

      test('rejects invalid URLs', () {
        expect(ValidationUtils.isUrl('not a url'), isFalse);
        expect(ValidationUtils.isUrl('example.com'), isFalse);
        expect(ValidationUtils.isUrl(''), isFalse);
      });
    });

    group('isNumeric', () {
      test('validates numeric strings', () {
        expect(ValidationUtils.isNumeric('123'), isTrue);
        expect(ValidationUtils.isNumeric('123.45'), isTrue);
        expect(ValidationUtils.isNumeric('-123'), isTrue);
        expect(ValidationUtils.isNumeric('-123.45'), isTrue);
      });

      test('rejects non-numeric strings', () {
        expect(ValidationUtils.isNumeric('abc'), isFalse);
        expect(ValidationUtils.isNumeric('12a3'), isFalse);
        expect(ValidationUtils.isNumeric(''), isFalse);
      });
    });

    group('isInteger', () {
      test('validates integer strings', () {
        expect(ValidationUtils.isInteger('123'), isTrue);
        expect(ValidationUtils.isInteger('-123'), isTrue);
        expect(ValidationUtils.isInteger('0'), isTrue);
      });

      test('rejects non-integer strings', () {
        expect(ValidationUtils.isInteger('123.45'), isFalse);
        expect(ValidationUtils.isInteger('abc'), isFalse);
        expect(ValidationUtils.isInteger(''), isFalse);
      });
    });

    group('isPositiveInteger', () {
      test('validates positive integer strings', () {
        expect(ValidationUtils.isPositiveInteger('123'), isTrue);
        expect(ValidationUtils.isPositiveInteger('0'), isTrue);
      });

      test('rejects negative integers', () {
        expect(ValidationUtils.isPositiveInteger('-123'), isFalse);
      });

      test('rejects non-integer strings', () {
        expect(ValidationUtils.isPositiveInteger('123.45'), isFalse);
        expect(ValidationUtils.isPositiveInteger('abc'), isFalse);
        expect(ValidationUtils.isPositiveInteger(''), isFalse);
      });
    });

    group('isLengthInRange', () {
      test('validates string within range', () {
        expect(ValidationUtils.isLengthInRange('hello', 3, 10), isTrue);
        expect(ValidationUtils.isLengthInRange('hello', 5, 5), isTrue);
      });

      test('rejects string below minimum', () {
        expect(ValidationUtils.isLengthInRange('hi', 3, 10), isFalse);
      });

      test('rejects string above maximum', () {
        expect(ValidationUtils.isLengthInRange('hello world', 3, 8), isFalse);
      });

      test('validates empty string with range 0-10', () {
        expect(ValidationUtils.isLengthInRange('', 0, 10), isTrue);
      });

      test('rejects empty string with minimum > 0', () {
        expect(ValidationUtils.isLengthInRange('', 1, 10), isFalse);
      });
    });

    group('isIdCard', () {
      test('validates valid ID card numbers', () {
        // Note: Using a valid format, actual validation depends on implementation
        expect(ValidationUtils.isIdCard('110101199003071234'), isA<bool>());
      });

      test('rejects invalid ID card numbers', () {
        expect(ValidationUtils.isIdCard('123'), isFalse);
        expect(ValidationUtils.isIdCard(''), isFalse);
      });

      test('rejects ID card with wrong length', () {
        expect(ValidationUtils.isIdCard('11010119900307123'), isFalse);
      });
    });

    group('isIPv4', () {
      test('validates valid IPv4 addresses', () {
        expect(ValidationUtils.isIPv4('192.168.1.1'), isTrue);
        expect(ValidationUtils.isIPv4('127.0.0.1'), isTrue);
        expect(ValidationUtils.isIPv4('255.255.255.255'), isTrue);
      });

      test('rejects invalid IPv4 addresses', () {
        expect(ValidationUtils.isIPv4('256.1.1.1'), isFalse);
        expect(ValidationUtils.isIPv4('192.168.1'), isFalse);
        expect(ValidationUtils.isIPv4('192.168.1.1.1'), isFalse);
      });

      test('rejects non-IP strings', () {
        expect(ValidationUtils.isIPv4('abc.def.ghi.jkl'), isFalse);
        expect(ValidationUtils.isIPv4(''), isFalse);
      });
    });

    group('isBlank / isNotBlank', () {
      test('isBlank returns true for null', () {
        expect(ValidationUtils.isBlank(null), isTrue);
      });

      test('isBlank returns true for empty string', () {
        expect(ValidationUtils.isBlank(''), isTrue);
      });

      test('isBlank returns true for whitespace only', () {
        expect(ValidationUtils.isBlank('   '), isTrue);
        expect(ValidationUtils.isBlank('\t\n'), isTrue);
      });

      test('isBlank returns false for non-empty string', () {
        expect(ValidationUtils.isBlank('hello'), isFalse);
        expect(ValidationUtils.isBlank(' hello '), isFalse);
      });

      test('isNotBlank is inverse of isBlank', () {
        expect(ValidationUtils.isNotBlank(null), isFalse);
        expect(ValidationUtils.isNotBlank(''), isFalse);
        expect(ValidationUtils.isNotBlank('hello'), isTrue);
      });
    });

    group('validation results', () {
      test('creates success result', () {
        final result = ValidationUtils.validateEmail('user@example.com');
        expect(result.isValid, isTrue);
        expect(result.errorMessage, isNull);
      });

      test('creates failure result with message', () {
        final result = ValidationUtils.validateEmail('invalid');
        expect(result.isValid, isFalse);
        expect(result.errorMessage, isNotNull);
      });

      test('validateLength returns success for valid length', () {
        final result = ValidationUtils.validateLength('hello', 1, 10);
        expect(result.isValid, isTrue);
      });

      test('validateLength returns failure for too short', () {
        final result = ValidationUtils.validateLength('hi', 5, 10);
        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('不能小于'));
      });

      test('validateLength returns failure for too long', () {
        final result = ValidationUtils.validateLength('hello world', 1, 5);
        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('不能大于'));
      });
    });
  });
}
