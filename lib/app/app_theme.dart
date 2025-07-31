// app_theme.dart
//

import 'package:flutter/material.dart';

/// Notifier for the currently selected app theme.
final ValueNotifier<List<Map<String, dynamic>>> currentThemeNotifier =
    ValueNotifier<List<Map<String, dynamic>>>([
      {'appTheme': appThemeLight, 'isDarkMode': false},
    ]);

const Color seedColor = Colors.amber;

/// Global light app theme.
final ThemeData appThemeLight = (() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Color.alphaBlend(
        Colors.black26,
        ColorScheme.fromSeed(seedColor: seedColor).primary,
      ),
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 18, color: Colors.black87),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: seedColor),
  );
})();

/// Global dark app theme.
final ThemeData appThemeDark = (() {
  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    // scaffoldBackgroundColor: Colors.black,
    scaffoldBackgroundColor: Color.alphaBlend(Colors.black87, Colors.grey),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.alphaBlend(
        Colors.black26,
        ColorScheme.fromSeed(seedColor: seedColor).primary,
      ),
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 18, color: Colors.white70),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: seedColor),
  );
})();

/// Returns the initial displaymode based on the user's device settings.
/// If the device display mode cannot be determined, it defaults to light mode.
void _setInitialDisplayMode() {
  // Detect the platform brightness (light or dark mode).
  final brightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  if (brightness == Brightness.dark) {
    // If the brightness is dark, set the app theme to dark mode.
    AppTheme.setDarkMode();
  } else {
    // Otherwise and as a fallback, set the app theme to light mode.
    AppTheme.setLightMode();
  }
}

/// Utility class for theme management.
class AppTheme {
  /// Provide the current app theme.
  static ThemeData get appTheme {
    return currentThemeNotifier.value[0]['appTheme'] as ThemeData;
  }

  /// Get the current dark mode status.
  static bool get isDarkMode {
    return currentThemeNotifier.value[0]['isDarkMode'] as bool;
  }

  /// Get the current light mode status.
  static bool get isLightMode {
    return !isDarkMode;
  }

  /// Get the current user light or dark mode.
  static void setInitialDisplayMode() {
    return _setInitialDisplayMode();
  }

  /// Set the app theme to light mode.
  static void setLightMode() {
    currentThemeNotifier.value = [
      {'appTheme': appThemeLight, 'isDarkMode': false},
    ];
  }

  /// Set the app theme to dark mode.
  static void setDarkMode() {
    currentThemeNotifier.value = [
      {'appTheme': appThemeDark, 'isDarkMode': true},
    ];
  }

  /// Toggle between light and dark mode.
  static void toggleMode() {
    currentThemeNotifier.value = [
      {
        'appTheme': isDarkMode ? appThemeLight : appThemeDark,
        'isDarkMode': !isDarkMode,
      },
    ];
  }
}
