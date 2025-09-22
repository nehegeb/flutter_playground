// users_edit_dialog_delete.dart
//

import 'package:flutter_playground/modules/settings/pages/permissions/permissions_page_utils.dart';
import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/user/logic/update_users_data.dart';

Future<void> usersEditDialogDelete({
  required String userId,
  required String mainModule,
}) async {
  // Get all roles of the given [mainModule].
  List<AppRole>? appRolesOfModule =
      PermissionsPageUtils.getAppRolesForMainModule(mainModule: mainModule);

  // Get the [AppUser] for the given [userId].
  AppUser? appUser = await User.getUser(userId: userId);

  // Remove all roles of the given [mainModule] from the user in the users data.
  List<AppRole>? userAppRolesUpdated = [];
  if (appUser != null && appRolesOfModule != null) {
    List<AppRole>? userAppRoles = appUser.roles ?? [];
    // Collect all ids of roles to remove
    final rolesToRemoveIds = appRolesOfModule.map((role) => role.id).toSet();
    // Keep only roles whose id is NOT in rolesToRemoveIds
    userAppRolesUpdated = userAppRoles
        .where((role) => !rolesToRemoveIds.contains(role.id))
        .toList();
  }

  // Update the roles of the user in the users data.
  await updateUsersData(
    id: userId,
    rolesIds: userAppRolesUpdated.map((role) => role.id).toList(),
  );
}
