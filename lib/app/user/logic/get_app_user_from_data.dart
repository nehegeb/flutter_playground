// get_app_user_from_data.dart
//

import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/user/logic/get_user_roles.dart';

/// Gets a specific [AppUser] from the user data, according to its ID or eMail.
/// Should both [userId] and [userEmail] be given, it uses the given ID.
///
/// This only works if the users data has already been loaded, otherwise returns null.
Future<AppUser?> getAppUserFromData({String? userId, String? userEmail}) async {
  // If no [userId] or [userEmail] is provided, return null.
  if ((userId == null || userId.isEmpty) &&
      (userEmail == null || userEmail.isEmpty)) {
    return null;
  }

  // If no user data has been loaded, return null.
  if (User.dbUsersData == null) {
    return null;
  }

  Map<String, dynamic>? user;

  // Find the [AppUser] with the given [userId], if any.
  if (userId != null && userId.isNotEmpty) {
    try {
      user = User.dbUsersData?.firstWhere((user) => user['id'] == userId);
    } catch (e) {
      // If no [AppUser] could be found, return null.
      user = null;
    }
  }

  // Find the [AppUser] with the given [userEmail], if any.
  if (user == null && userEmail != null && userEmail.isNotEmpty) {
    try {
      user = User.dbUsersData?.firstWhere((user) => user['email'] == userEmail);
    } catch (e) {
      // If no [AppUser] could be found, return null.
      user = null;
    }
  }

  // If no user could be found, return null.
  if (user == null) {
    return null;
  }

  // Get the [AppUser]s [AppRole]s.
  List<AppRole>? userAppRoles = await getUserRoles(userId: user['id']);
  user['roles'] = userAppRoles;

  // Create the [AppUser] from the found data.
  AppUser appUser = AppUser.fromMap(user);

  return appUser;
}
