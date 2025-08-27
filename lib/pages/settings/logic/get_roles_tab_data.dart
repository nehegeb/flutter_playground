// get_roles_tab_data.dart
//

import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/pages/settings/settings_utils.dart';

/// Get the data for the roles settings tab.
Future<List<Map<String, dynamic>>?> getRolesTabData() async {
  // Get the currently active main module name for the settings.
  final String activeMainModule = SettingsUtils.activeMainModule;

  // Get the [AppRole]s for the currently active main module.
  final List<AppRole>? appRoles = SettingsUtils.getAppRolesForMainModule(
    mainModule: activeMainModule,
  );

  // Prepare the data for the roles settings tab.
  final List<Map<String, dynamic>> rolesTabData = [];
  for (final role in appRoles ?? []) {
    rolesTabData.add({
      'name': role.idTitle,
      'permissions': role.permissions,
      'mainModule': role.mainModuleIdTitle,
      'subModule': role.subModuleIdTitle,
    });
  }

  return rolesTabData;
}
