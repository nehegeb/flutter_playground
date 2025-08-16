// modules.dart
//
// Displayed pages are managed by the [appRouter], yet the notifiers in this file
// are used to to keep track of which main and sub module are currently active
// and which of these the currently logged in [AppUser] has access to.
//
// Setting a [AppMainModule] or [AppSubModule] will not change the displayed page at all.

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/modules/logic/set_active_app_main_module.dart';
import 'package:flutter_playground/app/modules/logic/set_active_app_sub_module.dart';
import 'package:flutter_playground/app/modules/logic/set_app_main_modules.dart';
import 'package:flutter_playground/app/modules/logic/set_app_sub_modules.dart';
import 'package:flutter_playground/app/modules/logic/get_app_main_module.dart';
import 'package:flutter_playground/app/modules/logic/get_app_sub_module.dart';
import 'package:flutter_playground/app/modules/logic/get_module_color.dart';
import 'package:flutter_playground/app/modules/logic/clear_app_modules.dart';
import 'package:flutter_playground/app/modules/logic/load_main_modules_data.dart';
import 'package:flutter_playground/app/modules/logic/load_sub_modules_data.dart';

/// Notifier for the currently active [AppMainModule].
final ValueNotifier<AppMainModule?> activeMainModuleNotifier =
    ValueNotifier<AppMainModule?>(null);

/// Notifier for the currently active [AppSubModule].
final ValueNotifier<AppSubModule?> activeSubModuleNotifier =
    ValueNotifier<AppSubModule?>(null);

/// Notifier for the [AppMainModule]s the [AppUser] has permission for.
final ValueNotifier<List<AppMainModule>> mainModulesNotifier =
    ValueNotifier<List<AppMainModule>>([]);

/// Notifier for the [AppSubModule]s the [AppUser] has permission for.
final ValueNotifier<List<AppSubModule>> subModulesNotifier =
    ValueNotifier<List<AppSubModule>>([]);

/// Utility class for module management.
/// Provides static methods for managing modules.
///
/// Static Methods:
/// - [mainModule]: Gets the currently active [AppMainModule].
/// - [subModule]: Gets the currently active [AppSubModule].
/// - [mainModules]: Get the [AppMainModule]s the currently logged in [AppUser] has access to.
/// - [subModules]: Get the [AppSubModule]s the currently logged in [AppUser] has access to.
/// - [getMainModule]: Gets a specific [AppMainModule] the currently logged in [AppUser] has access to, according to its name.
/// - [getSubModule]: Gets a specific [AppSubModule] the currently logged in [AppUser] has access to, according to its name.
/// - [getColor]: Gets a usable color of a specific [AppMainModule] or [AppSubModule].
/// - [setMainModule]: Sets the [AppMainModule] as active, according to its name.
/// - [setSubModule]: Sets the [AppSubModule] as active, according to its name.
/// - [setMainModules]: Sets the [AppMainModule]s the currently logged in [AppUser] has access to.
/// - [setSubModules]: Sets the [AppSubModule]s the currently logged in [AppUser] has access to.
/// - [clearModules]: Clears the modules to which the [AppUser] has access to.
/// - [initModules]: Initializes the modules of the app.
class Modules {
  /// Get the currently active [AppMainModule].
  static AppMainModule? get mainModule {
    return activeMainModuleNotifier.value;
  }

  /// Get the currently active [AppSubModule].
  static AppSubModule? get subModule {
    return activeSubModuleNotifier.value;
  }

  /// Get the [AppMainModule]s the currently logged in [AppUser] has access to.
  static List<AppMainModule>? get mainModules {
    return mainModulesNotifier.value;
  }

  /// Get the [AppSubModule]s the currently logged in [AppUser] has access to.
  static List<AppSubModule>? get subModules {
    return subModulesNotifier.value;
  }

  /// Get a specific [AppMainModule], according to its name.
  /// Only takes modules into account to which the currently logged in [AppUser] has access to.
  /// This only works if the user is logged in.
  static AppMainModule? getMainModule({required String? mainModule}) {
    return getAppMainModule(mainModule: mainModule);
  }

  /// Get a specific [AppSubModule], according to its name.
  /// Only takes modules into account to which the currently logged in [AppUser] has access to.
  /// This only works if the user is logged in.
  static AppSubModule? getSubModule({required String? subModule}) {
    return getAppSubModule(subModule: subModule);
  }

  /// Returns a valid color of a module.
  /// Only one [AppMainModule] OR [AppSubModule] can be given.
  /// If no valid color could been found or none or both arguments are given, it returns null.
  static Color? getColor({
    AppMainModule? appMainModule,
    AppSubModule? appSubModule,
    int shade = 500, // 500 is the default shade.
  }) {
    return getModuleColor(
      appMainModule: appMainModule,
      appSubModule: appSubModule,
      shade: shade,
    );
  }

  /// Set the currently active [AppMainModule].
  /// It uses the name of the main module to identify it.
  static void setMainModule({required String mainModule}) {
    setActiveAppMainModule(mainModule: mainModule);
  }

  /// Set the currently active [AppSubModule].
  /// It uses the name of the sub module to identify it.
  static void setSubModule({
    required String mainModule,
    required String subModule,
  }) {
    setActiveAppSubModule(mainModule: mainModule, subModule: subModule);
  }

  /// Set the [AppMainModule]s the currently logged in [AppUser] has access to.
  /// This only works if the user is logged in.
  /// Returns true if it worked, otherwise false.
  static Future<bool> setMainModules() async {
    return await setAppMainModules();
  }

  /// Set the [AppSubModule]s the currently logged in [AppUser] has access to.
  /// This only works if the user is logged in.
  /// Returns true if it worked, otherwise false.
  static Future<bool> setSubModules() async {
    return await setAppSubModules();
  }

  /// Clears the modules to which the [AppUser] has access to.
  static void clearModules() {
    clearAppModules();
  }

  /// Initializes the modules for the app.
  static Future<void> initModules() async {
    await loadMainModulesData();
    await loadSubModulesData();
  }
}

/// A main module of the app.
///
/// Arguments:
/// - [id]: The unique identifier of the main module, as an integer.
/// - [idTitle]: The unique title of the main module, as a string.
/// - [isPublic]: Whether the main module is public. If true, it will only be shown for [AppUser]s with access to it.
/// - [isHidden]: Whether the main module is hidden. If true, it won't show up for anyone.
/// - [color]: The color of the main module, used for styling purposes. If null, it uses default colors.
class AppMainModule {
  final int id;
  final String idTitle;
  final bool isPublic;
  final bool isHidden;
  final String? color;
  AppMainModule(
    this.id,
    this.idTitle,
    this.isPublic,
    this.isHidden,
    this.color,
  );
}

/// A sub module of the app.
///
/// Arguments:
/// - [id]: The unique identifer of the sub module, as an integer.
/// - [idTitle]: The unique title of the sub module, as a string.
/// - [mainModuleIdTitle]: The unique title of the [AppMainModule] the sub module belongs.
/// - [isPublic]: Whether the sub module is public. If true, it will only be shown for [AppUser]s with access to it.
/// - [isHidden]: Whether the sub module is hidden. If true, it won't show up for anyone.
/// - [color]: The color of the sub module, used for styling purposes. If null, it uses default colors.
class AppSubModule {
  final int id;
  final String idTitle;
  final String mainModuleIdTitle;
  final bool isPublic;
  final bool isHidden;
  final String? color;
  AppSubModule(
    this.id,
    this.idTitle,
    this.mainModuleIdTitle,
    this.isPublic,
    this.isHidden,
    this.color,
  );
}
