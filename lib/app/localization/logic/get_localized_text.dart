// get_localized_text.dart
//

import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/localization/logic/load_localizations_data.dart';

/// Returns the localized value for the given [key] and [languageId].
/// The [languageId] is the id of the language as defined within the localization files (e.g., 'en', 'de').
String getLocalizedText({required String key, String? languageId}) {
  Map<String, dynamic>? localizationSelected;

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
  if (localizationDataPrimary == null) {
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

  // If no [languageId] has been given, fall back to the default app language.
  languageId = languageId ?? defaultLanguageId;

  // Select the appropriate localization data based on the given [languageId].
  if (languageId != defaultLanguageId) {
    // Use secondary localization data.
    localizationSelected = localizationDataSecondary;
  } else {
    // Use primary localization data.
    localizationSelected = localizationDataPrimary;
  }

  // switch (languageId) {
  //   case 'en':
  //     // English localization.
  //     localizationSelected =
  //         localizationDataPrimary; // Use primary localization data.
  //     break;
  //   case 'de':
  //     // German localization.
  //     localizationSelected =
  //         localizationDataSecondary; // Use secondary localization data.
  //     break;
  //   // NOTE: Add more languages here as needed.
  //   default:
  //     // If the language is not recognized, default to English.
  //     languageId = 'en';
  //     localizationSelected = localizationDataPrimary;
  // }

  // Try given [languageId] first, then fallback to the default app language.
  for (final map in [localizationSelected, localizationDataPrimary]) {
    if (map == null) continue;
    dynamic value = map;
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
