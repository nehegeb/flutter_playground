// modules_edit_dialog_save.dart
//

import 'package:flutter_playground/modules/settings/pages/permissions/permissions_page_utils.dart';
import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/user/logic/update_users_data.dart';

Future<void> modulesEditDialogSave({
  required Map<String, dynamic> moduleData,
}) async {
  // Make sure, the users data is loaded.
  // It should already be loaded, because it has been used multiple times
  // within the [ModulesEditDialog] till now. So this shouldn't trigger.
  if (User.dbUsersData == null) {
    await User.initDbUsersData();
  }

  String moduleName = moduleData['appMainModule'].idTitle as String;

  // Get the [AppRole] with the admin permission for this [AppMainModule].
  AppRole? adminRole = await PermissionsPageUtils.getAdminAppRoleForMainModule(
    mainModule: moduleName,
  );
  if (adminRole == null) {
    // No admin [AppRole] could be found for the given [AppMainModule].
    // Note: This should not be the case. Make sure all [AppMainModule]s have proper default roles!
    throw Exception('No default admin role for "$moduleName" found.');
  }

  // ADD ADMINISTRATORS.

  // Get all administrator [AppUser]s added to the [AppMainModule].
  List<AppUser>? addedAppUsers = moduleData['addedAppUsers'] as List<AppUser>?;

  // Add the admin [AppRole] to the listed users.
  if (addedAppUsers != null && addedAppUsers.isNotEmpty) {
    for (AppUser appUser in addedAppUsers) {
      List<AppRole>? userRoles = appUser.roles;
      List<AppRole>? updatedUserRoles = userRoles != null
          ? userRoles + [adminRole]
          : [adminRole];
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

  // DELETE ADMINISTRATORS.

  // Get all administrator IDs deleted from the [AppMainModule].
  List<String>? deletedUserIds = moduleData['deletedUserIds'] as List<String>?;

  // Remove the admin [AppRole] from the listed users.
  if (deletedUserIds != null && deletedUserIds.isNotEmpty) {
    for (String userId in deletedUserIds) {
      AppUser? appUser = await User.getUser(userId: userId);
      if (appUser != null) {
        List<AppRole>? userRoles = appUser.roles;
        List<AppRole>? updatedUserRoles = [];
        if (userRoles != null && userRoles.isNotEmpty) {
          for (AppRole role in userRoles) {
            if (role.id != adminRole.id) {
              updatedUserRoles.add(role);
            }
          }
        }
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
  }
}
