// get_permitted_modules.dart
//

import 'package:flutter_playground/app/modules/modules.dart';

/// Get only permitted modules data for the current user.
Map<String, dynamic>? getPermittedModules() {
  // Get the complete modules data.
  final modulesData = Modules.getModulesData();

  // TODO: Implement filtering of modules based on user permissions.

  return modulesData;
}
