// check_user_permission_routing.dart
//

import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';

/// Checks if the [AppUser] has the required permission for a module.
/// Admins have all permissions, so they can access any module.
/// Returns the redirect path if permission is denied, or null if allowed.
String? checkUserPermissionRouting(String? permissionName) {
  // Get the currently logged in user.
  final user = User.user;

  // If the user is not logged in, redirect to the login page.
  if (user == null) {
    // Save the url the user was trying to access.
    AppRouterUtils.saveRedirectUrl();
    return '/login';
  }

  // Check if the user has the required permission.
  // Redirect to page not found if permission is denied.
  if (!User.checkPermission(permission: permissionName)) {
    return '/page-not-found';
  }
  ; // TODO: Implement proper HTML error page.

  // All checks passed, no redirect needed.
  return null;
}
