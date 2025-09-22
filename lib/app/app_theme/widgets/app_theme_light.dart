// app_theme_light.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';

/// Global light app theme.
/// The [seedColor] is defined in [app_theme.dart].
final ThemeData appThemeLight = (() {
  final colorScheme = ColorScheme.fromSeed(seedColor: seedColor);

  return ThemeData(
    brightness: Brightness.light,
    colorScheme: colorScheme,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: seedColor),
  );
})();
