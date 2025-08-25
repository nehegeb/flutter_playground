// settings_utils.dart
//

import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/user/logic/get_user_roles.dart';
import 'package:flutter_playground/app/user/logic/get_user_permissions.dart';
import 'package:flutter_playground/app/permissions/logic/get_main_module_of_permission.dart';
import 'package:flutter_playground/app/permissions/logic/get_sub_module_of_permission.dart';

/// Utility class for settings management.
/// Provides static methods for the settings pages.
///
/// Static methods:
/// - [activeMainModule]: Gets the currently active main module.
/// - [appRolesForActiveMainModule]: Gets a list of all [AppRole]s for the currently active main module.
/// - [appUsersForActiveMainModule]: Gets a list of all [AppUser]s for the currently active main module.
/// - [getRolesForUser]: Gets the [AppRole]s for a specific user by its [userId].
/// - [getPermissionsForUser]: Gets the permissions for a specific user by its [userId].
/// - [getMainModuleForPermission]: Gets the main module of a specific permission.
/// - [getSubModuleForPermission]: Gets the sub module of a specific permission.
class SettingsUtils {
  /// Get the currently active main module.
  /// If it's null or the 'settings' main module, return 'main'.
  /// This is, because the settings [AppMainModule] belongs to the 'main' main module.
  static String get activeMainModule {
    return (Modules.activeMainModule != null &&
            Modules.activeMainModule!.idTitle != 'settings')
        ? Modules.activeMainModule!.idTitle
        : 'main';
  }

  /// Get a list of all [AppRole]s for currently active main module.
  /// If none are found, return null.
  static List<AppRole>? get appRolesForActiveMainModule {
    final String activeModule = activeMainModule;

    // Return a list of all [AppRole]s for the currently active main module.
    final List<dynamic>? roles = Roles.dbRolesData;
    if (roles != null) {
      List<AppRole> filteredAppRoles = [];
      for (var role in roles) {
        // Check if the role belongs to the active main module.
        // If the main module is 'main', then the 'settings' are also included.
        // This is, because the settings belong to the 'main' main module of the app.
        if (role['mainModuleIdTitle'] == activeModule ||
            (activeModule == 'main' &&
                role['subModuleIdTitle'] == 'settings')) {
          // Add the found [AppRole].
          filteredAppRoles.add(
            AppRole.fromMap({
              'id': role['id'],
              'idTitle': role['idTitle'],
              'mainModuleIdTitle': role['mainModuleIdTitle'],
              'subModuleIdTitle': role['subModuleIdTitle'],
              'isDefaultRole': role['isDefaultRole'],
              'permissions': role['permissions'],
            }),
          );
        }
      }
      return filteredAppRoles;
    }

    // If no [AppRole]s are found, return null.
    return null;
  }

  /// Get a list of all [AppUser]s for currently active main module.
  /// If none are found, return null.
  static Future<List<AppUser>?> get appUsersForActiveMainModule async {
    final List<AppRole>? validAppRoles = appRolesForActiveMainModule;

    // Return a list of all [AppUser]s for the currently active main module.
    final List<dynamic>? users = User.dbUsersData;
    if (users != null) {
      List<AppUser> filteredAppUsers = [];
      for (var user in users) {
        List<AppRole>? appRoles = await getUserRoles(userId: user['id']);

        // Only keep [AppRole]s that are valid for the currently active module.
        if (appRoles != null && validAppRoles != null) {
          appRoles = appRoles
              .where(
                (role) =>
                    validAppRoles.any((validRole) => validRole.id == role.id),
              )
              .toList();
        } else {
          appRoles ??= [];
        }

        // If no valid [AppRole]s are found, skip this user.
        if (appRoles.isEmpty) {
          continue;
        }

        // Add the found [AppUser].
        filteredAppUsers.add(
          AppUser.fromMap({
            'id': user['id'],
            'email': user['email'],
            'name': user['name'],
            'title': '',
            'passwordHash': '',
            'passwordSalt': '',
            'roles': appRoles,
          }),
        );
        // }
      }
      return filteredAppUsers;
    }

    // If no [AppUser]s are found, return null.
    return null;
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
