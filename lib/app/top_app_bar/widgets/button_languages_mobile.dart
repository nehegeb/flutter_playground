// button_languages_mobile.dart
//

import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_playground/app/misc/widgets/popup_menu_entry_compact.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// A widget for the button to change app brightness, for mobile devices.
/// It is used in the [UserMenu] at the top right of the [TopAppBar].
PopupMenuEntry<String> buttonLanguagesMobile(BuildContext context) {
  final String activeLanguageId = Localization.activeLanguageId;
  final List<dynamic>? dbLanguagesData = Localization.dbLanguagesData;

  // Get the data of the currently active language.
  final Map<String, dynamic>? activeLanguageData =
      dbLanguagesData != null && dbLanguagesData.isNotEmpty
      ? Localization.dbLanguagesData!.firstWhere(
          (lang) => lang['idTitle'] == activeLanguageId,
          orElse: () => null,
        )
      : null;

  return PopupMenuEntryCompact(
    value: 'switchAppLanguage',
    selected: false,
    child: Row(
      children: [
        if (activeLanguageData != null) ...[
          CountryFlag.fromCountryCode(
            activeLanguageData['countryCode'] ?? '',
            shape: Circle(),
            width: 24,
          ),
          SizedBox(width: 8),
          Text(Localization.getText('appBar.menu.switchAppLanguage')),
        ],
      ],
    ),
  );
}
