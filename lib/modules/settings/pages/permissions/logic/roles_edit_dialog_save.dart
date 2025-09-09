// roles_edit_dialog_save.dart
//

import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/roles/logic/update_roles_data.dart';

Future<void> rolesEditDialogSave({
  required Map<String, dynamic> roleData,
}) async {
  // Make sure, the roles data is loaded.
  // It should already be loaded, because it has been used multiple times
  // within the [RolesEditDialog] till now. So this shouldn't trigger.
  if (Roles.dbRolesData == null) {
    await Roles.initDbRolesData();
  }

  // Get the [AppRole] being edited.
  AppRole appRole = roleData['appRole'] as AppRole;

  // ADD PERMISSIONS.

  // Get all permissions added to the [AppRole].
  List<String>? addedPermissions =
      roleData['addedPermissions'] as List<String>?;

  // Add the new permissions to the [AppRole].
  if (addedPermissions != null && addedPermissions.isNotEmpty) {
    List<String> rolePermissions = appRole.permissions ?? [];
    // Add only permissions that the role doesn't already have.
    List<String> newPermissions = addedPermissions
        .where((newPermission) => !rolePermissions.contains(newPermission))
        .toList();
    List<String> updatedRolePermissions = [
      ...rolePermissions,
      ...newPermissions,
    ];
    appRole.permissions = updatedRolePermissions;

    // Update the role in the roles data.
    await updateRolesData(
      id: appRole.id,
      idTitle: appRole.idTitle,
      mainModuleIdTitle: appRole.mainModuleIdTitle,
      subModuleIdTitle: appRole.subModuleIdTitle,
      permissions: appRole.permissions,
    );
  }

  // DELETE PERMISSIONS.

  // Get all permissions deleted from the [AppRole].
  List<String>? deletedPermissions =
      roleData['deletedPermissions'] as List<String>?;

  // Delete the removed permissions from the [AppRole].
  if (deletedPermissions != null && deletedPermissions.isNotEmpty) {
    List<String> rolePermissions = appRole.permissions ?? [];
    // Remove only permissions that the role currently has.
    List<String> updatedRolePermissions = rolePermissions
        .where((rolePermission) => !deletedPermissions.contains(rolePermission))
        .toList();
    appRole.permissions = updatedRolePermissions;

    // Update the role in the roles data.
    await updateRolesData(
      id: appRole.id,
      idTitle: appRole.idTitle,
      mainModuleIdTitle: appRole.mainModuleIdTitle,
      subModuleIdTitle: appRole.subModuleIdTitle,
      permissions: appRole.permissions,
    );
  }
}
