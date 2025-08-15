// permissions.dart
//

import 'package:flutter_playground/app/permissions/logic/load_permissions_data.dart';
import 'package:flutter_playground/app/permissions/logic/get_app_user_permission_roles.dart';

/// Utility class for permission management.
/// Provides static methods manage the user permissions.
///
/// Static Methods:
/// - [initPermissions]: Initializes the user permissions for the app.
/// - [getAppUserRoles]: Gets the roles for the currently logged in [AppUser].
class Permissions {
  /// Loads the permissions data from the JSON files.
  static Future<void> initPermissions() async {
    await loadPermissionsData();
  }

  /// Get permission roles for the [AppUser].
  /// This only works if the user is logged in.
  static String? getAppUserRoles() {
    return getAppUserPermissionRoles();
  }
}
