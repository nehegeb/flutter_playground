// set_active_app_main_module.dart
//

import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/modules/modules.dart';

/// Sets the currently active [AppMainModule] for the [activeMainModuleNotifier].
/// It uses the title ID of the given [mainModule] to identify it.
///
/// Also sets the [AppSubModule] to the home page of the given [AppMainModule].
/// This is, because when switching the [AppMainModule], its home page will always open first.
///
/// NOTE: This only works if an [AppUser] is logged in!
/// This is, because this function only takes into account the [AppMainModule]s the currently logged in [AppUser] has access to.
void setActiveAppMainModule({required String mainModule}) {
  // If no [AppUser] is logged in,
  // set the [activeMainModuleNotifier] and [activeSubModuleNotifier] to null.
  if (User.user == null) {
    activeMainModuleNotifier.value = null;
    activeSubModuleNotifier.value = null;
  }

  final activeMainModule = Modules.activeMainModule?.idTitle;

  // Only update if the given [mainModule] is different from the active one.
  if (activeMainModule != mainModule) {
    AppMainModule? appMainModule;

    // If the [mainModule] is "home", set it as the active module.
    // This is a special case, as "home" is a default main module page and is not in the modules data.
    if (mainModule == 'home') {
      appMainModule = AppMainModule.fromMap({
        'id': 0,
        'idTitle': 'home',
        'isPublic': true,
        'Hidden': false,
      });
    }

    // Find the [AppMainModule] by its given title ID.
    // Searches the [mainModulesNotifier], having only modules the [AppUser] has access to.
    if (appMainModule == null) {
      try {
        appMainModule = Modules.permittedMainModules?.firstWhere(
          (module) => module.idTitle == mainModule,
        );
      } catch (e) {
        appMainModule = null;
      }
    }

    // If a valid [AppMainModule] was found, update the active modules.
    if (appMainModule != null) {
      // Update the [activeMainModuleNotifier] with the new [AppMainModule].
      activeMainModuleNotifier.value = appMainModule;

      // Set the [AppSubModule] to the this [AppMainModule]'s home page.
      // This is done, because when the active main module changes, it always opens its home page first.
      Modules.setActiveSubModule(mainModule: mainModule, subModule: 'home');
    } else {
      // No [AppMainModule] to which the [AppUser] has access to found.
      // Set the [activeMainModuleNotifier] and [activeSubModuleNotifier] to null.
      activeMainModuleNotifier.value = null;
      activeSubModuleNotifier.value = null;
    }
  }
}
