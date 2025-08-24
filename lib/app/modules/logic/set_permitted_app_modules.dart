// set_permitted_app_modules.dart
//

import 'package:flutter_playground/app/modules/logic/set_permitted_app_main_modules.dart';
import 'package:flutter_playground/app/modules/logic/set_permitted_app_sub_modules.dart';

import 'package:flutter_playground/app/modules/modules.dart';

/// Sets all modules for which the user has access permission to.
/// If no [AppUser] is currently logged in, set only the modules with [isPublic] set to true.
/// This will update the [mainModulesNotifier] and the [subModulesNotifier].
///
/// This will be called on app initialization and
/// whenever an [AppUser] logs in or out or their permissions change.
///
/// Returns true if it worked, otherwise false.
Future<bool> setPermittedAppModules() async {
  // Set the [AppMainModule]s the currently logged in [AppUser] has access to.
  // If no [AppUser] is currently logged in, only set the public [AppMainModules].
  bool isSuccess = await setPermittedAppMainModules();
  if (!isSuccess) {
    return false;
  }

  // Set the [AppSubModule]s the currently logged in [AppUser] has access to.
  // If no [AppUser] is currently logged in, only set the public [AppSubModule].
  isSuccess = await setPermittedAppSubModules();
  if (!isSuccess) {
    return false;
  }

  return true;
}
