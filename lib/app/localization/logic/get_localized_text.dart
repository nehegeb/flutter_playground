// get_localized_text.dart
//

import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:flutter_playground/app/localization/logic/load_localizations_data.dart';

/// Returns the localized value for the given key and language code.
String getLocalizedText(String key, String language) {
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
