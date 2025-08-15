// get_app_user_permission_roles.dart
//

import 'package:flutter_playground/app/user/user.dart';

/// Gets the permission roles for the currently logged in [AppUser].
/// This only works if the user is logged in.
String? getAppUserPermissionRoles() {
  // Get the ID of the currently logged in [AppUser].
  // If no user is logged in, return null.
  // if (User.user == null) {
  //   return null;
  // }
  // final userId = User.user!.id;

  String roles =
      'admin'; // TODO: Gather the users permission roles from [appPermissionsNotifier].

  return roles;
}
