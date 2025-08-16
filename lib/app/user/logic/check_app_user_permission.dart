// check_app_user_permission.dart
//

import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/roles/roles.dart';

/// Checks if the [AppUser] has permission for something.
/// This only works if the user is logged in.
/// It checks the user's roles against the requested permission.
/// Returns true if the user has permission, otherwise false.
bool checkAppUserPermission({required String? permission}) {
  // If no user is logged in, return false.
  if (User.user == null) {
    return false;
  }

  // If no permission is specified, return false.
  if (permission == null || permission.isEmpty) {
    return false;
  }

  // TODO: Check for public modules. Always grants .access and .read, but nothing more.
  // TODO: Check for hidden modules. Always returns false.

  // Get all roles of the [AppUser].
  List<AppRole>? userRoles = User.user!.roles;

  // Check, if the [AppUser] has any [AppRole]s assigned.
  if (userRoles == null || userRoles.isEmpty) {
    return false;
  }

  // Collect all permissions from the [AppUser]'s roles into a list of strings.
  // Generates a set that contains all unique permissions.
  final userPermissions = userRoles
      .expand((role) => role.permissions!.split(','))
      .map((perm) => perm.trim())
      .where((perm) => perm.isNotEmpty)
      .toSet();

  // If the [AppUser] has a '*' permission, always grant full app access.
  if (userPermissions.contains('*')) {
    return true;
  }

  // If the [AppUser] has a '*' for the permission context, always grant context access.
  final permissionContext = permission.contains('.')
      ? permission.substring(0, permission.lastIndexOf('.'))
      : '';
  if (userPermissions.contains('$permissionContext.*')) {
    return true;
  }

  // If the [AppUser] has the exact given permission, grant access.
  if (userPermissions.contains(permission)) {
    return true;
  }

  // If none of the above conditions are met, the user does not have permission.
  return false;
}
