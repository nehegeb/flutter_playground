// set_initial_language.dart
//

import 'package:flutter/material.dart' show Locale, WidgetsBinding;
import 'package:flutter_playground/app/local_cache/local_cache.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// Initializes the app language setting.
/// If the setting exists in the [LocalCache], it sets the app language accordingly.
/// If it does not exist, it sets the language based on the user's device settings.
/// If the language cannot be determined or it is not supported, it defaults to English.
Future<void> setInitialLanguage() async {
  // Check, if there's something in the local [LocalCache].
  final settingExists = await LocalCache.check(setting: 'appLanguageId');
  if (settingExists) {
    // If the setting exists, load it from the [LocalCache].
    final setting = await LocalCache.load(setting: 'appLanguageId');

    // Set the app language based on the loaded setting.
    await Localization.setLanguage(languageId: setting, force: true);
  } else {
    // Otherwise, get the user's language from the device settings.
    Locale? locale;
    try {
      locale = WidgetsBinding.instance.platformDispatcher.locale;
    } catch (_) {
      locale = null;
    }
    final String userLanguageId = locale?.languageCode ?? '';

    // Make sure the languages data is loaded.
    if (Localization.dbLanguagesData == null) {
      await Localization.initDbLanguagesData();
      return;
    }

    // Check, if the user's language is supported by the app.
    bool isSupportedLanguage = false;
    for (final language in Localization.dbLanguagesData!) {
      if (language['idTitle'] == userLanguageId) {
        isSupportedLanguage = true;
        break;
      }
    }

    // If the user's language is not supported by the app, set the default app language ID.
    final String appLanguageId = isSupportedLanguage
        ? userLanguageId
        : defaultLanguageId;

    // Set the app language to the user's language.
    await Localization.setLanguage(languageId: appLanguageId, force: true);
  }
}
