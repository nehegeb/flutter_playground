// app_router_utils.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_router/logic/get_main_module_localized.dart';
import 'package:flutter_playground/app/app_router/logic/get_main_module_router.dart';
import 'package:flutter_playground/app/app_router/logic/check_user_permission_routing.dart';
import 'package:flutter_playground/app/app_router/logic/save_pending_redirect_url.dart';
import 'package:flutter_playground/app/app_router/logic/goto_pending_redirect_url.dart';

/// Pending redirect URL for the app router.
/// This is used if a not-logged-in user tries to access a protected route.
/// If this is not null, the user will be redirected to this URL after logging in.
String? pendingRedirectUrl;

/// Utility class for [AppRouter] management.
/// Provides access to routing information.
///
/// Static Methods:
/// - [getMainModuleTitle]: Gets the localized title of the current module.
/// - [getMainModule]: Gets the current main module.
/// - [checkUserPermission]: Checks if the user has the required permission for a module.
/// - [saveRedirectUrl]: Save the current URL for later redirects.
/// - [gotoRedirectUrl]: Opens the saved redirect URL.
class AppRouterUtils {
  /// Get the localized main module title from the [appRouter].
  static String getMainModuleTitle(BuildContext context) {
    return getMainModuleLocalized(context);
  }

  /// Get the main module from the [appRouter].
  static String getMainModule(BuildContext context) {
    return getMainModuleRouter(context);
  }

  /// Check if the user has the required permission for a module.
  static String? checkUserPermission(
    String permissionName,
    BuildContext? context,
  ) {
    return checkUserPermissionRouting(permissionName, context);
  }

  /// Save the current url for later redirects.
  static void saveRedirectUrl(BuildContext? context) {
    savePendingRedirectUrl(context);
  }

  /// Opens the saved redirect URL.
  /// If none is set, go to the [HomePage].
  static void gotoRedirectUrl() {
    gotoPendingRedirectUrl();
  }
}
