// get_app_main_module.dart
//

import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/modules/modules.dart';

/// Gets a specific [AppMainModule], according to its title ID.
/// It only takes [mainModule]s into account to which the currently logged in [AppUser] has access to.
/// If no [AppUser] is currently logged in, it'll be only public [AppMainModule]s.
AppMainModule? getAppMainModule({required String? mainModule}) {
  // If no [mainModule] is provided, return null.
  if (mainModule == null || mainModule.isEmpty) {
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
