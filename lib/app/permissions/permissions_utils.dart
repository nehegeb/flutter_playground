// permissions_utils.dart
//
// Features:
// - Provides a class [PermissionsUtils] with static methods to manipulate user permissions.

import 'package:flutter_playground/app/permissions/data/permissions_grouped_by_module.dart';
import 'package:flutter_playground/app/permissions/logic/get_main_module_from_permission.dart';
import 'package:flutter_playground/app/permissions/logic/get_sub_module_from_permission.dart';

/// Utility class for permission management.
/// Provides static methods manage the user permissions.
///
/// Static Methods:
/// - [allPermissions]: Gets all permissions of the app, as a list.
/// - [getPermissionsforModule]: Gets all permissions for a specific [AppMainModule] or [AppSubModule], as a list.
/// - [getMainModule]: Gets the main module for the given [permission].
/// - [getSubModule]: Gets the sub module for the given [permission].
class PermissionsUtils {
  /// Get all permissions as a list.
  static List<String> get allPermissions =>
      PermissionsGroupedByModule.get.values.expand((list) => list).toList();

  /// Get all permissions for a specific [AppMainModule] or [AppSubModule].
  ///
  /// Use [Permissions.forModule('main')] or [Permissions.forModule('settings.permissions')].
  static List<String> getPermissionsforModule(String module) =>
      PermissionsGroupedByModule.get[module] ?? [];

  /// Gets the main module for the given [permission].
  ///
  /// If no [permission] is given, it returns ''.
  /// If no main module is found, it always returns 'main' for the main [AppMainModule].
  static String getMainModule({required String permission}) {
    return getMainModuleFromPermission(permission: permission);
  }

  /// Gets the sub module for the given [permission].
  ///
  /// If no [permission] is given, it returns ''.
  /// If no sub module is found, it always returns 'main' for the main page of any [AppSubModule].
  static String getSubModule({required String permission}) {
    return getSubModuleFromPermission(permission: permission);
  }
}
