import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/utils/string/string_utils.dart';

void main() {
  group('StringUtils', () {
    group('isBlank / isNotBlank', () {
      test('isBlank returns true for null', () {
        expect(StringUtils.isBlank(null), isTrue);
      });

      test('isBlank returns true for empty string', () {
        expect(StringUtils.isBlank(''), isTrue);
      });

      test('isBlank returns true for whitespace only', () {
        expect(StringUtils.isBlank('   '), isTrue);
        expect(StringUtils.isBlank('\t\n'), isTrue);
      });

      test('isBlank returns false for non-empty string', () {
        expect(StringUtils.isBlank('hello'), isFalse);
        expect(StringUtils.isBlank(' hello '), isFalse);
      });

      test('isNotBlank is inverse of isBlank', () {
        expect(StringUtils.isNotBlank(null), isFalse);
        expect(StringUtils.isNotBlank(''), isFalse);
        expect(StringUtils.isNotBlank('hello'), isTrue);
      });
    });

    group('capitalize / uncapitalize', () {
      test('capitalize makes first letter uppercase', () {
        expect(StringUtils.capitalize('hello'), equals('Hello'));
        expect(StringUtils.capitalize('HELLO'), equals('HELLO'));
        expect(StringUtils.capitalize(''), equals(''));
      });

      test('uncapitalize makes first letter lowercase', () {
        expect(StringUtils.uncapitalize('Hello'), equals('hello'));
        expect(StringUtils.uncapitalize('HELLO'), equals('hELLO'));
        expect(StringUtils.uncapitalize(''), equals(''));
      });

      test('toTitleCase capitalizes each word', () {
        expect(StringUtils.toTitleCase('hello world'), equals('Hello World'));
        expect(StringUtils.toTitleCase('HELLO WORLD'), equals('Hello World'));
      });
    });

    group('camelToSnake / snakeToCamel', () {
      test('camelToSnake converts camelCase to snake_case', () {
        expect(StringUtils.camelToSnake('helloWorld'), equals('hello_world'));
        expect(StringUtils.camelToSnake('HelloWorld'), equals('hello_world'));
        expect(StringUtils.camelToSnake('helloWorldTest'),
            equals('hello_world_test'));
      });

      test('camelToSnake handles consecutive uppercase letters', () {
        expect(StringUtils.camelToSnake('HTTPClient'), equals('http_client'));
        expect(StringUtils.camelToSnake('XMLParser'), equals('xml_parser'));
      });

      test('snakeToCamel converts snake_case to camelCase', () {
        expect(StringUtils.snakeToCamel('hello_world'), equals('helloWorld'));
        expect(StringUtils.snakeToCamel('http_client'), equals('httpClient'));
      });

      test('snakeToCamel with upperFirst creates PascalCase', () {
        expect(StringUtils.snakeToCamel('hello_world', true),
            equals('HelloWorld'));
      });

      test('camelToKebab converts camelCase to kebab-case', () {
        expect(StringUtils.camelToKebab('helloWorld'), equals('hello-world'));
      });

      test('kebabToCamel converts kebab-case to camelCase', () {
        expect(StringUtils.kebabToCamel('hello-world'), equals('helloWorld'));
      });
    });

    group('truncate', () {
      test('truncate shortens string with suffix', () {
        expect(StringUtils.truncate('Hello World', 8), equals('Hello...'));
      });

      test('truncate returns original if shorter than maxLength', () {
        expect(StringUtils.truncate('Hello', 10), equals('Hello'));
      });

      test('truncate with custom suffix', () {
        expect(StringUtils.truncate('Hello World', 8, suffix: '…'),
            equals('Hello W…'));
      });

      test('truncateMiddle truncates from middle', () {
        expect(StringUtils.truncateMiddle('Hello World Test', 11),
            equals('Hell...Test'));
      });
    });

    group('md5', () {
      test('md5 produces correct hash for "hello"', () {
        expect(StringUtils.md5('hello'),
            equals('5d41402abc4b2a76b9719d911017c592'));
      });

      test('md5 produces correct hash for empty string', () {
        expect(StringUtils.md5(''), equals('d41d8cd98f00b204e9800998ecf8427e'));
      });

      test('md5 produces correct hash for "The quick brown fox"', () {
        expect(StringUtils.md5('The quick brown fox jumps over the lazy dog'),
            equals('9e107d9d372bb6826bd81d3542a419d6'));
      });
    });

    group('base64Encode / base64Decode', () {
      test('base64Encode encodes string correctly', () {
        expect(StringUtils.base64Encode('hello'), equals('aGVsbG8='));
        expect(StringUtils.base64Encode(''), equals(''));
      });

      test('base64Decode decodes string correctly', () {
        expect(StringUtils.base64Decode('aGVsbG8='), equals('hello'));
        expect(StringUtils.base64Decode(''), equals(''));
      });

      test('base64 round-trip preserves original string', () {
        const original = 'Hello, World! 你好世界';
        final encoded = StringUtils.base64Encode(original);
        final decoded = StringUtils.base64Decode(encoded);
        expect(decoded, equals(original));
      });

      test('tryBase64Decode returns null for invalid input', () {
        expect(StringUtils.tryBase64Decode('invalid!!!'), isNull);
      });

      test('tryBase64Decode returns decoded string for valid input', () {
        expect(StringUtils.tryBase64Decode('aGVsbG8='), equals('hello'));
      });
    });

    group('matches / extractMatches', () {
      test('matches returns true for matching pattern', () {
        expect(StringUtils.matches('hello123', r'^[a-z]+\d+$'), isTrue);
      });

      test('matches returns false for non-matching pattern', () {
        expect(StringUtils.matches('hello', r'^\d+$'), isFalse);
      });

      test('matchesFully checks entire string', () {
        expect(StringUtils.matchesFully('hello', r'[a-z]+'), isTrue);
        expect(StringUtils.matchesFully('hello123', r'[a-z]+'), isFalse);
      });

      test('extractMatches returns all matches', () {
        expect(StringUtils.extractMatches('a1b2c3', r'\d'),
            equals(['1', '2', '3']));
        expect(StringUtils.extractMatches('hello', r'\d'), isEmpty);
      });

      test('extractFirst returns first match', () {
        expect(StringUtils.extractFirst('a1b2c3', r'\d'), equals('1'));
        expect(StringUtils.extractFirst('hello', r'\d'), isNull);
      });

      test('extractGroups returns captured groups', () {
        expect(StringUtils.extractGroups('John:30', r'(\w+):(\d+)'),
            equals(['John', '30']));
      });
    });

    group('utility methods', () {
      test('reverse reverses string', () {
        expect(StringUtils.reverse('hello'), equals('olleh'));
        expect(StringUtils.reverse(''), equals(''));
      });

      test('repeat repeats string', () {
        expect(StringUtils.repeat('ab', 3), equals('ababab'));
        expect(StringUtils.repeat('ab', 0), equals(''));
      });

      test('padLeft pads string on left', () {
        expect(StringUtils.padLeft('5', 3, '0'), equals('005'));
      });

      test('padRight pads string on right', () {
        expect(StringUtils.padRight('5', 3, '0'), equals('500'));
      });

      test('strip removes specified characters from both ends', () {
        expect(StringUtils.strip('##hello##', '#'), equals('hello'));
      });

      test('countOccurrences counts substring occurrences', () {
        expect(StringUtils.countOccurrences('hello hello', 'hello'), equals(2));
        expect(StringUtils.countOccurrences('hello', 'x'), equals(0));
      });
    });
  });
}
