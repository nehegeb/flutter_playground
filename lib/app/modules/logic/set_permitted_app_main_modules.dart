// set_permitted_app_main_modules.dart
//

import 'package:flutter_playground/app/permissions/permissions.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/modules/logic/load_main_modules_data.dart';

/// Sets all [AppMainModule]s for which the currently logged in [AppUser] has access permission to.
/// If no [AppUser] is currently logged in, set only the [AppMainModule]s with [isPublic] set to true.
/// This will update the [mainModulesNotifier].
///
/// Returns true if it worked, otherwise false.
Future<bool> setPermittedAppMainModules() async {
  List<AppMainModule> appMainModules = [];

  // Load the main modules data, if it's not already loaded.
  if (Modules.dbMainModulesData == null) {
    await loadMainModulesData();
  }

  if (Modules.dbMainModulesData != null) {
    // If an [AppUser] is currently logged in
    // check, to which [AppMainModule]s the currently logged in [AppUser] has access to.
    if (User.user != null) {
      for (final module in Modules.dbMainModulesData!) {
        final permission = '${module['idTitle']}.access';
        if (Permissions.check(permission: permission)) {
          AppMainModule appMainModule = AppMainModule.fromMap(module);
          appMainModules.add(appMainModule);
        }
      }
    }

    // If no [AppUser] is currently logged in
    // check, which [AppMainModule]s have their [isPublic] attribute set to true.
    if (User.user == null) {
      for (final module in Modules.dbMainModulesData!) {
        if (module['isPublic']) {
          AppMainModule appMainModule = AppMainModule.fromMap(module);
          appMainModules.add(appMainModule);
        }
      }
    }
  }

  // Update the [mainModulesNotifier] with the found [AppMainModule]s.
  if (appMainModules.isNotEmpty) {
    mainModulesNotifier.value = appMainModules;
    return true;
  } else {
    mainModulesNotifier.value = List<AppMainModule>.empty();
    return false;
  }
}
