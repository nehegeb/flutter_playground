// role.dart
//

import 'package:flutter_playground/app/roles/logic/load_roles_data.dart';

/// Utility class for roles management.
/// Provides static methods manage the user roles.
///
/// Static Methods:
/// - [initRoles]: Initializes the user roles for the app.
class Roles {
  /// Loads the roles data from the JSON files.
  static Future<void> initRoles() async {
    await loadRolesData();
  }
}
