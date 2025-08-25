// permissions.dart
//
// Features:
// - Provides a class [Permissions] with static methods to manipulate user permissions.

import 'package:flutter_playground/app/permissions/logic/get_main_module_of_permission.dart';
import 'package:flutter_playground/app/permissions/logic/get_sub_module_of_permission.dart';
import 'package:flutter_playground/app/permissions/logic/load_permissions_data.dart';

/// Utility class for permission management.
/// Provides static methods manage the user permissions.
///
/// Static Methods:
/// - [dbPermissionsData]: Gets the permissions data.
/// - [getMainModule]: Gets the main module for the given [permission].
/// - [getSubModule]: Gets the sub module for the given [permission].
/// - [initDbPermissionsData]: Initializes the user permissions for the app.
/// - [clearDbPermissionsData]: Clears the user permissions from the app.
class Permissions {
  /// Get the loaded permissions data of the database.
  static List<dynamic>? get dbPermissionsData {
    return permissionsData;
  }

  /// Gets the main module for the given [permission].
  static String getMainModule({required String permission}) {
    return getMainModuleOfPermission(permission: permission);
  }

  /// Gets the sub module for the given [permission].
  static String getSubModule({required String permission}) {
    return getSubModuleOfPermission(permission: permission);
  }

  /// Loads the permissions data from the database for the app.
  static Future<void> initDbPermissionsData() async {
    await loadPermissionsData();
  }

  /// Clear the loaded permissions data of the database from the app.
  static void clearDbPermissionsData() {
    permissionsData = null;
  }
}
