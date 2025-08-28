// get_main_module_app_roles.dart
//

import 'package:flutter_playground/app/roles/roles.dart';

/// Get a list of all [AppRole]s for a specific [mainModule]
/// If none are found, return null.
List<AppRole>? getMainModuleAppRoles({required String mainModule}) {
  // If no [mainModule] is given, return null.
  if (mainModule.isEmpty) return null;

  // Return a list of all [AppRole]s for the currently active main module.
  final List<dynamic>? roles = Roles.dbRolesData;
  if (roles != null) {
    List<AppRole> filteredAppRoles = [];
    for (var role in roles) {
      // Check if the role belongs to the active main module.
      // If the main module is 'main', then the 'settings' are also included.
      // This is, because the settings belong to the 'main' main module of the app.
      if (role['mainModuleIdTitle'] == mainModule ||
          (mainModule == 'main' && role['subModuleIdTitle'] == 'settings')) {
        // Add the found [AppRole].
        filteredAppRoles.add(
          AppRole.fromMap({
            'id': role['id'],
            'idTitle': role['idTitle'],
            'mainModuleIdTitle': role['mainModuleIdTitle'],
            'subModuleIdTitle': role['subModuleIdTitle'],
            'isDefaultRole': role['isDefaultRole'],
            'permissions': role['permissions'],
          }),
        );
      }
    }
    return filteredAppRoles;
  }

  // If no [AppRole]s are found, return null.
  return null;
}
