// check_app_user_permission.dart
//

import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/user/user.dart';

/// Checks if the currently logged in [AppUser] has the given [permission].
///
/// It first checks the modules [isHidden] and [isPublic] parameters.
/// It then checks the [AppUser]'s [AppRole]s against the given [permission].
/// If no [AppUser] is currently logged in, it'll only check the modules and then returns false.
///
/// Returns true if the [AppUser] has permission, otherwise false.
///
/// NOTE: Only if the modules data has already been loaded, otherwise it returns false!
bool checkAppUserPermission({required String? permission}) {
  // If no [permission] is given, return false.
  if (permission == null || permission.isEmpty) {
    return false;
  }

  // CHECK MODULES

  // If the modules data has not yet been loaded, return false.
  if (Modules.dbMainModulesData == null || Modules.dbSubModulesData == null) {
    return false;
  }

  // Get the main and sub module from the given [permission].
  List<String> permissionParts = permission.split('.');
  String permissionMainModule = '';
  if (permissionParts.length > 1) {
    permissionMainModule = permissionParts[0];
  }
  String permissionSubModule = '';
  if (permissionParts.length > 2) {
    permissionSubModule = permissionParts[1];
  }

  // Check for the [isHidden] and [isPublic] parameters of the [AppMainModule].
  // This MUST NOT be done if the given [permission] is about the "main" main modules.
  // This is, because all pages of the "main" main module are not treated as proper [AppMainModule]s.
  if (permissionMainModule.isNotEmpty &&
      permissionMainModule != 'main' &&
      permissionMainModule != 'home') {
    final appMainModule = Modules.dbMainModulesData?.firstWhere(
      (module) => module['idTitle'] == permissionMainModule,
      orElse: () => null,
    );

    // Check for the [isHidden] parameter of the given [AppMainModule].
    // If the main module is hidden, return false.
    if (appMainModule == null || appMainModule['isHidden']) {
      return false;
    }

    // Check for the [isPublic] parameter of the given [AppMainModule].
    if (appMainModule == null || appMainModule['isPublic']) {
      String permissionCheck = '';

      // If the main module is public and
      // the permission is for access to that specific module, always grant access.
      permissionCheck = '$permissionMainModule.access';
      if (permission == permissionCheck) {
        return true;
      }

      // If the main module is public and
      // the permission is for read on that specific module, always grant access.
      permissionCheck = '$permissionMainModule.read';
      if (permission == permissionCheck) {
        return true;
      }
    }
  }

  // Check for the [isHidden] and [isPublic] parameters of the [AppSubModule].
  if (permissionSubModule.isNotEmpty) {
    final appSubModule = Modules.dbSubModulesData?.firstWhere(
      (module) =>
          module['idTitle'] == permissionSubModule &&
          module['mainModuleIdTitle'] == permissionMainModule,
      orElse: () => null,
    );

    // Check for the [isHidden] parameter of the given [AppSubModule].
    // If the sub module is hidden, return false.
    if (appSubModule == null || appSubModule['isHidden']) {
      return false;
    }

    // Check for the [isPublic] parameter of the given [AppSubModule].
    if (appSubModule == null || appSubModule['isPublic']) {
      String permissionCheck = '';

      // If the sub module is public and
      // the permission is for access to that specific module, always grant access.
      permissionCheck = '$permissionMainModule.$permissionSubModule.access';
      if (permission == permissionCheck) {
        return true;
      }

      // If the sub module is public and
      // the permission is for read on that specific module, always grant access.
      permissionCheck = '$permissionMainModule.$permissionSubModule.read';
      if (permission == permissionCheck) {
        return true;
      }
    }
  }

  // CHECK USER

  // If no [AppUser] is logged in, return false.
  if (User.user == null) {
    return false;
  }

  // Get all [AppRole]s of the [AppUser].
  List<AppRole>? userRoles = User.user!.roles;

  // Check, if the [AppUser] has any [AppRole]s assigned.
  if (userRoles == null || userRoles.isEmpty) {
    return false;
  }

  // Collect all permissions from the [AppUser]'s roles into a list of strings.
  // Generates a set that contains all unique permissions of the currently logged in [AppUser].
  final userPermissions = userRoles
      .expand((role) => role.permissions ?? [])
      .map((perm) => perm.trim())
      .where((perm) => perm.isNotEmpty)
      .toSet();

  // If the [AppUser] has a simple '*' permission, always grant full app access.
  // This is, because a simple '*' permission is treated as an administrator for the whole app.
  if (userPermissions.contains('*')) {
    return true;
  }

  // If the [AppUser] has a '.*' for the permission context, always grant context access.
  // This is, because a '.*' permission is treated as an administrator for the module specified before the dot.
  final permissionContext = permission.contains('.')
      ? permission.substring(0, permission.lastIndexOf('.'))
      : '';
  if (userPermissions.contains('$permissionContext.*')) {
    return true;
  }

  // If the [AppUser] has the exact given [permission], grant access.
  if (userPermissions.contains(permission)) {
    return true;
  }

  // END

  // If none of the above conditions are met, the user does not have permission.
  return false;
}
