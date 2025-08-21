// modules.dart
//
// Displayed pages are managed by the [appRouter], yet the notifiers in this file
// are used to to keep track of which main and sub module are currently active
// and which of these the currently logged in [AppUser] has access to.
//
// Setting a [AppMainModule] or [AppSubModule] will not change the displayed page at all.

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/modules/logic/get_empty_app_main_module.dart';
import 'package:flutter_playground/app/modules/logic/get_empty_app_sub_module.dart';
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
/// - [activeMainModule]: Gets the currently active [AppMainModule].
/// - [activeSubModule]: Gets the currently active [AppSubModule].
/// - [emptyMainModule]: Gets an empty [AppMainModule].
/// - [emptySubModule]: Gets an empty [AppSubModule].
/// - [permittedMainModules]: Get the [AppMainModule]s the currently logged in [AppUser] has access to.
/// - [permittedSubModules]: Get the [AppSubModule]s the currently logged in [AppUser] has access to.
/// - [dbMainModulesData]: Get the main modules data.
/// - [dbSubModulesData]: Get the sub modules data.
/// - [getMainModule]: Gets a specific [AppMainModule] the currently logged in [AppUser] has access to, according to its name.
/// - [getSubModule]: Gets a specific [AppSubModule] the currently logged in [AppUser] has access to, according to its name.
/// - [getColor]: Gets a usable color of a specific [AppMainModule] or [AppSubModule].
/// - [setActiveMainModule]: Sets the [AppMainModule] as active, according to its name.
/// - [setActiveSubModule]: Sets the [AppSubModule] as active, according to its name.
/// - [setPermittedMainModules]: Sets the [AppMainModule]s the currently logged in [AppUser] has access to.
/// - [setPermittedSubModules]: Sets the [AppSubModule]s the currently logged in [AppUser] has access to.
/// - [clearPermittedModules]: Clears the modules to which the [AppUser] has access to.
/// - [initDbModulesData]: Initializes the modules data for the app.
/// - [clearDbModulesData]: Clears the modules data from the app.
class Modules {
  /// Get the currently active [AppMainModule].
  static AppMainModule? get activeMainModule {
    return activeMainModuleNotifier.value;
  }

  /// Get the currently active [AppSubModule].
  static AppSubModule? get activeSubModule {
    return activeSubModuleNotifier.value;
  }

  /// Get an empty [AppMainModule].
  static AppMainModule get emptyMainModule {
    return getEmptyAppMainModule();
  }

  /// Get an empty [AppSubModule].
  static AppSubModule get emptySubModule {
    return getEmptyAppSubModule();
  }

  /// Get the [AppMainModule]s the currently logged in [AppUser] has access to.
  static List<AppMainModule>? get permittedMainModules {
    return mainModulesNotifier.value;
  }

  /// Get the [AppSubModule]s the currently logged in [AppUser] has access to.
  static List<AppSubModule>? get permittedSubModules {
    return subModulesNotifier.value;
  }

  /// Get the loaded main modules data of the database.
  static List<dynamic>? get dbMainModulesData {
    return mainModulesData;
  }

  /// Get the loaded sub modules data of the database.
  static List<dynamic>? get dbSubModulesData {
    return subModulesData;
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
  static void setActiveMainModule({required String mainModule}) {
    setActiveAppMainModule(mainModule: mainModule);
  }

  /// Set the currently active [AppSubModule].
  /// It uses the name of the sub module to identify it.
  static void setActiveSubModule({
    required String mainModule,
    required String subModule,
  }) {
    setActiveAppSubModule(mainModule: mainModule, subModule: subModule);
  }

  /// Set the [AppMainModule]s the currently logged in [AppUser] has access to.
  /// This only works if the user is logged in.
  /// Returns true if it worked, otherwise false.
  static Future<bool> setPermittedMainModules() async {
    return await setAppMainModules();
  }

  /// Set the [AppSubModule]s the currently logged in [AppUser] has access to.
  /// This only works if the user is logged in.
  /// Returns true if it worked, otherwise false.
  static Future<bool> setPermittedSubModules() async {
    return await setAppSubModules();
  }

  /// Clears the modules to which the [AppUser] has access to.
  static void clearPermittedModules() {
    clearAppModules();
  }

  /// Initializes the modules data from the database for the app.
  static Future<void> initDbModulesData() async {
    await loadMainModulesData();
    await loadSubModulesData();
  }

  /// Clear the loaded modules data of the database from the app.
  static void clearDbModulesData() {
    mainModulesData = null;
    subModulesData = null;
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
  AppMainModule({
    required this.id,
    required this.idTitle,
    this.isPublic = false,
    this.isHidden = false,
    this.color,
  });

  factory AppMainModule.fromMap(Map<String, dynamic> map) {
    return AppMainModule(
      id: map['id'],
      idTitle: map['idTitle'],
      isPublic: map['isPublic'] ?? false,
      isHidden: map['isHidden'] ?? false,
      color: map['color'],
    );
  }
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
  AppSubModule({
    required this.id,
    required this.idTitle,
    required this.mainModuleIdTitle,
    this.isPublic = false,
    this.isHidden = false,
    this.color,
  });

  factory AppSubModule.fromMap(Map<String, dynamic> map) {
    return AppSubModule(
      id: map['id'],
      idTitle: map['idTitle'],
      mainModuleIdTitle: map['mainModuleIdTitle'],
      isPublic: map['isPublic'] ?? false,
      isHidden: map['isHidden'] ?? false,
      color: map['color'],
    );
  }
}
