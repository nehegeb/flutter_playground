// set_app_brightness.dart
//

import 'package:flutter_playground/app/local_cache/local_cache.dart';
import 'package:flutter_playground/app/app_theme/widgets/app_theme_light.dart';
import 'package:flutter_playground/app/app_theme/widgets/app_theme_dark.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';

/// Sets the brightness for the app and saves it to local cache.
/// The brightness can be 'light', 'dark', or 'toggle'.
void setAppBrightness({required String brightness}) {
  // Check if the given brightness is valid.
  const allowedModes = ['light', 'dark', 'toggle'];
  if (!allowedModes.contains(brightness)) {
    throw ArgumentError(
      "Invalid brightness: $brightness. Allowed values are 'light', 'dark', or 'toggle'.",
    );
  }

  // Set the app brightness and save it to local cache.
  switch (brightness) {
    case 'light':
      // If the given brightness is 'light', set the app theme to light mode.

      // Set the app theme to light mode.
      appThemeNotifier.value = [
        {'appTheme': appThemeLight, 'isDarkMode': false},
      ];

      // Save the light mode setting to local cache.
      LocalCache.save(setting: 'appBrightness', value: 'light');

      break;
    case 'dark':
      // If the given brightness is 'dark', set the app theme to dark mode.

      // Set the app theme to dark mode.
      appThemeNotifier.value = [
        {'appTheme': appThemeDark, 'isDarkMode': true},
      ];

      // Save the dark mode setting to local cache.
      LocalCache.save(setting: 'appBrightness', value: 'dark');

      break;
    case 'toggle':
      // If the given brightness is 'toggle', switch between light and dark mode.

      // Set the app theme to the opposite mode.
      setAppBrightness(brightness: AppTheme.isLightMode ? 'dark' : 'light');

      break;
  }
}
