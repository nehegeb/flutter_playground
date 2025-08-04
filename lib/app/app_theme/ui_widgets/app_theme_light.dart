// app_theme_light.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';

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
