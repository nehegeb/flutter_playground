/// localization.dart
///
/// Provides and manages the current language for the app
/// and offers static methods to retrieve and set the language
/// as well as fetch localized text for the current language.
///
/// Features:
/// - Loads localization JSON files.
/// - Provides methods to get localized text based on keys.
/// - Supports multiple languages and can easily updated to support more.
library localization;

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:flutter_playground/helpers/loading_overlay.dart';

/// Notifier for the currently selected app language.
final ValueNotifier<String> currentLanguageNotifier = ValueNotifier<String>(
  'en',
);

Map<String, dynamic>? localizationPrimary; // English is always loaded.
Map<String, dynamic>? localizationSecondary; // Secondary localization.

/// Loads localization JSON files and parses them into maps.
/// Only loads English and the specified language.
Future<void> _loadLocalizations(String? language) async {
  // Display a loading overlay while localizations are being loaded.
  LoadingOverlay.initiate('Loading localizations...');

  // Load the localization files.
  try {
    // Load the primary localization (English).
    final jsonEn = await rootBundle.loadString(
      'lib/localization/localization_english.json',
    );
    localizationPrimary = json.decode(jsonEn) as Map<String, dynamic>;

    // Additionaly load the requested language if different.
    switch (language) {
      case 'de':
        // Load German localization if requested.
        final jsonDe = await rootBundle.loadString(
          'lib/localization/localization_german.json',
        );
        localizationSecondary = json.decode(jsonDe) as Map<String, dynamic>;
        break;
      // NOTE: Add more languages here as needed.
      default:
        // No secondary localization available.
        localizationSecondary = null;
    }
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }
}

/// Returns the localized value for the given key and language code.
String _getLocalizedText(String key, String language) {
  Map<String, dynamic>? localizationSelected;

  // Select the appropriate localization based on the language.
  switch (language) {
    case 'en':
      // English localization.
      localizationSelected =
          localizationPrimary; // Primary localization (English).
      break;
    case 'de':
      // German localization.
      localizationSelected = localizationSecondary; // Secondary localization.
      break;
    // NOTE: Add more languages here as needed.
    default:
      // If the language is not recognized, default to English.
      localizationSelected = localizationPrimary;
      language = 'en';
  }

  // If the key is 'placeholder', return a placeholder string.
  if (key.startsWith('placeholder')) {
    final match = RegExp(r'^placeholder(\d+)$').firstMatch(key);
    if (match != null) {
      // Return a lorem ipsum string with the specified number of words.
      final count = int.tryParse(match.group(1) ?? '1') ?? 1;
      return loremIpsum(words: count);
    } else if (key == 'placeholder') {
      // Return a single word without any punctuation.
      final word = loremIpsum(words: 1).replaceAll(RegExp(r'[^\w\s]+$'), '');
      return word;
    }
  }

  // If localizations are not loaded yet, return the given key in all caps.
  if (localizationPrimary == null) {
    final placeholder = StringBuffer();
    placeholder.write('[');
    // Insert an underscore before every uppercase letter in the key.
    for (var rune in key.runes) {
      var char = String.fromCharCode(rune);
      if (char.toUpperCase() == char && char.toLowerCase() != char) {
        placeholder.write('_');
      }
      placeholder.write(char.toUpperCase());
    }
    placeholder.write(']');
    return placeholder.toString();
  }

  // Try selected language first, then fallback to English.
  for (final map in [localizationSelected, localizationPrimary]) {
    if (map == null) continue;
    dynamic value = map;
    // Support nested keys in the localization JSON using dot notation.
    for (final part in key.split('.')) {
      if (value is Map<String, dynamic> && value.containsKey(part)) {
        value = value[part];
      } else {
        value = null;
        break;
      }
    }
    if (value is String) return value;
  }

  // If nothing could be found, return a placeholder.
  return '[NO_LOCALIZATION]';
}

/// Returns the initial language based on the user's device settings.
/// If the device language cannot be determined, it defaults to English.
String _getInitialLanguage() {
  Locale? locale;
  try {
    locale = WidgetsBinding.instance.platformDispatcher.locale;
  } catch (_) {
    locale = null;
  }
  final languageCode = locale?.languageCode ?? 'en'; // Fallback to English.
  return languageCode;
}

/// Provides access to localized strings for the app, manages the current language,
/// and offers static methods to retrieve and set the language as well as fetch localized text.
///
/// Static Methods:
/// - [of]: Returns a Localization instance for the current language.
/// - [setCurrentLanguage]: Sets the app's current language.
/// - [getCurrentLanguage]: Gets the app's current language code.
/// - [getUserLanguage]: Gets the users language based on the device settings, defaulting to English if not available.
/// - [getText]: Gets a localized text for the given JSON key using the current language.
class Localization {
  final String language;
  Localization(this.language);

  /// Returns a Localization instance for the current language.
  static Localization of(BuildContext context) {
    return Localization(currentLanguageNotifier.value);
  }

  /// Sets the current language for the app.
  static Future<void> setCurrentLanguage(
    String language, {
    bool force = false,
  }) async {
    // Only update if the new language is different from the current one or if it is forced.
    if (currentLanguageNotifier.value != language || force) {
      // Load localization files and then update the current language.
      await _loadLocalizations(language);
      // Update the language notifier with the new language.
      currentLanguageNotifier.value = language;
    }
  }

  /// Get the current language of the app.
  static String get getCurrentLanguage => currentLanguageNotifier.value;

  /// Get the language the user has set.
  static String getUserLanguage() {
    return _getInitialLanguage();
  }

  /// Get a localized string using the current language.
  static String getText(String key) {
    return _getLocalizedText(key, currentLanguageNotifier.value);
  }
}
