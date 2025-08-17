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
  if (Modules.dbSubModulesData == null) {
    await loadSubModulesData();
  }

  // Check, to which [AppSubModule]s the currently logged in [AppUser] has access to.
  if (Modules.dbSubModulesData != null) {
    for (final module in Modules.dbSubModulesData!) {
      final permission =
          '${module['mainModuleIdTitle']}.${module['idTitle']}.access';
      if (User.checkPermission(permission: permission)) {
        AppSubModule appSubModule = AppSubModule(
          id: module['id'],
          idTitle: module['idTitle'],
          mainModuleIdTitle: module['mainModuleIdTitle'],
          isPublic: module['isPublic'],
          isHidden: module['isHidden'],
          color: module['color'],
        );
        appSubModules.add(appSubModule);
      }
    }
  }

  // Update the [subModulesNotifier] with the found [AppSubModule]s.
  subModulesNotifier.value = appSubModules;

  return true;
}
