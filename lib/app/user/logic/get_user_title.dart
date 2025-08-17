// get_user_title.dart
//

import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/roles/roles.dart';

/// Gets the user's title, according to the given [AppRoles].
String getUserTitle({required List<AppRole>? appRoles}) {
  // Initialize the role title to 'member'.
  // This is, because a title can only be displayed for logged in [AppUser]s.
  // Therefore any not logged in user is automatically a 'guest'.
  String roleTitle = 'member';

  // Get the role title ID with the highest privilegues.
  // If no app roles are given, it always keeps 'guest'.
  if (appRoles != null) {
    for (final role in appRoles) {
      // If the user has a simple '*' permission, they are an admin.
      if (role.permissions!.contains('*')) {
        roleTitle = role.idTitle;
        break;
      }

      // TODO: Implement proper user title.
      //       Right now module administrators aren't considered yet.
      //       Go through all major permissions actions in reverse order.
    }
  }

  // Get the title for the user according to the role title ID.
  String userTitle = Localization.getText('roles.$roleTitle');

  return userTitle;
}
