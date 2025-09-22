// get_main_module_admin_app_role.dart
//

import 'package:flutter_playground/app/roles/roles.dart';

Future<AppRole?> getMainModuleAdminAppRole({required String mainModule}) async {
  // Make sure the roles data is loaded.
  if (Roles.dbRolesData == null) {
    await Roles.initDbRolesData();
  }
  List<dynamic>? roles = Roles.dbRolesData;

  // Define the permission for administrators.
  String adminPermission = mainModule == 'main' ? '*' : '$mainModule.*';

  // Get the role ID for administrators.
  Map<String, dynamic>? adminRole = roles?.firstWhere(
    (role) =>
        role['mainModuleIdTitle'] == mainModule &&
        role['isDefaultRole'] == true &&
        (role['permissions'] is List &&
            (role['permissions'] as List).contains(adminPermission)),
    orElse: () => null,
  );
  String? adminRoleId = adminRole != null ? adminRole['id'] as String? : null;
  if (adminRoleId == null) {
    return null;
  }

  // Get the [AppRole] according to the admin role ID.
  AppRole adminAppRole = Roles.getRole(roleId: adminRoleId)!;

  return adminAppRole;
}
