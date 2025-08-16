// set_active_app_main_module.dart
//

import 'package:flutter_playground/app/modules/modules.dart';

/// Sets the currently active [AppMainModule] for the [activeMainModuleNotifier].
/// It uses the title ID of the main module to identify it.
/// Also sets the [AppSubModule] to the home page of the new [AppMainModule].
void setActiveAppMainModule({required String mainModule}) {
  final activeMainModule = Modules.mainModule?.idTitle;

  // Only update if the new main module is different from the active one.
  if (activeMainModule != mainModule) {
    AppMainModule? appMainModule;

    // Find the [AppMainModule] by its given title ID.
    // Searches the [mainModulesNotifier], having only modules the [AppUser] has access to.
    try {
      appMainModule = Modules.mainModules?.firstWhere(
        (module) => module.idTitle == mainModule,
      );
    } catch (e) {
      appMainModule = null;
    }

    // If a valid [AppMainModule] was found, update the active modules.
    if (appMainModule != null) {
      // Update the [activeMainModuleNotifier] with the new [AppMainModule].
      activeMainModuleNotifier.value = appMainModule;

      // Set the [AppSubModule] to the this [AppMainModule]'s home page.
      // This is done, because when the active main module changes, it always opens its home page first.
      Modules.setSubModule(mainModule: mainModule, subModule: 'home');
    } else {
      // No [AppMainModule] to which the [AppUser] has access to found.
      // Set the [activeMainModuleNotifier] and [activeSubModuleNotifier] to null.
      activeMainModuleNotifier.value = null;
      activeSubModuleNotifier.value = null;
    }
  }
}
