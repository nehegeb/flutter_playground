// set_app_language.dart
//

import 'package:flutter_playground/app/local_cache/local_cache.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/localization/logic/load_localizations.dart';

/// Sets the language for the app and saves it to local cache.
Future<void> setAppLanguage({
  required String language,
  bool force = false,
}) async {
  // Only update if the new language is different from the current one or if it is forced.
  if (Localization.appLanguage != language || force) {
    // Load localization files.
    await loadLocalizations(language);

    // Update the language notifier with the new language.
    appLanguageNotifier.value = language;

    // Save the new language setting to local cache.
    LocalCache.save(setting: 'appLanguage', value: language);
  }
}
