import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/utils/json/json_utils.dart';

void main() {
  group('JsonUtils', () {
    group('encode', () {
      test('encodes simple map to JSON string', () {
        final map = {'name': 'John', 'age': 30};
        final encoded = JsonUtils.encode(map);
        expect(encoded, isA<String>());
        expect(encoded, contains('name'));
        expect(encoded, contains('John'));
      });

      test('encodes list to JSON string', () {
        final list = [1, 2, 3, 4, 5];
        final encoded = JsonUtils.encode(list);
        expect(encoded, isA<String>());
        expect(encoded, contains('1'));
      });

      test('encodes nested structures', () {
        final data = {
          'user': {
            'name': 'John',
            'address': {
              'city': 'New York',
              'zip': '10001',
            },
          },
          'items': [1, 2, 3],
        };
        final encoded = JsonUtils.encode(data);
        expect(encoded, isA<String>());
        expect(encoded, contains('John'));
        expect(encoded, contains('New York'));
      });

      test('encodes null value', () {
        final encoded = JsonUtils.encode(null);
        expect(encoded, equals('null'));
      });

      test('encodes boolean values', () {
        expect(JsonUtils.encode(true), contains('true'));
        expect(JsonUtils.encode(false), contains('false'));
      });

      test('encodes numeric values', () {
        expect(JsonUtils.encode(42), equals('42'));
        expect(JsonUtils.encode(3.14), equals('3.14'));
      });

      test('encodes string values', () {
        final encoded = JsonUtils.encode('hello');
        expect(encoded, equals('"hello"'));
      });
    });

    group('encodePretty', () {
      test('encodes with pretty formatting', () {
        final map = {'name': 'John', 'age': 30};
        final encoded = JsonUtils.encodePretty(map);
        expect(encoded, isA<String>());
        expect(encoded, contains('\n'));
      });

      test('uses custom indent', () {
        final map = {'name': 'John'};
        final encoded = JsonUtils.encodePretty(map, indent: 4);
        expect(encoded, isA<String>());
      });

      test('pretty format is readable', () {
        final data = {
          'user': {'name': 'John', 'age': 30},
          'items': [1, 2, 3],
        };
        final encoded = JsonUtils.encodePretty(data);
        expect(encoded, contains('\n'));
        expect(encoded, contains('  '));
      });
    });

    group('decode', () {
      test('decodes JSON string to map', () {
        final json = '{"name":"John","age":30}';
        final decoded = JsonUtils.decode(json);
        expect(decoded, isA<Map>());
        expect(decoded['name'], equals('John'));
        expect(decoded['age'], equals(30));
      });

      test('decodes JSON string to list', () {
        final json = '[1,2,3,4,5]';
        final decoded = JsonUtils.decode(json);
        expect(decoded, isA<List>());
        expect(decoded.length, equals(5));
      });

      test('decodes nested structures', () {
        final json = '{"user":{"name":"John","address":{"city":"New York"}}}';
        final decoded = JsonUtils.decode(json);
        expect(decoded['user']['name'], equals('John'));
        expect(decoded['user']['address']['city'], equals('New York'));
      });

      test('decodes null value', () {
        final decoded = JsonUtils.decode('null');
        expect(decoded, isNull);
      });

      test('decodes boolean values', () {
        expect(JsonUtils.decode('true'), isTrue);
        expect(JsonUtils.decode('false'), isFalse);
      });

      test('decodes numeric values', () {
        expect(JsonUtils.decode('42'), equals(42));
        expect(JsonUtils.decode('3.14'), equals(3.14));
      });

      test('decodes string values', () {
        final decoded = JsonUtils.decode('"hello"');
        expect(decoded, equals('hello'));
      });

      test('throws on invalid JSON', () {
        expect(
          () => JsonUtils.decode('invalid json'),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('tryDecode', () {
      test('decodes valid JSON', () {
        final json = '{"name":"John","age":30}';
        final decoded =
            JsonUtils.tryDecode(json, (data) => data as Map<String, dynamic>);
        expect(decoded, isNotNull);
        expect(decoded!['name'], equals('John'));
      });

      test('returns null for invalid JSON', () {
        final decoded = JsonUtils.tryDecode(
            'invalid', (data) => data as Map<String, dynamic>);
        expect(decoded, isNull);
      });

      test('applies custom decoder function', () {
        final json = '{"name":"John","age":30}';
        final decoded = JsonUtils.tryDecode(json, (data) {
          final map = data as Map<String, dynamic>;
          return {'fullName': map['name']};
        });
        expect(decoded, isNotNull);
        expect(decoded!['fullName'], equals('John'));
      });

      test('returns null if decoder throws', () {
        final json = '{"name":"John"}';
        final decoded = JsonUtils.tryDecode(json, (data) {
          throw Exception('Decoder error');
        });
        expect(decoded, isNull);
      });
    });

    group('deepMerge', () {
      test('merges two maps', () {
        final base = {'a': 1, 'b': 2};
        final override = {'b': 3, 'c': 4};
        final merged = JsonUtils.deepMerge(base, override);
        expect(merged['a'], equals(1));
        expect(merged['b'], equals(3));
        expect(merged['c'], equals(4));
      });

      test('deep merges nested maps', () {
        final base = {
          'user': {'name': 'John', 'age': 30},
          'settings': {'theme': 'dark'},
        };
        final override = {
          'user': {'age': 31},
          'settings': {'language': 'en'},
        };
        final merged = JsonUtils.deepMerge(base, override);
        expect(merged['user']['name'], equals('John'));
        expect(merged['user']['age'], equals(31));
        expect(merged['settings']['theme'], equals('dark'));
        expect(merged['settings']['language'], equals('en'));
      });

      test('override replaces non-map values', () {
        final base = {
          'a': 1,
          'b': {'x': 10}
        };
        final override = {'b': 2};
        final merged = JsonUtils.deepMerge(base, override);
        expect(merged['b'], equals(2));
      });

      test('preserves base values when override is empty', () {
        final base = {'a': 1, 'b': 2};
        final override = <String, dynamic>{};
        final merged = JsonUtils.deepMerge(base, override);
        expect(merged['a'], equals(1));
        expect(merged['b'], equals(2));
      });

      test('handles null values in override', () {
        final base = {'a': 1, 'b': 2};
        final override = {'b': null};
        final merged = JsonUtils.deepMerge(base, override);
        expect(merged['b'], isNull);
      });
    });

    group('round-trip', () {
      test('encode then decode produces equivalent map', () {
        final original = {'name': 'John', 'age': 30, 'active': true};
        final encoded = JsonUtils.encode(original);
        final decoded = JsonUtils.decode(encoded);
        expect(decoded, equals(original));
      });

      test('encode then decode preserves nested structures', () {
        final original = {
          'user': {'name': 'John', 'age': 30},
          'items': [1, 2, 3],
          'active': true,
        };
        final encoded = JsonUtils.encode(original);
        final decoded = JsonUtils.decode(encoded);
        expect(decoded, equals(original));
      });

      test('encode then decode preserves list', () {
        final original = [1, 'two', 3.0, true, null];
        final encoded = JsonUtils.encode(original);
        final decoded = JsonUtils.decode(encoded);
        expect(decoded, equals(original));
      });
    });
  });
}
