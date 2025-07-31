// localization.dart
//
// Provides and manages the current language for the app
// and offers static methods to retrieve and set the language
// as well as fetch localized text for the current language.
//
// Features:
// - Loads localization JSON files.
// - Provides methods to get localized text based on keys.
// - Supports multiple languages and can easily updated to support more.

import 'package:flutter/material.dart';
import 'package:flutter_playground/localization/logic_widgets/load_localizations.dart';
import 'package:flutter_playground/localization/logic_widgets/get_localized_text.dart';
import 'package:flutter_playground/localization/logic_widgets/get_initial_language.dart';

/// Notifier for the currently selected app language.
final ValueNotifier<String> currentLanguageNotifier = ValueNotifier<String>(
  'en',
);

/// Provides access to localized strings for the app, manages the current language,
/// and offers static methods to retrieve and set the language as well as fetch localized text.
///
/// Static Methods:
/// - [setCurrentLanguage]: Sets the app's current language.
/// - [getCurrentLanguage]: Gets the app's current language code.
/// - [getUserLanguage]: Gets the users language based on the device settings, defaulting to English if not available.
/// - [getText]: Gets a localized text for the given JSON key using the current language.
class Localization {
  /// Sets the current language for the app.
  static Future<void> setCurrentLanguage(
    String language, {
    bool force = false,
  }) async {
    // Only update if the new language is different from the current one or if it is forced.
    if (currentLanguageNotifier.value != language || force) {
      // Load localization files and then update the current language.
      await loadLocalizations(language);
      // Update the language notifier with the new language.
      currentLanguageNotifier.value = language;
    }
  }

  /// Get the current language of the app.
  static String get getCurrentLanguage => currentLanguageNotifier.value;

  /// Get the language the user has set.
  static String getUserLanguage() {
    return getInitialLanguage();
  }

  /// Get a localized string using the current language.
  static String getText(String key) {
    return getLocalizedText(key, currentLanguageNotifier.value);
  }
}
