// set_user_title.dart
//

import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/user/logic/get_user_title.dart';

/// Sets the displayed title of the currently logged in [AppUser].
/// If no [mainModuleName] is given, it uses the main app titles.
/// Otherwise it uses the titles of the [AppMainModule].
///
/// NOTE: This only works if an [AppUser] is logged in!
void setUserTitle({String? mainModuleName}) {
  String userTitle = '';
  List<AppRole>? userRoles;

  // If an [AppUser] is currently logged in, get its [AppRoles].
  if (User.user != null) {
    userRoles = User.user!.roles;
  }

  // If the [AppUser] has any [AppRole]s, find the appropriate title.
  if (userRoles != null && userRoles.isNotEmpty) {
    List<AppRole>? titleRoles = [];

    // Check, if the [AppUser] is an administrator.
    final AppRole adminRole = userRoles.firstWhere(
      (role) => role.permissions!.contains('*'),
      orElse: () => Roles.emptyRole,
    );
    bool isAdmin = adminRole != Roles.emptyRole;

    if (isAdmin) {
      // If the [AppUser] is an administrator, use that admin [AppRole].
      titleRoles = [adminRole];
    } else {
      // If the [AppUser] has any other roles, find the appropriate title.

      // Build the permission prefix to search the correct [AppRole]s.
      // If no [mainModuleName] is given, check for all main app permissions.
      final permissionPrefix = mainModuleName ?? 'main';

      // Get only the [AppRole]s whose permissions match the permission prefix.
      titleRoles = userRoles
          .where(
            (role) => role.permissions!.any(
              (permission) => permission.startsWith(permissionPrefix),
            ),
          )
          .toList();
    }

    // Get the user title from its filtered [AppRole]s.
    userTitle = getUserTitle(appRoles: titleRoles);
  }

  // Set the title for the [AppUser].
  final AppUser user = AppUser(
    id: User.user!.id,
    email: User.user!.email,
    name: User.user!.name,
    title: userTitle, // Only set the new title.
    passwordHash: User.user!.passwordHash,
    passwordSalt: User.user!.passwordSalt,
    roles: User.user!.roles,
    permissions: User.user!.permissions,
  );
  appUserNotifier.value = user;
}
