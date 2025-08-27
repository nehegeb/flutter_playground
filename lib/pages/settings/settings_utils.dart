// settings_utils.dart
//

import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/user/logic/get_user_roles.dart';
import 'package:flutter_playground/app/user/logic/get_user_permissions.dart';
import 'package:flutter_playground/app/modules/logic/get_sub_modules_of_main_module.dart';
import 'package:flutter_playground/app/permissions/logic/get_main_module_of_permission.dart';
import 'package:flutter_playground/app/permissions/logic/get_sub_module_of_permission.dart';
import 'package:flutter_playground/pages/settings/logic/get_modules_tab_data.dart';
import 'package:flutter_playground/pages/settings/logic/get_users_tab_data.dart';
import 'package:flutter_playground/pages/settings/logic/get_roles_tab_data.dart';
import 'package:flutter_playground/pages/settings/logic/get_active_main_module.dart';
import 'package:flutter_playground/pages/settings/logic/get_main_module_app_roles.dart';
import 'package:flutter_playground/pages/settings/logic/get_main_module_app_users.dart';

/// Utility class for settings management.
/// Provides static methods for the settings pages.
///
/// Static methods:
/// - [modulesTabData]: Gets the data for the modules settings tab.
/// - [usersTabData]: Gets the data for the users settings tab.
/// - [rolesTabData]: Gets the data for the roles settings tab.
/// - [activeMainModule]: Gets the currently active main module.
/// - [getAppRolesForMainModule]: Gets a list of all [AppRole]s for a specific [mainModule].
/// - [getAppUsersForMainModule]: Gets a list of all [AppUser]s for a specific [mainModule].
/// - [getRolesForUser]: Gets the [AppRole]s for a specific user by its [userId].
/// - [getPermissionsForUser]: Gets the permissions for a specific user by its [userId].
/// - [getSubModulesForMainModule]: Gets the sub modules for a specific main module by its [mainModule].
/// - [getMainModuleForPermission]: Gets the main module of a specific [permission].
/// - [getSubModuleForPermission]: Gets the sub module of a specific [permission].
class SettingsUtils {
  /// Get the data for the modules tab.
  static Future<List<Map<String, dynamic>>?> get modulesTabData async {
    return await getModulesTabData();
  }

  /// Get the users for the modules tab.
  static Future<List<Map<String, dynamic>>?> get usersTabData async {
    return await getUsersTabData();
  }

  /// Get the roles for the modules tab.
  static Future<List<Map<String, dynamic>>?> get rolesTabData async {
    return await getRolesTabData();
  }

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

  /// Get all the [AppRole]s of a specific user by its [userId].
  ///
  /// This is a user function that is redistributed for the [SettingsUtils] to make it easier to use.
  static Future<List<AppRole>?> getRolesForUser({required int userId}) {
    return getUserRoles(userId: userId);
  }

  /// Get all the permissions of a specific user by its [userId].
  ///
  /// This is a user function that is redistributed for the [SettingsUtils] to make it easier to use.
  static Future<List<dynamic>?> getPermissionsForUser({required int userId}) {
    return getUserPermissions(userId: userId);
  }

  /// Get all the sub modules of a specific [mainModule].
  ///
  /// This is a modules function that is redistributed for the [SettingsUtils] to make it easier to use.
  static Future<List<dynamic>?> getSubModulesForMainModule({
    required String mainModule,
  }) {
    return getSubModulesOfMainModule(mainModule: mainModule);
  }

  /// Get the main module for the given [permission].
  ///
  /// This is a permissions function that is redistributed for the [SettingsUtils] to make it easier to use.
  static String getMainModuleForPermission({required String permission}) {
    return getMainModuleOfPermission(permission: permission);
  }

  /// Get the sub module for the given [permission].
  ///
  /// This is a permissions function that is redistributed for the [SettingsUtils] to make it easier to use.
  static String getSubModuleForPermission({required String permission}) {
    return getSubModuleOfPermission(permission: permission);
  }
}
