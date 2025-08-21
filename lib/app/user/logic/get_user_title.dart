// get_user_title.dart
//

import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/user/user.dart';

// TODO: The getUserTitle has to be revamped!
//       It should only check for the highes privilegues of standard roles ('isImmutable' == true),
//       according to the current main module or sub module the user is currently in.
//       All custom roles shouldn't be considered for this function.

/// Gets a user's title, according to the given [appRoles].
/// If no [AppUser] is logged in, it always returns the text for unauthorized users.
String getUserTitle({required List<AppRole>? appRoles}) {
  // If no [AppUser] is logged in, return unauthorized.
  if (User.user == null) {
    return Localization.getText('roles.unauthorized');
  }

  // The minimal role of any logged in [AppUser] is always at least 'member'.
  String roleTitleId = 'member';

  // Get the role title ID with the highest privilegues.
  // If no app roles are given, it always keeps the minimal role for logged in [AppUser]s.
  if (appRoles != null) {
    for (final role in appRoles) {
      // If the user has a simple '*' permission, they are an administrator.
      if (role.permissions!.contains('*')) {
        roleTitleId = role.idTitle;
        break;
      }

      // TODO: Consider all standard roles, not just 'member' and 'admin'.
    }
  }

  // Get the localized title for the user according to the role title ID.
  String userTitle = Localization.getText('roles.$roleTitleId');

  return userTitle;
}
