import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/app/local_cache/local_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('LocalCache', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('check returns false for missing key', () async {
      final exists = await LocalCache.check(setting: 'missing_key');
      expect(exists, false);
    });

    test('save and check returns true for saved key', () async {
      await LocalCache.save(setting: 'test_key', value: 'test_value');
      final exists = await LocalCache.check(setting: 'test_key');
      expect(exists, true);
    });

    test('save and load returns correct value', () async {
      await LocalCache.save(setting: 'test_key', value: 'test_value');
      final value = await LocalCache.load(setting: 'test_key');
      expect(value, 'test_value');
    });

    test('delete removes key', () async {
      await LocalCache.save(setting: 'test_key', value: 'test_value');
      await LocalCache.delete(setting: 'test_key');
      final exists = await LocalCache.check(setting: 'test_key');
      expect(exists, false);
    });

    test('clear removes all keys', () async {
      await LocalCache.save(setting: 'key1', value: 'value1');
      await LocalCache.save(setting: 'key2', value: 'value2');
      await LocalCache.clear();
      final exists1 = await LocalCache.check(setting: 'key1');
      final exists2 = await LocalCache.check(setting: 'key2');
      expect(exists1, false);
      expect(exists2, false);
    });
  });
}
