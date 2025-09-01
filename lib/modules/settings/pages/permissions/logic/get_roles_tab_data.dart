// get_roles_tab_data.dart
//

import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/permissions_page_utils.dart';

/// Get the data for the roles permissions tab.
Future<List<Map<String, dynamic>>?> getRolesTabData() async {
  // Get the currently active main module name.
  final String activeMainModule = PermissionsPageUtils.activeMainModule;

  // Get the [AppRole]s for the currently active main module.
  final List<AppRole>? appRoles = PermissionsPageUtils.getAppRolesForMainModule(
    mainModule: activeMainModule,
  );

  // Prepare the data for the roles permissions tab.
  final List<Map<String, dynamic>> rolesTabData = [];
  for (final role in appRoles ?? []) {
    rolesTabData.add({
      'roleId': role.id,
      'name': role.idTitle,
      'isDefaultRole': role.isDefaultRole,
      'permissions': role.permissions,
      'mainModule': role.mainModuleIdTitle,
      'subModule': role.subModuleIdTitle,
    });
  }

  return rolesTabData;
}
