// localization_test.dart
//
// Unit tests for Localization.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  group('Localization', () {
    test(
      'setLanguage sets language and getText returns correct string',
      () async {
        await Localization.setLanguage(languageId: 'en');
        expect(Localization.getText('appName'), isNot('[NO_LOCALIZATION]'));
        await Localization.setLanguage(languageId: 'de');
        expect(Localization.getText('appName'), isNot('[NO_LOCALIZATION]'));
      },
    );

    test(
      'getText falls back to English if key missing in selected language',
      () async {
        await Localization.setLanguage(languageId: 'de');
        expect(
          Localization.getText('testKey'),
          equals(
            "This is for performing a valid test where only the English localization has this key.",
          ),
        );
      },
    );

    test('getText returns placeholder for missing key', () async {
      await Localization.setLanguage(languageId: 'en');
      expect(Localization.getText('nonexistent_key'), '[NO_LOCALIZATION]');
    });

    test('getText returns lorem ipsum for placeholder keys', () {
      expect(Localization.getText('placeholder'), isNotEmpty);
      expect(Localization.getText('placeholder5').split(' ').length, 5);
    });

    test('getText handles null and empty keys gracefully', () {
      expect(Localization.getText(''), '[NO_LOCALIZATION]');
    });

    test('setLanguage throws or ignores invalid language codes', () async {
      await Localization.setLanguage(languageId: 'xx');
      expect(Localization.getText('appName'), isNot('[NO_LOCALIZATION]'));
    });

    test(
      'getText returns correct value after multiple language switches',
      () async {
        await Localization.setLanguage(languageId: 'en');
        final enText = Localization.getText('misc.months.january');
        await Localization.setLanguage(languageId: 'de');
        final deText = Localization.getText('misc.months.january');
        expect(enText, isNot(deText));
      },
    );
  });
}

/// Dummy BuildContext for testing purposes.
class TestBuildContext extends BuildContext {
  @override
  InheritedWidget dependOnInheritedElement(
    InheritedElement ancestor, {
    Object? aspect,
  }) => throw UnimplementedError();
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
