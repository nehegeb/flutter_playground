// init_app_settings.dart
//

import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';
import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/module_bar/module_bar_utils.dart';

/// Initializes the [MainApp] settings.
/// If the settings exist in the local cache, it sets them accordingly.
/// If the a setting cannot be determined, it defaults accordingly.
Future<bool> initAppSettings() async {
  // Initialize the app language.
  await Localization.initLanguage();

  // Initialize the app theme.
  await AppTheme.initTheme();

  // Intialize the modules.
  await Modules.initModules();

  // Initialize the [ModuleBar].
  await ModuleBarUtils.initBar();

  // Make sure everything is done loading.
  await Future.delayed(const Duration(milliseconds: 100));

  return true;
}
