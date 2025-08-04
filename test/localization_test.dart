import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_playground/app/localization/localization.dart';

void main() {
  // Ensure the Flutter test environment is initialized.
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Localization', () {
    // Test that getText returns a valid localized string for both languages.
    test('getText returns correct localized string', () async {
      await Localization.setLanguage(language: 'en');
      expect(Localization.getText('appName'), isNot('[NO_LOCALIZATION]'));
      await Localization.setLanguage(language: 'de');
      expect(Localization.getText('appName'), isNot('[NO_LOCALIZATION]'));
    });

    // Test that getText falls back to English if the key is missing in German.
    test('getText falls back to English if key missing in German', () async {
      await Localization.setLanguage(language: 'de');
      expect(
        Localization.getText('testKey'),
        equals(
          "This is for performing a valid test where only the English localization has this key.",
        ),
      );
    });

    // Test that getText returns a placeholder for a missing key.
    test('getText returns placeholder for missing key', () async {
      await Localization.setLanguage(language: 'en');
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
