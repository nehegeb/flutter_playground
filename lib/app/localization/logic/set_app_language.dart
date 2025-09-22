// set_app_language.dart
//

import 'package:flutter_playground/app/local_cache/local_cache.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/localization/logic/load_localizations_data.dart';

/// Sets the given [languageId] as [AppLanguage] for the app and saves it to [LocalCache].
/// If [force] is 'true', it will always load the localization data, even if the language is already loaded.
Future<void> setAppLanguage({
  required String languageId,
  bool force = false,
}) async {
  // Only update if the given [language] is different from the current one, or if it is forced.
  if (Localization.activeLanguageId != languageId || force) {
    // Load localization data.
    await loadLocalizationsData(languageId);

    // Update the [appLanguageIdNotifier] with the given [language].
    appLanguageIdNotifier.value = languageId;

    // Save the new language setting to [LocalCache].
    LocalCache.save(setting: 'appLanguageId', value: languageId);
  }
}
