import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/utils/storage/storage_utils.dart';
import 'package:velocity_ui/src/utils/storage/preferences_storage.dart';
import 'package:velocity_ui/src/utils/storage/file_storage.dart';

void main() {
  group('StorageUtils', () {
    group('PreferencesStorage', () {
      late PreferencesStorage storage;

      setUp(() async {
        storage = PreferencesStorage();
        await storage.clear();
      });

      test('stores and retrieves string', () async {
        await storage.setString('key', 'value');
        final result = await storage.getString('key');
        expect(result, equals('value'));
      });

      test('returns null for non-existent key', () async {
        final result = await storage.getString('non_existent');
        expect(result, isNull);
      });

      test('updates existing value', () async {
        await storage.setString('key', 'value1');
        await storage.setString('key', 'value2');
        final result = await storage.getString('key');
        expect(result, equals('value2'));
      });

      test('removes key', () async {
        await storage.setString('key', 'value');
        await storage.remove('key');
        final result = await storage.getString('key');
        expect(result, isNull);
      });

      test('checks if key exists', () async {
        await storage.setString('key', 'value');
        final exists = await storage.containsKey('key');
        expect(exists, isTrue);
      });

      test('returns false for non-existent key', () async {
        final exists = await storage.containsKey('non_existent');
        expect(exists, isFalse);
      });

      test('clears all data', () async {
        await storage.setString('key1', 'value1');
        await storage.setString('key2', 'value2');
        await storage.clear();

        final result1 = await storage.getString('key1');
        final result2 = await storage.getString('key2');

        expect(result1, isNull);
        expect(result2, isNull);
      });

      test('stores and retrieves object', () async {
        final testObject = {'name': 'John', 'age': 30};
        await storage.setObject(
          'user',
          testObject,
          (obj) => obj,
        );

        final result = await storage.getObject(
          'user',
          (data) => data,
        );

        expect(result, equals(testObject));
      });

      test('returns null for non-existent object', () async {
        final result = await storage.getObject(
          'non_existent',
          (data) => data,
        );
        expect(result, isNull);
      });
    });

    group('FileStorage', () {
      late FileStorage storage;

      setUp(() async {
        storage = FileStorage.inMemory(basePath: '/test');
        await storage.clear();
      });

      test('stores and retrieves string', () async {
        await storage.setString('key', 'value');
        final result = await storage.getString('key');
        expect(result, equals('value'));
      });

      test('returns null for non-existent key', () async {
        final result = await storage.getString('non_existent');
        expect(result, isNull);
      });

      test('updates existing value', () async {
        await storage.setString('key', 'value1');
        await storage.setString('key', 'value2');
        final result = await storage.getString('key');
        expect(result, equals('value2'));
      });

      test('removes key', () async {
        await storage.setString('key', 'value');
        await storage.remove('key');
        final result = await storage.getString('key');
        expect(result, isNull);
      });

      test('checks if key exists', () async {
        await storage.setString('key', 'value');
        final exists = await storage.containsKey('key');
        expect(exists, isTrue);
      });

      test('returns false for non-existent key', () async {
        final exists = await storage.containsKey('non_existent');
        expect(exists, isFalse);
      });

      test('clears all data', () async {
        await storage.setString('key1', 'value1');
        await storage.setString('key2', 'value2');
        await storage.clear();

        final result1 = await storage.getString('key1');
        final result2 = await storage.getString('key2');

        expect(result1, isNull);
        expect(result2, isNull);
      });

      test('stores and retrieves object', () async {
        final testObject = {'name': 'John', 'age': 30};
        await storage.setObject(
          'user',
          testObject,
          (obj) => obj,
        );

        final result = await storage.getObject(
          'user',
          (data) => data,
        );

        expect(result, equals(testObject));
      });

      test('returns null for non-existent object', () async {
        final result = await storage.getObject(
          'non_existent',
          (data) => data,
        );
        expect(result, isNull);
      });
    });

    group('Storage round-trip', () {
      test('PreferencesStorage round-trip preserves data', () async {
        final storage = PreferencesStorage();
        await storage.clear();

        const key = 'test_key';
        const value = 'test_value';

        await storage.setString(key, value);
        final retrieved = await storage.getString(key);

        expect(retrieved, equals(value));
        await storage.clear();
      });

      test('FileStorage round-trip preserves data', () async {
        final storage = FileStorage.inMemory(basePath: '/test');
        await storage.clear();

        const key = 'test_key';
        const value = 'test_value';

        await storage.setString(key, value);
        final retrieved = await storage.getString(key);

        expect(retrieved, equals(value));
        await storage.clear();
      });

      test('PreferencesStorage round-trip with complex object', () async {
        final storage = PreferencesStorage();
        await storage.clear();

        final testObject = {
          'name': 'John',
          'age': 30,
          'items': [1, 2, 3],
          'nested': {'key': 'value'},
        };

        await storage.setObject(
          'complex',
          testObject,
          (obj) => obj,
        );

        final retrieved = await storage.getObject(
          'complex',
          (data) => data,
        );

        expect(retrieved, equals(testObject));
        await storage.clear();
      });
    });
  });
}
