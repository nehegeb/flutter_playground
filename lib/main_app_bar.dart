/// main_app_bar.dart
///
/// Provides a reusable AppBar widget for the app.
///
/// The [MainAppBar] widget displays a given title, optional action widgets,
/// and a language selector popup menu. It integrates with the app's localization system
/// and uses the global currentLanguageNotifier for language changes.
library main_app_bar;

import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'localization/localization.dart';
import 'helpers/ui_widgets.dart';

/// A customizable app bar for the app.
class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// The title to display in the app bar.
  final String title;

  /// Additional action widgets to display in the app bar.
  final List<Widget>? actions;

  /// Creates a [MainAppBar].
  const MainAppBar({super.key, required this.title, this.actions});

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String currentLanguage = currentLanguageNotifier.value;
    return SafeArea(
      child: AppBar(
        title: Text(widget.title),
        actions: [
          ...?widget.actions,
          // Language selector.
          PopupMenuButton<String>(
            icon: CountryFlag.fromCountryCode(
              Localization.getText('countryCode'),
              shape: Circle(),
              width: 30,
            ),
            tooltip: "", // Remove unnecessary tooltip.
            initialValue: currentLanguage,
            onSelected: (selectedLanguage) async {
              await Localization.setCurrentLanguage(selectedLanguage);
            },
            itemBuilder: (context) => [
              PopupMenuEntryCompact(
                value: 'en',
                selected: currentLanguage == 'en',
                child: FlagMenuItem(
                  countryCode: 'us',
                  label: Localization.getText(
                    'appBar.languageSelector.english',
                  ),
                ),
              ),
              PopupMenuEntryCompact(
                value: 'de',
                selected: currentLanguage == 'de',
                child: FlagMenuItem(
                  countryCode: 'de',
                  label: Localization.getText('appBar.languageSelector.german'),
                ),
              ),
              PopupMenuEntryCompact(
                value: 'foo',
                selected: currentLanguage == 'foo',
                child: FlagMenuItem(
                  countryCode: 'xx',
                  label: Localization.getText('placeholder'),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

/// A menu item for the language selector that displays a country flag and a label.
class FlagMenuItem extends StatelessWidget {
  final String countryCode;
  final String label;

  const FlagMenuItem({
    required this.countryCode,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CountryFlag.fromCountryCode(
          countryCode,
          shape: RoundedRectangle(4),
          width: 30,
          height: 20,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
