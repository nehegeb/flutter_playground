// check_user_permission_routing.dart
//

import 'package:flutter/widgets.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';

/// Checks if the [AppUser] has the required permission for a module.
/// Admins have all permissions, so they can access any module.
/// Returns the redirect path if permission is denied, or null if allowed.
String? checkUserPermissionRouting(
  String? permissionName,
  BuildContext? context,
) {
  // If no [AppUser] is currently logged in, only allow public modules.
  if (User.user == null) {
    // Check if the user has the required permission.
    // This should only allow .access and .read [permissionName]s to public modules.
    if (!User.checkPermission(permission: permissionName)) {
      // Access denied. Redirect to the login page.
      // But save the URL the user was trying to access for redirecting after login.
      AppRouterUtils.saveRedirectUrl(context);
      return '/login';
    }
  }

  // If an [AppUser] is currently logged in, check for their permissions.
  if (User.user != null) {
    // Check if the user has the required permission.
    if (!User.checkPermission(permission: permissionName)) {
      // Access denied. Redirect to the page-not-found page.
      return '/page-not-found';
    }
  }

  // TODO: Implement proper HTML error page.

  // All checks passed, no redirect needed.
  return null;
}
