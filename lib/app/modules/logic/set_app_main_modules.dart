// set_app_main_modules.dart
//

import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/modules/logic/load_main_modules_data.dart';

/// Sets all [AppMainModule]s for which the [AppUser] has access permission for the [mainModulesNotifier].
/// This will be called whenever the user logs in or their permissions change.
/// This only works if the user is logged in.
Future<bool> setAppMainModules() async {
  // If no user is logged in, return false.
  if (User.user == null) {
    return false;
  }

  List<AppMainModule> appMainModules = [];

  // Load the main modules data, if it's not already loaded.
  if (mainModules == null) {
    await loadMainModulesData();
  }

  // Check, to which [AppMainModule]s the currently logged in [AppUser] has access to.
  if (mainModules != null) {
    for (final module in mainModules!) {
      final permission = '${module['idTitle']}.access';
      if (User.checkPermission(permission: permission)) {
        appMainModules.add(module as AppMainModule);
      }
    }
  }

  // Update the [mainModulesNotifier] with the found [AppMainModule]s.
  mainModulesNotifier.value = appMainModules;

  return true;
}
