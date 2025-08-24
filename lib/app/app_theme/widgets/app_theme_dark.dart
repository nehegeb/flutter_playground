// app_theme_dark.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';

/// Global dark app theme.
/// The [seedColor] is defined in [app_theme.dart].
final ThemeData appThemeDark = (() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
  );

  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    useMaterial3: true,
    scaffoldBackgroundColor: Color.alphaBlend(Colors.black87, Colors.grey),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: seedColor),
  );
})();
