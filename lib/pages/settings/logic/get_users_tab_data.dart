// get_users_tab_data.dart
//

import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/pages/settings/settings_utils.dart';

/// Get the data for the users settings tab.
Future<List<Map<String, dynamic>>?> getUsersTabData() async {
  // Get the currently active main module name for the settings.
  final String activeMainModule = SettingsUtils.activeMainModule;

  // Make sure the users data is loaded.
  if (User.dbUsersData == null) {
    await User.initDbUsersData();
  }

  // Get all [AppUser]s for the currently active main module.
  final List<AppUser>? appUsers = await SettingsUtils.getAppUsersForMainModule(
    mainModule: activeMainModule,
  );

  // Prepare the data for the users settings tab.
  final List<Map<String, dynamic>> usersTabData = [];
  for (final user in appUsers ?? []) {
    usersTabData.add({
      'name': user.name,
      'email': user.email,
      'roles': (user.roles ?? [])
          .map((role) => role?.idTitle)
          .where((idTitle) => idTitle != null && idTitle.toString().isNotEmpty)
          .map((idTitle) => idTitle.toString())
          .toList(),
      'mainModule': (user.roles ?? []).map((role) {
        if (role == null ||
            role.mainModuleIdTitle == null ||
            role.mainModuleIdTitle.toString().isEmpty) {
          return '';
        }
        return role.mainModuleIdTitle.toString();
      }).toList(),
      'subModule': (user.roles ?? []).map((role) {
        if (role == null ||
            role.subModuleIdTitle == null ||
            role.subModuleIdTitle.toString().isEmpty) {
          return '';
        }
        return role.subModuleIdTitle.toString();
      }).toList(),
    });
  }

  return usersTabData;
}
