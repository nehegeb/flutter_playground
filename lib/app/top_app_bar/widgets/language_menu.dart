// language_menu.dart
//

import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/misc/widgets/popup_menu_entry_compact.dart';
import 'package:flutter_playground/app/top_app_bar/widgets/language_menu_flag_entry.dart';

/// Widget for language selector for wide screens.
class LanguageMenu extends StatelessWidget {
  final String appLanguage;
  final void Function(String)? onSelected;

  const LanguageMenu({super.key, required this.appLanguage, this.onSelected});

  // Static helper to build menu entries for language selector.
  static List<PopupMenuEntry<String>> menuItems(
    BuildContext context,
    String appLanguage,
  ) {
    final languages = Localization.dbLanguagesData ?? [];
    return languages.map<PopupMenuEntry<String>>((lang) {
      final languageCode = lang['id'] as String;
      final countryCode = lang['countryCode'] as String;
      final languageName = lang['nativeName'] as String;
      return PopupMenuEntryCompact(
        value: languageCode,
        selected: appLanguage == languageCode,
        child: LanguageMenuFlagEntry(
          countryCode: countryCode,
          label: languageName,
        ),
      );
    }).toList();
  }

  // The widget showing the flag of the current app language.
  // This opens the above popup menu with the languages to select.
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: CountryFlag.fromCountryCode(
        Localization.dbLanguagesData?.firstWhere(
          (lang) => lang['id'] == appLanguage,
        )['countryCode'],
        shape: Circle(),
        width: 24,
      ),
      tooltip: "",
      initialValue: appLanguage,
      onSelected: onSelected,
      itemBuilder: (context) => LanguageMenu.menuItems(context, appLanguage),
      // Move the menu below the [TopAppBar] and to the right.
      position: PopupMenuPosition.under,
      offset: const Offset(50, 16),
    );
  }
}
