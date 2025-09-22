// set_initial_brightness.dart
//

import 'package:flutter/material.dart' show WidgetsBinding, Brightness;
import 'package:flutter_playground/app/local_cache/local_cache.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';

/// Initializes the app brightness setting.
/// If the setting exists in the [LocalCache], it sets the app brightness accordingly.
/// If it does not exist, it sets the brightness based on the user's device settings.
/// If the brightness cannot be determined, it defaults to light mode.
Future<void> setInitialBrightness() async {
  // Check, if there's something in the [LocalCache] already.
  final settingExists = await LocalCache.check(setting: 'appBrightness');
  if (settingExists) {
    // If the setting exists, load it from the [LocalCache].
    final setting = await LocalCache.load(setting: 'appBrightness');

    // Set the app brightness based on the loaded setting.
    if (setting == 'dark') {
      // If the setting is 'dark', set the [AppTheme] to dark mode.
      AppTheme.setDarkMode();
    } else {
      // Otherwise and as a fallback, set the [AppTheme] to light mode.
      AppTheme.setLightMode();
    }
  } else {
    // Detect the platform brightness (light or dark mode).
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    if (brightness == Brightness.dark) {
      // If the brightness is dark, set the [AppTheme] to dark mode.
      AppTheme.setDarkMode();
    } else {
      // Otherwise and as a fallback, set the [AppTheme] to light mode.
      AppTheme.setLightMode();
    }
  }
}
