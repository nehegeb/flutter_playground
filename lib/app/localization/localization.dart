// localization.dart
//
// Provides and manages the language and localization for the app.
// It offers static methods to set the app language
// as well as fetch localized text for the app language.
//
// Features:
// - Provides a class [Localization] with static methods to manipulate [AppLanguage] and localization.
// - Provides a class for [AppLanguage].
// - Loads the languages JSON file with the supported languages.
// - Loads localization JSON files for supported languages.
// - Provides methods to get localized text based on keys.
// - Supports multiple languages and can easily updated to support more.

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/logic/load_languages_data.dart';
import 'package:flutter_playground/app/localization/logic/get_empty_app_language.dart';
import 'package:flutter_playground/app/localization/logic/get_localized_text.dart';
import 'package:flutter_playground/app/localization/logic/set_app_language.dart';
import 'package:flutter_playground/app/localization/logic/set_initial_language.dart';

/// The default and fallback language of the app.
String defaultLanguageId = 'en';

/// Notifier for the currently active languageId.
/// Initializes with [defaultLanguageId].
final ValueNotifier<String> appLanguageIdNotifier = ValueNotifier<String>(
  defaultLanguageId,
);

/// Utility class for language management.
/// Provides static methods to get localized text and set the app language.
///
/// Static Methods:
/// - [activeLanguageId]: Gets the currently active language ID.
/// - [emptyLanguage]: Gets an empty [AppLanguage].
/// - [dbLanguagesData]: Gets the loaded languages data.
/// - [getText]: Gets a localized text for a given key using the currently active [AppLanguage].
/// - [setLanguage]: Sets the currently active [AppLanguage].
/// - [initLanguage]: Initializes the app language.
/// - [initDbLanguagesData]: Initializes the languages data for the app.
/// - [clearDbLanguagesData]: Clears the languages data from the app.
class Localization {
  /// Get the currently active language ID.
  static String get activeLanguageId {
    return appLanguageIdNotifier.value;
  }

  /// Get an empty [AppLanguage].
  static AppLanguage get emptyLanguage {
    return getEmptyAppLanguage();
  }

  /// Get the loaded languages data of the database.
  static List<dynamic>? get dbLanguagesData {
    return languagesData;
  }

  /// Get a localized string using the app language.
  static String getText(String key) {
    return getLocalizedText(key: key, languageId: activeLanguageId);
  }

  /// Sets the language for the app.
  static Future<void> setLanguage({
    required String languageId,
    bool force = false,
  }) async {
    await setAppLanguage(languageId: languageId, force: force);
  }

  /// Initialize the app language.
  /// Loads the initial language setting from the local cache.
  /// or sets it based on the user's device settings.
  static Future<void> initLanguage() async {
    // Set the initial language.
    await setInitialLanguage();
  }

  /// Initializes the languages data from the database for the app.
  static Future<void> initDbLanguagesData() async {
    await loadLanguagesData();
  }

  /// Clear the loaded languages data of the database from the app.
  static void clearDbLanguagesData() {
    languagesData = null;
  }
}

/// A language of the app.
///
/// Arguments:
/// - [id]: The unique identifier of the language, as an integer.
/// - [idTitle]: The unique title of the language.
/// - [name]: The name of the language.
/// - [nativeName]: The native name of the language.
/// - [countryCode]: The country code associated with the language.
class AppLanguage {
  final int id;
  final String idTitle;
  final String name;
  final String? nativeName;
  final String? countryCode;

  AppLanguage({
    required this.id,
    required this.idTitle,
    required this.name,
    this.nativeName,
    this.countryCode,
  });

  factory AppLanguage.fromMap(Map<String, dynamic> map) {
    return AppLanguage(
      id: map['id'] is int ? map['id'] : int.tryParse(map['id'].toString()),
      idTitle: map['idTitle'],
      name: map['name'],
      nativeName: map['nativeName'] ?? map['name'],
      countryCode: map['countryCode'] ?? map['idTitle'],
    );
  }
}
