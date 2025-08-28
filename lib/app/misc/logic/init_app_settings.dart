// init_app_settings.dart
//

import 'package:flutter_playground/app/app_theme/app_theme.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/module_bar/module_bar_utils.dart';

/// Initializes the [MainApp] settings.
/// If the settings exist in the local cache, it sets them accordingly.
/// If the a setting cannot be determined, it defaults accordingly.
Future<bool> initAppSettings() async {
  // Initialize the supported languages of the app.
  await Localization.initDbLanguagesData();

  // Intialize the modules for the app.
  await Modules.initDbModulesData();

  // Intialize the roles for [AppUser]s.
  await Roles.initDbRolesData();

  // Initialize the [AppTheme] for the app.
  await AppTheme.initTheme();

  // Initialize the language the app displays.
  await Localization.initLanguage();

  // Initialize the [ModuleBar] of the app.
  await ModuleBarUtils.initBar();

  // Load the public modules for the app.
  await Modules.setPermittedModules();

  // NOTE: Do NOT initialize/load the users data here!
  // This will be done upon [AppUser] login and then immediately cleared afterwards.
  // This prevents unnecessary data from other users to be loaded all the time.

  // NOTE: The initialization of 'initDb...Data' might be removed when switching to a proper database.
  // The Flutter Framework Core is based on JSON files for simplicity, which have to be loaded to be used.

  // Make sure everything is done loading.
  await Future.delayed(const Duration(milliseconds: 100));

  return true;
}
