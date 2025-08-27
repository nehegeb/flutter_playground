// get_main_module_app_users.dart
//

import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/pages/settings/settings_utils.dart';

/// Get a list of all [AppUser]s for a specific [mainModule].
/// If none are found, return null.
Future<List<AppUser>?> getMainModuleAppUsers({
  required String mainModule,
}) async {
  // If no [mainModule] is given, return null.
  if (mainModule.isEmpty) return null;

  // Get all valid [AppRole]s for the given [mainModule].
  final List<AppRole>? validAppRoles = SettingsUtils.getAppRolesForMainModule(
    mainModule: mainModule,
  );

  // Make sure the users data is loaded.
  if (User.dbUsersData == null) {
    await User.initDbUsersData();
  }

  // Return a list of all [AppUser]s for the currently active main module.
  final List<dynamic>? users = User.dbUsersData;
  if (users != null) {
    List<AppUser> filteredAppUsers = [];
    for (var user in users) {
      List<AppRole>? appRoles = await SettingsUtils.getRolesForUser(
        userId: user['id'],
      );

      // Only keep [AppRole]s that are valid for the currently active module.
      if (appRoles != null && validAppRoles != null) {
        appRoles = appRoles
            .where(
              (role) =>
                  validAppRoles.any((validRole) => validRole.id == role.id),
            )
            .toList();
      } else {
        appRoles ??= [];
      }

      // If no valid [AppRole]s are found, skip this user.
      if (appRoles.isEmpty) {
        continue;
      }

      // Add the found [AppUser].
      filteredAppUsers.add(
        AppUser.fromMap({
          'id': user['id'],
          'email': user['email'],
          'name': user['name'],
          'title': '',
          'passwordHash': '',
          'passwordSalt': '',
          'roles': appRoles,
        }),
      );
      // }
    }
    return filteredAppUsers;
  }

  // If no [AppUser]s are found, return null.
  return null;
}
