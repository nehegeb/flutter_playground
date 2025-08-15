// get_permitted_modules.dart
//

import 'package:flutter_playground/app/user/user.dart';
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
    // Hidden Modules are never shown, not even to administrators.
    if (mainModuleData['isHidden'] == true) {
      return;
    }

    // Get the currently logged in user.
    final user = User.user;
    // Check if the user is an admin.
    // Admins can always access all modules.
    final userIsAdmin =
        user?.roles.contains('admin') ?? false; // TODO: Update roles.

    // Loop through all main modules.
    if (mainModuleData['isPublic'] == true || userIsAdmin) {
      final subModules =
          mainModuleData['subModules'] as Map<String, dynamic>? ?? {};
      final permittedSubModules = <Map<String, dynamic>>[];

      // Loop through all sub modules of the current main module.
      subModules.forEach((subModuleName, subModuleData) {
        if (subModuleData['isPublic'] == true || userIsAdmin) {
          permittedSubModules.add({
            'name': subModuleName,
            'isAdministrative': subModuleData['isAdministrative'] ?? false,
          });
        }
      });

      // Add the main module with its permitted sub modules and isAdministrative key.
      modulesPermitted[mainModuleName] = {
        'isAdministrative': mainModuleData['isAdministrative'] ?? false,
        'subModules': permittedSubModules,
      };
    }
  });

  // Returns a Map<String, List<String>>.
  // The first String is the main module name.
  // The List<String> contains the names of the sub modules.
  return modulesPermitted;
}
