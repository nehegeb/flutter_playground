// get_app_sub_module.dart
//

import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/user/user.dart';

/// Gets a specific [AppSubModule], according to its title ID.
/// Only takes modules into account to which the currently logged in [AppUser] has access to.
/// This only works if the user is logged in.
AppSubModule? getAppSubModule({required String? subModule}) {
  // If no sub module is provided, return null.
  if (subModule == null) {
    return null;
  }

  // If no user is logged in, return null.
  if (User.user == null) {
    return null;
  }

  // If no [AppSubModule]s are loaded, return null.
  if (Modules.subModules == null || Modules.subModules!.isEmpty) {
    return null;
  }

  // Find the [AppSubModule] with the given title ID.
  final AppSubModule? appSubModule = Modules.subModules?.firstWhere(
    (module) => module.idTitle == subModule,
  );

  return appSubModule;
}
