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

/// A role of the app.
///
/// Arguments:
/// - [id]: The unique identifier of the role, as an integer.
/// - [idTitle]: The unique title of the role, as a string.
/// - [isImmutable]: Whether the role is immutable or not. If true, this role cannot be modified.
/// - [permissions]: A comma-separated list of permissions granted to this role, as a string.
class AppRole {
  final int id;
  final String idTitle;
  final bool isImmutable;
  final String? permissions;

  AppRole({
    required this.id,
    required this.idTitle,
    required this.isImmutable,
    required this.permissions,
  });
}
