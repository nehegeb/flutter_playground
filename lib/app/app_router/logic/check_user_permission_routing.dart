// check_user_permission_routing.dart
//

import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';

/// Checks if the user has the required permission for a module.
/// Admins have all permissions, so they can access any module.
/// Returns the redirect path if permission is denied, or null if allowed.
String? checkUserPermissionRouting(
  String? permissionName, [
  GoRouterState? state,
]) {
  // Get the currently logged in user.
  final user = User.user;

  // If the user is not logged in, redirect to the login page.
  if (user == null) {
    // Save the url the user was trying to access.
    pendingRedirectUrl = state?.uri.toString();

    return '/login';
  }

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
