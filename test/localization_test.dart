// localization_test.dart
//
// Unit tests for the [Localization] utils class.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_playground/app/localization/localization.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  group('Localization', () {
    setUp(() {
      Localization.clearDbLanguagesData();
    });

    test('defaultLanguageId is "en"', () {
      expect(defaultLanguageId, equals('en'));
    });

    test('appLanguageIdNotifier initializes with defaultLanguageId', () {
      expect(appLanguageIdNotifier.value, equals(defaultLanguageId));
    });

    test('activeLanguageId returns current language', () {
      appLanguageIdNotifier.value = 'de';
      expect(Localization.activeLanguageId, equals('de'));
    });

    test('emptyLanguage returns an AppLanguage', () {
      final empty = Localization.emptyLanguage;
      expect(empty, isA<AppLanguage>());
    });

    test('dbLanguagesData is null after clear', () {
      Localization.clearDbLanguagesData();
      expect(Localization.dbLanguagesData, isNull);
    });

    test('setLanguage updates appLanguageIdNotifier', () async {
      await Localization.setLanguage(languageId: 'fr', force: true);
      expect(appLanguageIdNotifier.value, equals('fr'));
    });

    test('initDbLanguagesData loads languages data', () async {
      await Localization.initDbLanguagesData();
      expect(Localization.dbLanguagesData, isNotNull);
      expect(Localization.dbLanguagesData, isA<List<dynamic>>());
    });

    test('AppLanguage.fromMap creates correct instance', () {
      final map = {
        'id': '1',
        'idTitle': 'en',
        'name': 'English',
        'nativeName': 'English',
        'countryCode': 'US',
      };
      final lang = AppLanguage.fromMap(map);
      expect(lang.id, '1');
      expect(lang.idTitle, 'en');
      expect(lang.name, 'English');
      expect(lang.nativeName, 'English');
      expect(lang.countryCode, 'US');
    });
  });
}
