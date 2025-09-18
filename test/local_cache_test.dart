// local_cache_test.dart
//
// Unit tests for the [LocalCache] utils class.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_playground/app/local_cache/local_cache.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const testKey = 'test_setting';
  const testValue = 'test_value';

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await LocalCache.clear();
  });

  tearDown(() async {
    await LocalCache.clear();
  });

  group('LocalCache', () {
    test('should save and load a setting', () async {
      await LocalCache.save(setting: testKey, value: testValue);
      final loaded = await LocalCache.load(setting: testKey);
      expect(loaded, equals(testValue));
    });

    test('should check existence of a setting', () async {
      await LocalCache.save(setting: testKey, value: testValue);
      final exists = await LocalCache.check(setting: testKey);
      expect(exists, isTrue);

      await LocalCache.delete(setting: testKey);
      final existsAfterDelete = await LocalCache.check(setting: testKey);
      expect(existsAfterDelete, isFalse);
    });

    test('should delete a setting', () async {
      await LocalCache.save(setting: testKey, value: testValue);
      await LocalCache.delete(setting: testKey);
      final loaded = await LocalCache.load(setting: testKey);
      expect(loaded, isNull);
    });

    test('should clear all settings', () async {
      await LocalCache.save(setting: testKey, value: testValue);
      await LocalCache.clear();
      final loaded = await LocalCache.load(setting: testKey);
      expect(loaded, isNull);
    });

    test('debug should not throw', () async {
      // This just ensures the debug method runs without error.
      await LocalCache.debug();
    });
  });
}
