// get_modules_tab_data.dart
//

import 'package:flutter_playground/app/app_helper/app_helper.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/modules/logic/load_main_modules_data.dart';
import 'package:flutter_playground/pages/permissions/permissions_page_utils.dart';

/// Get the data for the modules permissions tab.
Future<List<Map<String, dynamic>>?> getModulesTabData() async {
  // Make sure the main modules data is loaded.
  if (Modules.dbMainModulesData == null) {
    // Only load the main modules data.
    await loadMainModulesData();
  }

  // Get all main modules, including the 'main' main module.
  final List<dynamic> mainModules = [
    {
      'id': AppHelper.uuid,
      'idTitle': 'main',
      'isPublic': true,
      'isHidden': false,
    },
    ...?Modules.dbMainModulesData,
  ];

  // Prepare the data for the modules permissions tab.
  List<Map<String, dynamic>>? modulesTabData = [];
  for (final module in mainModules) {
    final String mainModuleId = module['id'];
    final String mainModuleName = module['idTitle'];
    final bool mainModuleIsPublic = module['isPublic'];
    final bool mainModuleIsHidden = module['isHidden'];

    // Do not add any hidden main modules.
    if (mainModuleIsHidden) {
      continue;
    }

    // Get all [AppUser]s for the current main module.
    final List<AppUser>? moduleUsers =
        await PermissionsPageUtils.getAppUsersForMainModule(
          mainModule: mainModuleName,
        );

    // Get the necessary user information.
    final Map<String, dynamic> administrators = {};
    if (moduleUsers != null) {
      for (final user in moduleUsers) {
        final String userId = user.id;
        final String userName = user.name;

        // Check, if the user is an administrator for this main module.
        final List<dynamic>? userPermissions =
            await PermissionsPageUtils.getPermissionsForUser(userId: userId);
        if (userPermissions != null &&
            userPermissions.contains('$mainModuleName.*')) {
          // Add the administrator to the user info for this main module.
          administrators[userId.toString()] = {
            'userId': userId,
            'userName': userName,
          };
        }
      }
    }

    modulesTabData.add({
      'moduleId': mainModuleId,
      'moduleName': mainModuleName,
      'moduleIsPublic': mainModuleIsPublic,
      'users': administrators,
    });
  }

  return modulesTabData;
}
