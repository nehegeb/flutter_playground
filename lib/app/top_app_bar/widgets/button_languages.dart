// button_languages.dart
//

import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/top_app_bar/logic/show_languages_select_overlay.dart';

/// A widget for the button to change languages, for wide screens.
/// It is used to the right within the [TopAppBar].
class ButtonLanguages extends StatefulWidget {
  const ButtonLanguages({super.key});

  @override
  ButtonLanguagesState createState() => ButtonLanguagesState();
}

class ButtonLanguagesState extends State<ButtonLanguages> {
  @override
  Widget build(BuildContext context) {
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

    return IconButton(
      icon: CountryFlag.fromCountryCode(
        activeLanguageData?['countryCode'],
        shape: Circle(),
        width: 24,
      ),
      onPressed: () {
        showLanguagesSelectOverlay(context);
      },
      tooltip: Localization.getText('appBar.menu.switchAppLanguage'),
    );
  }
}
