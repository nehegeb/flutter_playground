// language_menu.dart
//

import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/main_app_bar/ui_widgets/flag_menu_item.dart';
import 'package:flutter_playground/app/misc/ui_widgets/popup_menu_entry_compact.dart';

/// Widget for language selector.
class LanguageMenu extends StatelessWidget {
  final String appLanguage;
  final void Function(String)? onSelected;

  const LanguageMenu({required this.appLanguage, this.onSelected, super.key});

  // Static helper to build menu items for language selector.
  static List<PopupMenuEntry<String>> menuItems(
    BuildContext context,
    String appLanguage,
  ) {
    return [
      PopupMenuEntryCompact(
        value: 'en',
        selected: appLanguage == 'en',
        child: FlagMenuItem(
          countryCode: 'us',
          label: Localization.getText('appBar.languageSelector.english'),
        ),
      ),
      PopupMenuEntryCompact(
        value: 'de',
        selected: appLanguage == 'de',
        child: FlagMenuItem(
          countryCode: 'de',
          label: Localization.getText('appBar.languageSelector.german'),
        ),
      ),
      // NOTE: Add more languages here as needed.
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: CountryFlag.fromCountryCode(
        Localization.getText('language.countryCode'),
        shape: Circle(),
        width: 24,
      ),
      tooltip: "",
      initialValue: appLanguage,
      onSelected: onSelected,
      itemBuilder: (context) => LanguageMenu.menuItems(context, appLanguage),
    );
  }
}
