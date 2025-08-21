// get_app_sub_module.dart
//

import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/modules/modules.dart';

/// Gets a specific [AppSubModule], according to its title ID.
/// It only takes [subModule]s into account to which the currently logged in [AppUser] has access to.
///
/// NOTE: This only works if an [AppUser] is logged in!
AppSubModule? getAppSubModule({required String? subModule}) {
  // If no [subModule] is provided, return null.
  if (subModule == null || subModule.isEmpty) {
    return null;
  }

  // If no [AppUser] is logged in, return null.
  if (User.user == null) {
    return null;
  }

  // If no [AppSubModule]s are loaded, return null.
  if (Modules.permittedSubModules == null ||
      Modules.permittedSubModules!.isEmpty) {
    return null;
  }

  // Find the [AppSubModule] with the given title ID.
  AppSubModule? appSubModule;
  try {
    appSubModule = Modules.permittedSubModules?.firstWhere(
      (module) => module.idTitle == subModule,
    );
  } catch (e) {
    // If no [AppSubModule] could be found, return null.
    appSubModule = null;
  }

  return appSubModule;
}
