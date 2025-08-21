// get_user_roles.dart
//

import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/roles/roles.dart';

/// Gets the user's roles, according to their user ID.
/// Gets the user roles directly from the users data, not from the currently logged in [AppUser].
Future<List<AppRole>?> getUserRoles({required int userId}) async {
  // Load the users data, if it's not already loaded.
  // If no users data could not be loaded, return an empty list.
  bool wasAlreadyLoaded = true;
  if (User.dbUsersData == null) {
    wasAlreadyLoaded = false;
    await User.initDbUsersData();
  }
  if (User.dbUsersData == null) {
    return [];
  }

  // Get the user data according to the given [userId].
  Map<String, dynamic>? userData = User.dbUsersData
      ?.cast<Map<String, dynamic>>()
      .firstWhere((user) => user['id'] == userId, orElse: () => {});

  // Clear the users data as soon as its not needed anymore, if it was not already loaded before.
  // If it was already loaded before, it should stay in memory and be cleared later on.
  // NOTE: This is necessary to prevent unnecessary data for all users from being kept in memory.
  if (!wasAlreadyLoaded) {
    User.clearDbUsersData();
  }

  // If no data for the given [userId] is found, return an empty list.
  if (userData == null) {
    return [];
  }

  // Get the user's role IDs from the users data.
  List<int> userRoleIds = (userData['rolesIds'] as List<dynamic>).cast<int>();

  // If no role IDs are found, return an empty list.
  if (userRoleIds.isEmpty) {
    return [];
  }

  // Load the roles data, if it's not already loaded.
  // If no roles data could be loaded, return an empty list.
  if (Roles.dbRolesData == null) {
    await Roles.initDbRolesData();
  }
  if (Roles.dbRolesData == null || Roles.dbRolesData!.isEmpty) {
    return [];
  }

  // Find all [AppRole]s of the user with the given [userId].
  List<AppRole> appRoles = [];
  for (var roleData in Roles.dbRolesData!) {
    int? roleId = int.tryParse(roleData['id'].toString());
    if (roleId != null && userRoleIds.contains(roleId)) {
      appRoles.add(AppRole.fromMap(roleData));
    }
  }

  return appRoles;
}
