// set_initial_language.dart
//

import 'package:flutter/material.dart' show Locale, WidgetsBinding;
import 'package:flutter_playground/app/local_cache/local_cache.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// Initializes the app language setting.
/// If the setting exists in the local cache, it sets the app language accordingly.
/// If it does not exist, it sets the language based on the user's device settings.
/// If the language cannot be determined or it is not supported, it defaults to English.
Future<void> setInitialLanguage() async {
  // Check, if there's something in the local cache already.
  final settingExists = await LocalCache.check(setting: 'appLanguage');
  if (settingExists) {
    // If the setting exists, load it from the cache.
    final setting = await LocalCache.load(setting: 'appLanguage');

    // Set the app language based on the loaded setting.
    await Localization.setLanguage(language: setting, force: true);
  } else {
    // Get the user's language from the device settings.
    Locale? locale;
    try {
      locale = WidgetsBinding.instance.platformDispatcher.locale;
    } catch (_) {
      locale = null;
    }
    final languageCode = locale?.languageCode ?? 'en'; // Fallback to English.

    // Check, if the language is supported.
    // If not, default to English.
    // TODO: Implement a method to check if the language is supported.
    final appLanguage = languageCode.isNotEmpty
        ? languageCode
        : 'en'; // DEV: Temporary fallback until check is implemented.

    // Set the app language to the user's language.
    await Localization.setLanguage(language: appLanguage, force: true);
  }
}
