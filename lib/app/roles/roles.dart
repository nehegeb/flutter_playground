// role.dart
//
// Features:
// - Provides a class [Roles] with static methods to manipulate [AppRole].
// - Provides a class for [AppRole].

import 'package:flutter_playground/app/roles/logic/get_empty_app_role.dart';
import 'package:flutter_playground/app/roles/logic/load_roles_data.dart';

/// Utility class for roles management.
/// Provides static methods manage the user roles.
///
/// Static Methods:
/// - [emptyRole]: Gets an empty [AppRole].
/// - [dbRolesData]: Gets the roles data.
/// - [initDbRolesData]: Initializes the user roles for the app.
/// - [clearDbRolesData]: Clears the roles data from the app.
class Roles {
  /// Get an empty [AppRole].
  static AppRole get emptyRole {
    return getEmptyAppRole();
  }

  /// Get the loaded roles data of the database.
  static List<dynamic>? get dbRolesData {
    return rolesData;
  }

  /// Loads the roles data from the database for the app.
  static Future<void> initDbRolesData() async {
    await loadRolesData();
  }

  /// Clear the loaded roles data of the database from the app.
  static void clearDbRolesData() {
    rolesData = null;
  }
}

/// A role of the app.
///
/// Arguments:
/// - [id]: The unique identifier of the role, as an UUID.
/// - [idTitle]: The unique title of the role.
/// - [isDefaultRole]: Whether this is a default role or not. If true, this role cannot be modified.
/// - [permissions]: A list of permissions granted to this role, as strings.
class AppRole {
  final String id;
  final String idTitle;
  final String mainModuleIdTitle;
  final String subModuleIdTitle;
  final bool isDefaultRole;
  final List<String>? permissions;
  AppRole({
    required this.id,
    required this.idTitle,
    required this.mainModuleIdTitle,
    required this.subModuleIdTitle,
    this.isDefaultRole = false,
    this.permissions = const [],
  });

  factory AppRole.fromMap(Map<String, dynamic> map) {
    return AppRole(
      id: map['id'],
      idTitle: map['idTitle'],
      mainModuleIdTitle: map['mainModuleIdTitle'],
      subModuleIdTitle: map['subModuleIdTitle'],
      isDefaultRole: map['isDefaultRole'] ?? false,
      permissions: List<String>.from(map['permissions'] ?? []),
    );
  }
}
