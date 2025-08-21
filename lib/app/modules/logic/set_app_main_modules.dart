// set_app_main_modules.dart
//

import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/modules/logic/load_main_modules_data.dart';

/// Sets all [AppMainModule]s for which the [AppUser] has access permission to for the [mainModulesNotifier].
/// This will be called whenever an [AppUser] logs in or their permissions change.
///
/// NOTE: This only works if an [AppUser] is logged in!
Future<bool> setAppMainModules() async {
  // If no [AppUser] is logged in, return false.
  if (User.user == null) {
    return false;
  }

  List<AppMainModule> appMainModules = [];

  // Load the main modules data, if it's not already loaded.
  if (Modules.dbMainModulesData == null) {
    await loadMainModulesData();
  }

  // Check, to which [AppMainModule]s the currently logged in [AppUser] has access to.
  if (Modules.dbMainModulesData != null) {
    for (final module in Modules.dbMainModulesData!) {
      final permission = '${module['idTitle']}.access';
      if (User.checkPermission(permission: permission)) {
        AppMainModule appMainModule = AppMainModule(
          id: module['id'],
          idTitle: module['idTitle'],
          isPublic: module['isPublic'],
          isHidden: module['isHidden'],
          color: module['color'],
        );
        appMainModules.add(appMainModule);
      }
    }
  }

  // Update the [mainModulesNotifier] with the found [AppMainModule]s.
  mainModulesNotifier.value = appMainModules;

  return true;
}
