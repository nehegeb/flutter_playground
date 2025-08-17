// permissions.dart
//

import 'package:flutter_playground/app/permissions/logic/load_permissions_data.dart';

/// Utility class for permission management.
/// Provides static methods manage the user permissions.
///
/// Static Methods:
/// - [initPermissions]: Initializes the user permissions for the app.
class Permissions {
  /// Loads the permissions data from the JSON files.
  static Future<void> initPermissions() async {
    await loadPermissionsData();
  }
}
