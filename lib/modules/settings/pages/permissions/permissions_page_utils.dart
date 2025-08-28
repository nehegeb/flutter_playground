// permissions_page_utils.dart
//

import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/user/logic/get_user_roles.dart';
import 'package:flutter_playground/app/user/logic/get_user_permissions.dart';
import 'package:flutter_playground/app/modules/logic/get_sub_modules_of_main_module.dart';
import 'package:flutter_playground/app/permissions/logic/get_main_module_from_permission.dart';
import 'package:flutter_playground/app/permissions/logic/get_sub_module_from_permission.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/get_active_main_module.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/get_main_module_app_roles.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/get_main_module_app_users.dart';

/// Utility class for permissions management.
/// Provides static methods for the permissions pages.
///
/// Static methods:
/// - [activeMainModule]: Gets the currently active main module.
/// - [getAppRolesForMainModule]: Gets a list of all [AppRole]s for a specific [mainModule].
/// - [getAppUsersForMainModule]: Gets a list of all [AppUser]s for a specific [mainModule].
/// - [getRolesForUser]: Gets the [AppRole]s for a specific [userId].
/// - [getPermissionsForUser]: Gets the permissions for a specific [userId].
/// - [getSubModulesForMainModule]: Gets the sub modules for a specific [mainModule].
/// - [getMainModuleForPermission]: Gets the main module of a specific [permission].
/// - [getSubModuleForPermission]: Gets the sub module of a specific [permission].
class PermissionsPageUtils {
  /// Get the currently active main module.
  /// If it's null or the 'settings' main module, return 'main'.
  /// This is, because the settings [AppMainModule] belongs to the 'main' main module.
  static String get activeMainModule {
    return getActiveMainModule();
  }

  /// Get a list of all [AppRole]s for a specific [mainModule].
  /// If none are found, return null.
  static List<AppRole>? getAppRolesForMainModule({required String mainModule}) {
    return getMainModuleAppRoles(mainModule: mainModule);
  }

  /// Get a list of all [AppUser]s for a specific [mainModule].
  /// If none are found, return null.
  static Future<List<AppUser>?> getAppUsersForMainModule({
    required String mainModule,
  }) async {
    return await getMainModuleAppUsers(mainModule: mainModule);
  }

  /// Get all the [AppRole]s of a specific [userId].
  ///
  /// This is a user function that is redistributed for the [PermissionsPageUtils] to make it easier to use.
  static Future<List<AppRole>?> getRolesForUser({required String userId}) {
    return getUserRoles(userId: userId);
  }

  /// Get all the permissions of a specific [userId].
  ///
  /// This is a user function that is redistributed for the [PermissionsPageUtils] to make it easier to use.
  static Future<List<dynamic>?> getPermissionsForUser({
    required String userId,
  }) {
    return getUserPermissions(userId: userId);
  }

  /// Get all the sub modules of a specific [mainModule].
  ///
  /// This is a modules function that is redistributed for the [PermissionsPageUtils] to make it easier to use.
  static Future<List<dynamic>?> getSubModulesForMainModule({
    required String mainModule,
  }) {
    return getSubModulesOfMainModule(mainModule: mainModule);
  }

  /// Get the main module for the given [permission].
  ///
  /// This is a permissions function that is redistributed for the [PermissionsPageUtils] to make it easier to use.
  static String getMainModuleForPermission({required String permission}) {
    return getMainModuleFromPermission(permission: permission);
  }

  /// Get the sub module for the given [permission].
  ///
  /// This is a permissions function that is redistributed for the [PermissionsPageUtils] to make it easier to use.
  static String getSubModuleForPermission({required String permission}) {
    return getSubModuleFromPermission(permission: permission);
  }
}
