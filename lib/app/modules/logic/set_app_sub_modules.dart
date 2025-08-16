// set_app_sub_modules.dart
//

import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/modules/logic/load_sub_modules_data.dart';

/// Sets all [AppSubModule]s for which the [AppUser] has access permission for the [subModulesNotifier].
/// This will be called whenever the user logs in or their permissions change.
/// This only works if the user is logged in.
Future<bool> setAppSubModules() async {
  // If no user is logged in, return false.
  if (User.user == null) {
    return false;
  }

  List<AppSubModule> appSubModules = [];

  // Load the main modules data, if it's not already loaded.
  if (subModules == null) {
    await loadSubModulesData();
  }

  // Check, to which [AppSubModule]s the currently logged in [AppUser] has access to.
  if (subModules != null) {
    for (final module in subModules!) {
      final permission =
          '${module['mainModuleIdTitle']}.${module['idTitle']}.access';
      if (User.checkPermission(permission: permission)) {
        appSubModules.add(module as AppSubModule);
      }
    }
  }

  // Update the [subModulesNotifier] with the found [AppSubModule]s.
  subModulesNotifier.value = appSubModules;

  return true;
}
