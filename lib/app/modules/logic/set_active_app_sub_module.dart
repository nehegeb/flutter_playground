// set_active_app_sub_module.dart
//

import 'package:flutter_playground/app/modules/modules.dart';

/// Sets the currently active [AppSubModule] for the [activeSubModuleNotifier].
/// It uses the title ID of the sub module to identify it.
Future<void> setActiveAppSubModule({
  required String mainModule,
  required String subModule,
}) async {
  final activeSubModule = Modules.activeSubModule?.idTitle;

  // Only update if the new sub module is different from the active one.
  if (activeSubModule != subModule) {
    AppSubModule? appSubModule;

    // Find the [AppSubModule] by its given title ID and given main modules title ID.
    try {
      appSubModule = subModulesNotifier.value.firstWhere(
        (module) =>
            module.idTitle == subModule &&
            module.mainModuleIdTitle == mainModule,
      );
    } catch (e) {
      appSubModule = null;
    }

    // If no [AppSubModule] is found, get the home page of the given main modules title ID.
    try {
      appSubModule ??= subModulesNotifier.value.firstWhere(
        (module) =>
            module.idTitle == 'home' && module.mainModuleIdTitle == mainModule,
      );
    } catch (e) {
      appSubModule = null;
    }

    // If a valid [AppSubModule] was found, update the active module.
    if (appSubModule != null) {
      // Update the [activeSubModuleNotifier] with the new [AppSubModule].
      activeSubModuleNotifier.value = appSubModule;
    } else {
      // No [AppSubModule] to which the [AppUser] has access to found.
      // Set the [activeSubModuleNotifier] to null.
      activeSubModuleNotifier.value = null;
    }
  }
}
