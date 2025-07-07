/// app_bar.dart
///
/// Provides a reusable, customizable AppBar widget for the app.
///
/// The [MainAppBar] widget displays a given title, optional action widgets,
/// and a language selector popup menu. It notifies the parent widget when the
/// language changes and integrates with the app's localization system.
///
/// Example usage:
/// ```dart
/// MainAppBar(
///   title: 'My App',
///   actions: [IconButton(icon: Icon(Icons.info), onPressed: () {})],
///   onLanguageChanged: (lang) => print('Language changed: $lang'),
/// )
/// ```
library appbar;

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

  /// Callback when the user selects a new language.
  final void Function(String language)? onLanguageChanged;

  /// Creates a [MainAppBar].
  const MainAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onLanguageChanged,
  });

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  late String _currentLanguage;

  @override
  void initState() {
    super.initState();
    // Initialize the app language from the global localization state.
    _currentLanguage = Localization.getCurrentLanguage;
  }

  @override
  Widget build(BuildContext context) {
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
            tooltip: "",
            initialValue: _currentLanguage,
            onSelected: (selectedLanguage) async {
              setState(() {
                _currentLanguage = selectedLanguage;
              });
              // Update the global localization state.
              await Localization.setCurrentLanguage(selectedLanguage);
              // Notify the parent widget about the new language, if a callback is provided.
              if (widget.onLanguageChanged != null) {
                widget.onLanguageChanged!(selectedLanguage);
              }
            },
            itemBuilder: (context) => [
              PopupMenuEntryCompact(
                value: 'en',
                selected: _currentLanguage == 'en',
                child: FlagMenuItem(
                  countryCode: 'us',
                  label: Localization.getText(
                    'appBar.languageSelector.english',
                  ),
                ),
              ),
              PopupMenuEntryCompact(
                value: 'de',
                selected: _currentLanguage == 'de',
                child: FlagMenuItem(
                  countryCode: 'de',
                  label: Localization.getText('appBar.languageSelector.german'),
                ),
              ),
              PopupMenuEntryCompact(
                value: 'foo',
                selected: _currentLanguage == 'foo',
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
