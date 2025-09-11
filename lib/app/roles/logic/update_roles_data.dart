// update_roles_data.dart
//
// This updates the roles data in a JSON file.
// NOTE: This must be read and write, because the data might change during runtime.
// NOTE: This won't work for web apps, because web apps cannot access local files!
//
// DEV: For web apps, the JSON file needs to be outsourced into a proper database!

import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_playground/app/app_router/app_router.dart';
import 'package:flutter_playground/app/app_helper/app_helper.dart';
import 'package:flutter_playground/app/roles/roles.dart';

/// Update the entry in the roles data JSON file by the roles ID.
///
/// If no [id] is given, it assumes this is a new role for the app and adds it.
///
/// If [doDelete] is true, it deletes the role with the given [id].
///
/// Returns true if the update was successful, false otherwise.
Future<bool> updateRolesData({
  String? id,
  String? idTitle,
  String? mainModuleIdTitle,
  String? subModuleIdTitle,
  List<String>? permissions,
  bool doDelete = false,
  bool isNewRole = false,
}) async {
  if (kIsWeb) {
    // Web apps cannot access local files! Remove this exception after switching to a proper database.
    appRouter.go('/500-internal-server-error');
    throw Exception('Web platform is not supported for "dart:io".');
  }

  // Define default values if not provided.
  id ??= '';
  idTitle ??= '';
  mainModuleIdTitle ??= '';
  subModuleIdTitle ??= '';
  permissions ??= [];
  bool isDefaultRole = false; // Default roles cannot be updated.

  // Load the roles data to make sure it's the most current version.
  await Roles.initDbRolesData();

  isNewRole = (id == '' || isNewRole) ? true : false;
  bool rolesDataUpdated = false;

  // If [doDelete] is true, delete the role with the given [id].
  if (doDelete && isNewRole == false) {
    Roles.dbRolesData!.removeWhere((role) => role['id'] == id);
    rolesDataUpdated = true;
  }

  // If the given [id] already exists in the roles data, return false.
  if (isNewRole) {
    // Check, if the role already exists in the roles data.
    final existingRole = Roles.dbRolesData!.firstWhere(
      (role) => role['id'] == id,
      orElse: () => null,
    );

    // If the given [id] already exists in the roles data, return false.
    if (existingRole != null) {
      return false;
    }

    // Add the new role to the roles data.
    final newRole = {
      'id': id.isNotEmpty ? id : AppHelper.uuid,
      'idTitle': idTitle,
      'mainModuleIdTitle': mainModuleIdTitle,
      'subModuleIdTitle': subModuleIdTitle,
      'isDefaultRole': isDefaultRole,
      'permissions': permissions.isNotEmpty ? permissions : [],
    };
    Roles.dbRolesData!.add(newRole);

    rolesDataUpdated = true;
  }

  // If its a KNOWN ROLE, update the given values for the role ID in the roles data.
  if (!isNewRole && doDelete == false) {
    for (var role in Roles.dbRolesData!) {
      if (role['id'] == id) {
        idTitle = idTitle != null && idTitle.isNotEmpty
            ? idTitle
            : role['idTitle'];
        mainModuleIdTitle =
            mainModuleIdTitle != null && mainModuleIdTitle.isNotEmpty
            ? mainModuleIdTitle
            : role['mainModuleIdTitle'];
        subModuleIdTitle =
            subModuleIdTitle != null && subModuleIdTitle.isNotEmpty
            ? subModuleIdTitle
            : role['subModuleIdTitle'];
        isDefaultRole = role['isDefaultRole'] as bool? ?? isDefaultRole;
        permissions = permissions != null && permissions.isNotEmpty
            ? permissions
            : role['permissions'] ?? [];

        role['idTitle'] = idTitle;
        role['mainModuleIdTitle'] = mainModuleIdTitle;
        role['subModuleIdTitle'] = subModuleIdTitle;
        role['isDefaultRole'] = isDefaultRole;
        role['permissions'] = permissions;

        rolesDataUpdated = true;
        break;
      }
    }
  }

  // If the roles data has been updated
  // save the updated roles data back to the JSON file.
  if (rolesDataUpdated) {
    final file = File('lib/app/roles/data/roles.json');
    final jsonString = jsonEncode(Roles.dbRolesData);
    await file.writeAsString(jsonString);
  } else {
    // No changes made to the roles data.
    return false;
  }

  return true;
}
