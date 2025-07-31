// get_initial_language.dart
//

import 'package:flutter/material.dart';

/// Returns the initial language based on the user's device settings.
/// If the device language cannot be determined, it defaults to English.
String getInitialLanguage() {
  Locale? locale;
  try {
    locale = WidgetsBinding.instance.platformDispatcher.locale;
  } catch (_) {
    locale = null;
  }
  final languageCode = locale?.languageCode ?? 'en'; // Fallback to English.
  return languageCode;
}
