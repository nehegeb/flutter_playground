// get_app_sub_module_from_data.dart
//

import 'package:flutter_playground/app/modules/modules.dart';

/// Gets a specific [AppSubModule] from the sub modules data, according to its ID or title ID.
/// Should both [moduleId] and [moduleName] be given, it uses the given ID.
///
/// This only works if the sub modules data has already been loaded, otherwise returns null.
AppSubModule? getAppSubModuleFromData({String? moduleId, String? moduleName}) {
  // If no [moduleId] or [moduleName] is provided, return null.
  if ((moduleId == null || moduleId.isEmpty) &&
      (moduleName == null || moduleName.isEmpty)) {
    return null;
  }

  // If no sub modules data has been loaded, return null.
  if (Modules.dbSubModulesData == null) {
    return null;
  }

  Map<String, dynamic>? subModule;

  // Find the [AppSubModule] with the given [moduleId], if any.
  if (moduleId != null && moduleId.isNotEmpty) {
    try {
      subModule = Modules.dbSubModulesData?.firstWhere(
        (module) => module['id'] == moduleId,
      );
    } catch (e) {
      // If no [AppSubModule] could be found, return null.
      subModule = null;
    }
  }

  // Find the [AppSubModule] with the given [moduleName], if any.
  if (subModule == null && moduleName != null && moduleName.isNotEmpty) {
    try {
      subModule = Modules.dbSubModulesData?.firstWhere(
        (module) => module['idTitle'] == moduleName,
      );
    } catch (e) {
      // If no [AppSubModule] could be found, return null.
      subModule = null;
    }
  }

  // If no sub module could be found, return null.
  if (subModule == null) {
    return null;
  }

  // Create the [AppSubModule] from the found data.
  AppSubModule appSubModule = AppSubModule.fromMap(subModule);

  return appSubModule;
}
