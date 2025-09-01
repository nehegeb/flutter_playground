// get_app_role_from_data.dart
//

import 'package:flutter_playground/app/roles/roles.dart';

/// Gets a specific [AppRole] from the roles data, according to its ID or title ID.
/// Should both [roleId] and [roleName] be given, it uses the given ID.
///
/// This only works if the roles data has already been loaded, otherwise returns null.
AppRole? getAppRoleFromData({String? roleId, String? roleName}) {
  // If no [roleId] or [roleName] is provided, return null.
  if ((roleId == null || roleId.isEmpty) &&
      (roleName == null || roleName.isEmpty)) {
    return null;
  }

  // If no roles data has been loaded, return null.
  if (Roles.dbRolesData == null) {
    return null;
  }

  Map<String, dynamic>? role;

  // Find the [AppRole] with the given [roleId], if any.
  if (roleId != null && roleId.isNotEmpty) {
    try {
      role = Roles.dbRolesData?.firstWhere((role) => role['id'] == roleId);
    } catch (e) {
      // If no [AppRole] could be found, return null.
      role = null;
    }
  }

  // Find the [AppRole] with the given [roleName], if any.
  if (role == null && roleName != null && roleName.isNotEmpty) {
    try {
      role = Roles.dbRolesData?.firstWhere(
        (role) => role['idTitle'] == roleName,
      );
    } catch (e) {
      // If no [AppRole] could be found, return null.
      role = null;
    }
  }

  // If no role could be found, return null.
  if (role == null) {
    return null;
  }

  // Create the [AppRole] from the found data.
  AppRole appRole = AppRole.fromMap(role);

  return appRole;
}
