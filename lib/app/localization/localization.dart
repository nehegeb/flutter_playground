// localization.dart
//
// Provides and manages the language for the app
// and offers static methods to set the language
// as well as fetch localized text for the app language.
//
// Features:
// - Loads localization JSON files for supported languages.
// - Provides methods to get localized text based on keys.
// - Supports multiple languages and can easily updated to support more.

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/logic/load_languages_data.dart';
import 'package:flutter_playground/app/localization/logic/get_localized_text.dart';
import 'package:flutter_playground/app/localization/logic/set_app_language.dart';
import 'package:flutter_playground/app/localization/logic/set_initial_language.dart';

/// Notifier for the currently selected app language.
/// Defaults to English ('en').
final ValueNotifier<String> appLanguageNotifier = ValueNotifier<String>('en');

/// Utility class for language management.
/// Provides static methods to get localized text and set the app language.
///
/// Static Methods:
/// - [appLanguage]: Gets the app language.
/// - [dbLanguagesData]: Gets the loaded languages data.
/// - [getText]: Gets a localized text for a given key using the app language.
/// - [setLanguage]: Sets the app language to given [language].
/// - [initLanguage]: Initializes the app language.
/// - [initDbLanguagesData]: Initializes the user languages for the app.
/// - [clearDbLanguagesData]: Clears the user languages from the app.
class Localization {
  /// Get the app language.
  static String get appLanguage {
    return appLanguageNotifier.value;
  }

  /// Get the loaded languages data of the database.
  static List<dynamic>? get dbLanguagesData {
    return languagesData;
  }

  /// Get a localized string using the app language.
  static String getText(String key) {
    return getLocalizedText(key: key, languageCode: appLanguage);
  }

  /// Sets the language for the app.
  static Future<void> setLanguage({
    required String language,
    bool force = false,
  }) async {
    await setAppLanguage(language: language, force: force);
  }

  /// Initializes the app language.
  /// Loads the initial language setting from the local cache.
  /// or sets it based on the user's device settings.
  static Future<void> initLanguage() async {
    // Set the initial language.
    await setInitialLanguage();
  }

  /// Loads the languages data from the database for the app.
  static Future<void> initDbLanguagesData() async {
    await loadLanguagesData();
  }

  /// Clear the loaded languages data of the database from the app.
  static void clearDbLanguagesData() {
    languagesData = null;
  }
}
