// app_theme_dark.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';

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
