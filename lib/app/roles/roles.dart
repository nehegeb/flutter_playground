// role.dart
//

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

  /// Get the roles data of the database.
  static List<dynamic>? get dbRolesData {
    return rolesData;
  }

  /// Loads the roles data from the JSON files.
  static Future<void> initDbRolesData() async {
    await loadRolesData();
  }

  /// Clear the roles data of the database from the app.
  static void clearDbRolesData() {
    rolesData = null;
  }
}

/// A role of the app.
///
/// Arguments:
/// - [id]: The unique identifier of the role, as an integer.
/// - [idTitle]: The unique title of the role, as a string.
/// - [isImmutable]: Whether the role is immutable or not. If true, this role cannot be modified.
/// - [permissions]: A list of permissions granted to this role, as strings.
class AppRole {
  final int id;
  final String idTitle;
  final bool isImmutable;
  final List<String>? permissions;
  AppRole({
    required this.id,
    required this.idTitle,
    this.isImmutable = false,
    this.permissions = const [],
  });

  factory AppRole.fromMap(Map<String, dynamic> map) {
    return AppRole(
      id: map['id'] is int ? map['id'] : int.tryParse(map['id'].toString()),
      idTitle: map['idTitle'],
      isImmutable: map['isImmutable'] ?? false,
      permissions: List<String>.from(map['permissions'] ?? []),
    );
  }
}
