// language_menu_mobile.dart
//

import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/top_app_bar/widgets/language_menu.dart';

/// Widget for language selector for mobile devices.
class LanguageMenuMobile extends StatelessWidget {
  const LanguageMenuMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final String appLanguage = Localization.appLanguage;

    return Builder(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            // Close the current menu.
            Navigator.of(context).pop();

            // Show the language selector popup.
            final Size topAppBarSize = Size.fromHeight(kToolbarHeight);
            final RenderBox overlay =
                Overlay.of(context).context.findRenderObject() as RenderBox;
            final double top = topAppBarSize.height;
            final double right = 0.0;
            final double left = overlay.size.width;
            final double bottom = overlay.size.height - topAppBarSize.height;

            // Change the app language to the selected language.
            final selectedLanguage = await showMenu<String>(
              context: context,
              position: RelativeRect.fromLTRB(left, top, right, bottom),
              items: LanguageMenu.menuItems(context, appLanguage),
            );
            if (selectedLanguage != null) {
              await Localization.setLanguage(language: selectedLanguage);
            }
          },
          child: Row(
            children: [
              // Find the current language data from dbLanguagesData.
              if (Localization.dbLanguagesData != null)
                ...() {
                  final langData = Localization.dbLanguagesData!.firstWhere(
                    (lang) => lang['id'] == appLanguage,
                    orElse: () => null,
                  );
                  if (langData != null) {
                    return [
                      CountryFlag.fromCountryCode(
                        langData['countryCode'] ?? '',
                        shape: Circle(),
                        width: 24,
                      ),
                      SizedBox(width: 8),
                      Text(Localization.getText('appBar.menu.switchLanguage')),
                    ];
                  }
                  return [];
                }(),
            ],
          ),
        );
      },
    );
  }
}
