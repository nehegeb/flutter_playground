// get_user_permissions.dart
//

import 'package:flutter_playground/app/user/logic/get_user_roles.dart';

/// Gets the user's permissions, according to their user ID.
Future<List<dynamic>?> getUserPermissions({required int userId}) async {
  // Get all [AppRole]s for the given [userId].
  final appRoles = await getUserRoles(userId: userId);
  if (appRoles == null) return null;

  // Generate a list of unique permissions from the users [AppRole]s.
  final permissions = appRoles.expand((role) => role.permissions ?? []).toSet();

  return permissions.toList();
}
