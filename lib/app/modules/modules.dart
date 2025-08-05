// modules.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/modules/logic/set_app_main_module.dart';
import 'package:flutter_playground/app/modules/logic/set_app_sub_module.dart';
import 'package:flutter_playground/app/modules/logic/load_modules.dart';

/// Notifier for the currently active main module.
final ValueNotifier<String> mainModuleNotifier = ValueNotifier<String>('main');

/// Notifier for the currently active sub module.
final ValueNotifier<String> subModuleNotifier = ValueNotifier<String>('home');

/// Utility class for module management.
/// Provides static methods for managing modules.
///
/// Static Methods:
/// - [mainModule]: Gets the currently active main module.
/// - [subModule]: Gets the currently active sub module.
/// - [setMainModule]: Sets the main module.
/// - [setSubModule]: Sets the sub module.
/// - [getModulesData]: Retrieves the modules information.
/// - [initModules]: Initializes the modules of the app.
class Modules {
  /// Get the main module.
  static String get mainModule {
    return mainModuleNotifier.value;
  }

  /// Get the sub module.
  static String get subModule {
    return subModuleNotifier.value;
  }

  /// Sets the main module.
  static Future<void> setMainModule({required String module}) async {
    await setAppMainModule(module: module);
  }

  /// Sets the sub module.
  static Future<void> setSubModule({required String module}) async {
    await setAppSubModule(module: module);
  }

  /// Get the main modules of the app.
  static Map<String, dynamic>? getModulesData() {
    if (modules == null) return null;
    return modules;
  }

  // /// Get the sub modules of a specific main module.
  // static Map<String, dynamic>? getMainModules() {
  //   if (modules == null) return null;
  //   return modules;
  // }

  // /// Get the sub modules of a specific main module.
  // static Map<String, dynamic>? getSubModules(String module) {
  //   if (modules == null) return null;
  //   return modules![module] as Map<String, dynamic>?;
  // }

  /// Initializes the modules for the app.
  static Future<void> initModules() async {
    // Set the initial language.
    await loadModules();
  }
}
