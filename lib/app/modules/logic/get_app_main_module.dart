// get_app_main_module.dart
//

import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/user/user.dart';

/// Gets a specific [AppMainModule], according to its title ID.
/// Only takes modules into account to which the currently logged in [AppUser] has access to.
/// This only works if the user is logged in.
AppMainModule? getAppMainModule({required String? mainModule}) {
  // If no main module is provided, return null.
  if (mainModule == null || mainModule.isEmpty) {
    return null;
  }

  // If no user is logged in, return null.
  if (User.user == null) {
    return null;
  }

  // If no [AppMainModule]s are loaded, return null.
  if (Modules.permittedMainModules == null ||
      Modules.permittedMainModules!.isEmpty) {
    return null;
  }

  // Find the [AppMainModule] with the given title ID.
  AppMainModule? appMainModule;
  try {
    appMainModule = Modules.permittedMainModules?.firstWhere(
      (module) => module.idTitle == mainModule,
    );
  } catch (e) {
    // If no [AppMainModule] could be found, return null.
    appMainModule = null;
  }

  return appMainModule;
}
