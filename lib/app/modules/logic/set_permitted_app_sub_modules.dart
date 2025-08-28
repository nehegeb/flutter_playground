// set_permitted_app_sub_modules.dart
//

import 'package:flutter_playground/app/permissions/permissions.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/modules/logic/load_sub_modules_data.dart';

/// Sets all [AppSubModule]s for which the currently logged in [AppUser] has access permission.
/// If no [AppUser] is currently logged in, set only the [AppSubModule]s with [isPublic] set to true.
/// This will update the [subModulesNotifier].
///
/// Returns true if it worked, otherwise false.
Future<bool> setPermittedAppSubModules() async {
  List<AppSubModule> appSubModules = [];

  // Load the main modules data, if it's not already loaded.
  if (Modules.dbSubModulesData == null) {
    await loadSubModulesData();
  }

  // Check, to which [AppSubModule]s the currently logged in [AppUser] has access to.
  if (Modules.dbSubModulesData != null) {
    // If an [AppUser] is currently logged in
    // check, to which [AppSubModule]s the currently logged in [AppUser] has access to.
    if (User.user != null) {
      for (final module in Modules.dbSubModulesData!) {
        final permission =
            '${module['mainModuleIdTitle']}.${module['idTitle']}.access';
        if (Permissions.check(permission: permission)) {
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

    // If no [AppUser] is currently logged in
    // check, which [AppSubModule]s have their [isPublic] attribute set to true.
    if (User.user == null) {
      for (final module in Modules.dbSubModulesData!) {
        if (module['isPublic']) {
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
  }

  // Update the [subModulesNotifier] with the found [AppSubModule]s.
  if (appSubModules.isNotEmpty) {
    subModulesNotifier.value = appSubModules;
    return true;
  } else {
    subModulesNotifier.value = List<AppSubModule>.empty();
    return false;
  }
}
