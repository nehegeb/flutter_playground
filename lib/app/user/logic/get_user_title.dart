// get_user_title.dart
//

import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/user/user.dart';

/// Gets a user's title that is shown in the [UserCard], according to the given [appRoles].
/// This only considers default [AppRole]s where its "isDefaultRole" is set to true.
///
/// If no fitting [AppRole] could be found but
/// an [AppUser] is currently logged in, it returns the localized 'noPermission' text.
/// And if no fitting [AppRole] could be found and
/// no [AppUser] is currently logged in, it returns the localized 'notLoggedIn' text.
String getUserTitle({required List<AppRole>? appRoles}) {
  String roleTitleId = '';

  // Get the role title ID with the highest privilegues.
  if (appRoles != null) {
    // Only consider default [AppRole]s.
    appRoles = appRoles.where((role) => role.isDefaultRole == true).toList();

    // Loop through all given [appRoles].
    for (final role in appRoles) {
      // If the user has a simple '*' permission, they are an administrator for the whole app.
      if (role.permissions!.contains('*')) {
        roleTitleId = role.idTitle;
        break;
      }

      // Otherwise the user is always a 'member' of the app.
      roleTitleId = 'member';
    }
  }

  // Get the localized title for the user according to the role title ID, if any.
  if (roleTitleId.isNotEmpty) {
    // A fitting [AppRole] was found, return its localized [titleId].
    return Localization.getText('roles.$roleTitleId');
  } else {
    // No fitting [AppRole] was found.
    if (User.user == null) {
      // If no [AppUser] is currently logged in, return the 'notLoggedIn' text.
      return Localization.getText('roles.notLoggedIn');
    } else {
      // If an [AppUser] is currently logged in, return the 'noPermission' text.
      return Localization.getText('roles.noPermission');
    }
  }
}
