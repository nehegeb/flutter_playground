// check_user_permission_routing.dart
//

import 'package:flutter_playground/app/app_user/app_user.dart';

/// Checks if the user has the required permission for a module.
/// Admins have all permissions, so they can access any module.
/// Returns the redirect path if permission is denied, or null if allowed.
String? checkUserPermissionRouting(String permissionName) {
  // If no permission is specified, no check is needed.
  if (permissionName.isEmpty) return null;

  // Get the current user from the [appUserNotifier].
  final user = appUserNotifier.value;

  // If the user is not logged in, redirect to the login page.
  if (user == null) return '/login';

  // If the user is an admin, they have all permissions.
  if (user.role == 'admin') return null;

  // Check if the user has the required permission.
  // Redirect to page not found if permission is denied.
  if (!user.permissions.contains(permissionName)) {
    return '/page-not-found';
  }

  // All checks passed, no redirect needed.
  return null;
}
