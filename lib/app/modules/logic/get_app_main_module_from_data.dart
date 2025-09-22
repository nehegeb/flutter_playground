// get_app_main_module_from_data.dart
//

import 'package:flutter_playground/app/modules/modules.dart';

/// Gets a specific [AppMainModule] from the main modules data, according to its ID or title ID.
/// Should both [moduleId] and [moduleName] be given, it uses the given ID.
///
/// This only works if the main modules data has already been loaded, otherwise returns null.
AppMainModule? getAppMainModuleFromData({
  String? moduleId,
  String? moduleName,
}) {
  // If no [moduleId] or [moduleName] is provided, return null.
  if ((moduleId == null || moduleId.isEmpty) &&
      (moduleName == null || moduleName.isEmpty)) {
    return null;
  }

  // If no main modules data has been loaded, return null.
  if (Modules.dbMainModulesData == null) {
    return null;
  }

  Map<String, dynamic>? mainModule;

  // Find the [AppMainModule] with the given [moduleId], if any.
  if (moduleId != null && moduleId.isNotEmpty) {
    try {
      mainModule = Modules.dbMainModulesData?.firstWhere(
        (module) => module['id'] == moduleId,
      );
    } catch (e) {
      // If no [AppMainModule] could be found, return null.
      mainModule = null;
    }
  }

  // Find the [AppMainModule] with the given [moduleName], if any.
  if (mainModule == null && moduleName != null && moduleName.isNotEmpty) {
    try {
      mainModule = Modules.dbMainModulesData?.firstWhere(
        (module) => module['idTitle'] == moduleName,
      );
    } catch (e) {
      // If no [AppMainModule] could be found, return null.
      mainModule = null;
    }
  }

  // If no main module could be found, return null.
  if (mainModule == null) {
    return null;
  }

  // Create the [AppMainModule] from the found data.
  AppMainModule appMainModule = AppMainModule.fromMap(mainModule);

  return appMainModule;
}
