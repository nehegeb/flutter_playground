// set_user_title.dart
//

import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/user/logic/get_user_title.dart';

/// Sets the displayed title of the currently logged in [AppUser].
/// If no arguments are given, it uses the main app titles.
/// If the [mainModuleName] is given, it uses the titles of the [AppMainModule].
/// This only works if the user is logged in.
void setUserTitle({String? mainModuleName}) {
  List<AppRole>? titleRoles = [];
  bool hasNoTitle = false;

  // If no user is logged in, set no title.
  if (User.user == null) {
    hasNoTitle = true;
  }

  // If an [AppUser] is currently logged in, get its [AppRoles].
  if (!hasNoTitle) {
    // Get the [AppRoles] of the currently logged in [AppUser].
    final List<AppRole>? userRoles = User.user!.roles;

    // If the user does not have any [AppRole]s, set no title.
    if (userRoles == null || userRoles.isEmpty) {
      hasNoTitle = true;
      return;
    }

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
  }

  // Get the user title to display.
  String userTitle = '';
  if (!hasNoTitle) {
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
  );
  appUserNotifier.value = user;
}
