// app_theme.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_theme/widgets/app_theme_light.dart';
import 'package:flutter_playground/app/app_theme/logic/set_app_brightness.dart';
import 'package:flutter_playground/app/app_theme/logic/set_initial_brightness.dart';

/// Defines the seed color for the app theme.
/// This color is used to generate the color scheme for both light and dark themes.
const Color seedColor = Colors.deepPurple;

/// Notifier for the currently selected app theme.
/// Defaults to light theme [ThemeData] with dark mode disabled.
///
/// Properties of the notifier list:
/// - appTheme: The current app theme [ThemeData].
/// - isDarkMode: Whether the app brightness is dark or light, as a boolean.
final ValueNotifier<List<Map<String, dynamic>>> appThemeNotifier =
    ValueNotifier<List<Map<String, dynamic>>>([
      {'appTheme': appThemeLight, 'isDarkMode': false},
    ]);

/// Utility class for theme management.
/// Provides static methods to get the current app theme and manage the brightness.
///
/// Static Methods:
/// - [appTheme]: Provides the current app theme [ThemeData].
/// - [isDarkMode]: Checks if the app is in dark mode. Returns boolean.
/// - [isLightMode]: Checks if the app is in light mode. Returns boolean.
/// - [setLightMode]: Sets the app to light mode.
/// - [setDarkMode]: Sets the app to dark mode.
/// - [toggleBrightness]: Toggles the app between light and dark mode.
/// - [initTheme]: Initializes the app theme.
class AppTheme {
  /// Provide the current app theme [ThemeData].
  static ThemeData get appTheme {
    return appThemeNotifier.value[0]['appTheme'] as ThemeData;
  }

  /// Get the current dark mode status.
  static bool get isDarkMode {
    return appThemeNotifier.value[0]['isDarkMode'] as bool;
  }

  /// Get the current light mode status.
  static bool get isLightMode {
    return !isDarkMode;
  }

  /// Set the app to light mode.
  static void setLightMode() {
    setAppBrightness(brightness: 'light');
  }

  /// Set the app to dark mode.
  static void setDarkMode() {
    setAppBrightness(brightness: 'dark');
  }

  /// Toggle between light and dark mode.
  static void toggleBrightness() {
    setAppBrightness(brightness: 'toggle');
  }

  /// Initializes the app theme.
  /// Loads the initial app brightness from the local cache
  /// or sets it based on the user's device settings.
  static Future<void> initTheme() async {
    // Set the initial app brightness (light or dark mode).
    await setInitialBrightness();
  }
}
