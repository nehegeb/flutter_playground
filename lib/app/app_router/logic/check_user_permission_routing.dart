// check_user_permission_routing.dart
//

import 'package:flutter/widgets.dart';
import 'package:flutter_playground/app/permissions/permissions.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';

/// Checks if the [AppUser] has the required permission for a module.
/// Admins have all permissions, so they can access any module.
/// Returns the redirect path if permission is denied, or null if allowed.
String? checkUserPermissionRouting(
  String? permissionName,
  BuildContext? context,
) {
  // If the [AppMainModule] or [AppSubModule] is defined as [isHidden], redirect to the '404 - Not Found' page.
  if (permissionName != null) {
    // Get the main and sub module from the given [permission].
    List<String> permissionParts = permissionName.split('.');
    String permissionMainModule = '';
    if (permissionParts.length > 1) {
      permissionMainModule = permissionParts[0];
    }
    String permissionSubModule = '';
    if (permissionParts.length > 2) {
      permissionSubModule = permissionParts[1];
    }

    // Check for the [isHidden] parameter of the [AppMainModule].
    if (permissionMainModule.isNotEmpty &&
        permissionMainModule != 'main' &&
        permissionMainModule != 'home') {
      final appMainModule = Modules.dbMainModulesData?.firstWhere(
        (module) => module['idTitle'] == permissionMainModule,
        orElse: () => null,
      );

      if (appMainModule == null || appMainModule['isHidden']) {
        // Access denied. Redirect to the [ErrorNotFoundPage].
        return '/404-not-found';
      }
    }

    // Check for the [isHidden] parameter of the [AppSubModule].
    if (permissionSubModule.isNotEmpty) {
      final appSubModule = Modules.dbSubModulesData?.firstWhere(
        (module) =>
            module['idTitle'] == permissionSubModule &&
            module['mainModuleIdTitle'] == permissionMainModule,
        orElse: () => null,
      );

      if (appSubModule == null || appSubModule['isHidden']) {
        // Access denied. Redirect to the [ErrorNotFoundPage].
        return '/404-not-found';
      }
    }
  }

  // If no [AppUser] is currently logged in, only allow public modules.
  if (User.user == null) {
    // Check if the user has the required permission.
    // This should only allow .access and .read [permissionName]s to public modules.
    if (!Permissions.check(permission: permissionName)) {
      // Access denied. Redirect to the [LoginPage].
      // But save the URL the user was trying to access for redirecting after login.
      // NOTE: Alternatively, this could redirect to the [ErrorUnauthorizedPage] instead.
      AppRouterUtils.saveRedirectUrl(context);
      return '/login';
    }
  }

  // If an [AppUser] is currently logged in, check for their permissions.
  if (User.user != null) {
    // Check if the user has the required permission.
    if (!Permissions.check(permission: permissionName)) {
      // Access denied. Redirect to the [ErrorForbiddenPage].
      return '/403-forbidden';
    }
  }

  // All checks passed, no redirect needed.
  return null;
}
