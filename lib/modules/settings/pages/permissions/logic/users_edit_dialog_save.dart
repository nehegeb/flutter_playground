// users_edit_dialog_save.dart
//

import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/user/logic/update_users_data.dart';

Future<void> usersEditDialogSave({
  required Map<String, dynamic> userData,
}) async {
  // Make sure, the users data is loaded.
  // It should already be loaded, because it has been used multiple times
  // within the [UsersEditDialog] till now. So this shouldn't trigger.
  if (User.dbUsersData == null) {
    await User.initDbUsersData();
  }

  // Get the [AppUser] being edited.
  AppUser appUser = userData['appUser'] as AppUser;

  // ADD ROLES.

  // Get all [AppRole]s added to the [AppUser].
  List<AppRole>? addedAppRoles = userData['addedAppRoles'] as List<AppRole>?;

  // Add the new roles to the [AppUser].
  if (addedAppRoles != null && addedAppRoles.isNotEmpty) {
    List<AppRole>? userRoles = appUser.roles ?? [];
    // Add only roles that the user doesn't already have.
    List<AppRole> newRoles = addedAppRoles
        .where(
          (newRole) => !userRoles.any((userRole) => userRole.id == newRole.id),
        )
        .toList();
    List<AppRole> updatedUserRoles = [...userRoles, ...newRoles];
    appUser.roles = updatedUserRoles;

    // Update the user in the users data.
    await updateUsersData(
      id: appUser.id,
      email: appUser.email,
      name: appUser.name,
      passwordHash: appUser.passwordHash,
      passwordSalt: appUser.passwordSalt,
      rolesIds: appUser.roles!.map((role) => role.id).toList(),
    );
  }

  // DELETE ROLES.

  // Get all role IDs deleted from the [AppUser].
  List<String>? deletedRoleIds = userData['deletedRoleIds'] as List<String>?;

  // Remove the deleted roles from the [AppUser].
  if (deletedRoleIds != null && deletedRoleIds.isNotEmpty) {
    List<AppRole>? userRoles = appUser.roles ?? [];
    // Remove only roles that the user currently has.
    List<AppRole> updatedUserRoles = userRoles
        .where((userRole) => !deletedRoleIds.contains(userRole.id))
        .toList();
    appUser.roles = updatedUserRoles;

    // Update the user in the users data.
    await updateUsersData(
      id: appUser.id,
      email: appUser.email,
      name: appUser.name,
      passwordHash: appUser.passwordHash,
      passwordSalt: appUser.passwordSalt,
      rolesIds: appUser.roles!.map((role) => role.id).toList(),
    );
  }
}
