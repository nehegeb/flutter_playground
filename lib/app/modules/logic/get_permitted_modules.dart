// get_permitted_modules.dart
//

import 'package:flutter_playground/app/modules/modules.dart';

/// Get only permitted modules data for the current user.
Map<String, dynamic>? getPermittedModules() {
  // Get the complete modules data.
  final modulesData = Modules.getModulesData();

  // Make sure modulesData is valid.
  if (modulesData == null || modulesData.isEmpty) {
    return null;
  }

  final Map<String, dynamic> modulesPermitted = {};

  // Loop through all main modules.
  modulesData.forEach((mainModuleName, mainModuleData) {
    if (mainModuleData['isPublic'] == true) {
      final subModules =
          mainModuleData['subModules'] as Map<String, dynamic>? ?? {};
      final permittedSubModules = <String>[];

      // Loop through all sub modules of the current main module.
      subModules.forEach((subModuleName, subModuleData) {
        if (subModuleData['isPublic'] == true) {
          permittedSubModules.add(subModuleName);
        }
      });

      // Add the main module with its permitted sub modules.
      modulesPermitted[mainModuleName] = permittedSubModules;
    }
  });

  // Returns a Map<String, List<String>>.
  // The first String is the main module name.
  // The List<String> contains the names of the sub modules.
  return modulesPermitted;
}
