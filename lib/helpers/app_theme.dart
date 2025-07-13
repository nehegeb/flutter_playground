/// app_theme.dart
///
library app_theme;

import 'package:flutter/material.dart';

/// Global app theme.
final ThemeData appTheme = (() {
  // Define the seed color for the app.
  const Color seedColor = Colors.teal;

  // Define the app theme using the seed color.
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
