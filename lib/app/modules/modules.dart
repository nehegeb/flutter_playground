// modules.dart
//
// Displayed pages are managed by the [appRouter], yet the notifiers in this file
// are used to to keep track of which main and sub module are currently active
// and which of these the [AppUser] has access to.
//
// Setting a [AppMainModule] or [AppSubModule] here will not change the displayed page at all.
//
// Features:
// - Provides a class [Modules] with static methods to manipulate [AppMainModule] and [AppSubModule].
// - Provides a class for [AppMainModule] and one for [AppSubModule].

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/modules/logic/get_empty_app_main_module.dart';
import 'package:flutter_playground/app/modules/logic/get_empty_app_sub_module.dart';
import 'package:flutter_playground/app/modules/logic/set_active_app_main_module.dart';
import 'package:flutter_playground/app/modules/logic/set_active_app_sub_module.dart';
import 'package:flutter_playground/app/modules/logic/get_app_main_module_from_data.dart';
import 'package:flutter_playground/app/modules/logic/get_app_sub_module_from_data.dart';
import 'package:flutter_playground/app/modules/logic/set_permitted_app_modules.dart';
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
/// - [getMainModule]: Gets a specific [AppMainModule], according to its ID or name.
/// - [getSubModule]: Gets a specific [AppSubModule], according to its ID or name.
/// - [setActiveMainModule]: Sets the [AppMainModule] as active, according to its name.
/// - [setActiveSubModule]: Sets the [AppSubModule] as active, according to its name.
/// - [setPermittedModules]: Sets the [AppMainModule]s and [AppSubModule]s as permitted modules, returns boolean.
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

  /// Get a specific [AppMainModule] from the database.
  /// It uses the ID or name of the main module to identify it.
  ///
  /// This only works if the main modules data has already been loaded, otherwise returns null.
  static AppMainModule? getMainModule({String? moduleId, String? moduleName}) {
    return getAppMainModuleFromData(moduleId: moduleId, moduleName: moduleName);
  }

  /// Get a specific [AppSubModule] from the database.
  /// It uses the ID or name of the sub module to identify it.
  ///
  /// This only works if the sub modules data has already been loaded, otherwise returns null.
  static AppSubModule? getSubModule({String? moduleId, String? moduleName}) {
    return getAppSubModuleFromData(moduleId: moduleId, moduleName: moduleName);
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

  /// Set the [AppMainModule]s and [AppSubModule]s as permitted modules.
  /// If no [AppUser] is currently logged in, set only the public [AppMainModule]s and [AppSubModule]s.
  /// Returns true if it worked, otherwise false.
  static Future<bool> setPermittedModules() async {
    return await setPermittedAppModules();
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
/// - [id]: The unique identifier of the main module, as an UUID.
/// - [idTitle]: The unique title of the main module.
/// - [isPublic]: Whether the main module is public. If true, it will only be shown for [AppUser]s with access to it.
/// - [isHidden]: Whether the main module is hidden. If true, it won't show up for anyone.
/// - [isAdministrative]: Whether the main module is administrative. If true, it will be displayed in another color.
class AppMainModule {
  String id;
  String idTitle;
  bool isPublic;
  bool isHidden;
  bool isAdministrative;
  AppMainModule({
    required this.id,
    required this.idTitle,
    this.isPublic = false,
    this.isHidden = false,
    this.isAdministrative = false,
  });

  factory AppMainModule.fromMap(Map<String, dynamic> map) {
    return AppMainModule(
      id: map['id'],
      idTitle: map['idTitle'],
      isPublic: map['isPublic'] ?? false,
      isHidden: map['isHidden'] ?? false,
      isAdministrative: map['isAdministrative'] ?? false,
    );
  }
}

/// A sub module of the app.
///
/// Arguments:
/// - [id]: The unique identifer of the sub module, as an UUID.
/// - [idTitle]: The unique title of the sub module.
/// - [mainModuleIdTitle]: The unique title of the [AppMainModule] the sub module belongs.
/// - [isPublic]: Whether the sub module is public. If true, it will only be shown for [AppUser]s with access to it.
/// - [isHidden]: Whether the sub module is hidden. If true, it won't show up for anyone.
/// - [isAdministrative]: Whether the sub module is administrative. If true, it will be displayed in another color.
class AppSubModule {
  String id;
  String idTitle;
  String mainModuleIdTitle;
  bool isPublic;
  bool isHidden;
  bool isAdministrative;
  AppSubModule({
    required this.id,
    required this.idTitle,
    required this.mainModuleIdTitle,
    this.isPublic = false,
    this.isHidden = false,
    this.isAdministrative = false,
  });

  factory AppSubModule.fromMap(Map<String, dynamic> map) {
    return AppSubModule(
      id: map['id'],
      idTitle: map['idTitle'],
      mainModuleIdTitle: map['mainModuleIdTitle'],
      isPublic: map['isPublic'] ?? false,
      isHidden: map['isHidden'] ?? false,
      isAdministrative: map['isAdministrative'] ?? false,
    );
  }
}
