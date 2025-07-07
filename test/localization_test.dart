import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_playground/localization/localization.dart';

void main() {
  // Ensure the Flutter test environment is initialized.
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Localization', () {
    // Test that getUserLanguage returns a valid language code.
    test('getUserLanguage returns a valid language code', () {
      final lang = Localization.getUserLanguage();
      expect(lang, isNotNull);
      expect(['en', 'de'], contains(lang));
    });

    // Test setting and getting the current language.
    test('setCurrentLanguage and getCurrentLanguage', () async {
      await Localization.setCurrentLanguage('de');
      expect(Localization.getCurrentLanguage, 'de');
      await Localization.setCurrentLanguage('en');
      expect(Localization.getCurrentLanguage, 'en');
    });

    // Test that the 'of' method returns a Localization instance with the correct language.
    test('of returns correct instance', () {
      final loc = Localization.of(TestBuildContext());
      expect(loc.language, Localization.getCurrentLanguage);
    });

    // Test that getText returns a valid localized string for both languages.
    test('getText returns correct localized string', () async {
      await Localization.setCurrentLanguage('en');
      expect(Localization.getText('appTitle'), isNot('[NO_LOCALIZATION]'));
      await Localization.setCurrentLanguage('de');
      expect(Localization.getText('appTitle'), isNot('[NO_LOCALIZATION]'));
    });

    // Test that getText falls back to English if the key is missing in German.
    test('getText falls back to English if key missing in German', () async {
      await Localization.setCurrentLanguage('de');
      expect(
        Localization.getText('testKey'),
        equals(
          "This is for performing a valid test where only the English localization has this key.",
        ),
      );
    });

    // Test that getText returns a placeholder for a missing key.
    test('getText returns placeholder for missing key', () async {
      await Localization.setCurrentLanguage('en');
      expect(Localization.getText('nonexistent_key'), '[NO_LOCALIZATION]');
    });

    // Test that getText returns lorem ipsum for placeholder keys.
    test('getText returns lorem ipsum for placeholder keys', () {
      expect(Localization.getText('placeholder'), isNotEmpty);
      expect(Localization.getText('placeholder5').split(' ').length, 5);
    });
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
