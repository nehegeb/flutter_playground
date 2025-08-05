// app_router_utils.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_router/logic/get_main_module_localized.dart';
import 'package:flutter_playground/app/app_router/logic/get_main_module_router.dart';
import 'package:flutter_playground/app/app_router/logic/check_user_permission_routing.dart';

/// Provides access to routing information.
///
/// Static Methods:
/// - [getMainModuleTitle]: Gets the title of the current module.
/// - [getMainModule]: Gets the current main module.
/// - [checkUserPermission]: Checks if the user has the required permission for a module.
class AppRouterUtils {
  /// Get the main module title from the [appRouter].
  static String getMainModuleTitle(BuildContext context) {
    return getMainModuleLocalized(context);
  }

  /// Get the main module from the [appRouter].
  static String getMainModule(BuildContext context) {
    return getMainModuleRouter(context);
  }

  /// Check if the user has the required permission for a module.
  static String? checkUserPermission(String permissionName) {
    return checkUserPermissionRouting(permissionName);
  }
}
