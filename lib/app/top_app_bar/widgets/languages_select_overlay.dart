// languages_select_overlay.dart
//

import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/misc/widgets/popup_menu_entry_compact.dart';

// The [LanguagesSelectOverlay] widget showing the flag of the current app language.
// This is opened using the [showLanguagesSelectOverlay] function.
class LanguagesSelectOverlay {
  static List<PopupMenuEntry<String>> languagesSelectEntry(
    BuildContext context,
  ) {
    // Get the data of the currently active language.
    final String activeLanguageId = Localization.activeLanguageId;

    // Get the list of all available languages.
    final languages = Localization.dbLanguagesData ?? [];

    // Return an entry in the [LanguagesSelectOverlay] for each language.
    return languages.map<PopupMenuEntry<String>>((lang) {
      final languageId = lang['idTitle'] as String;
      final languageName = lang['nativeName'] as String;
      final countryCode = lang['countryCode'] as String;

      // The entry for the this language.
      return PopupMenuEntryCompact(
        value: languageId,
        selected: activeLanguageId == languageId,
        child: Row(
          children: [
            // A rectangular country flag icon to the left.
            CountryFlag.fromCountryCode(
              countryCode,
              shape: RoundedRectangle(4),
              width: 30,
              height: 20,
            ),
            // A little spacer inbetween.
            const SizedBox(width: 8),
            // The native name of the language to the rigt.
            Flexible(
              child: Text(languageName, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      );
    }).toList();
  }
}
