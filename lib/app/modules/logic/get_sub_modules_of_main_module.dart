// get_sub_modules_of_main_module.dart
//

import 'package:flutter_playground/app/modules/logic/load_sub_modules_data.dart';

Future<List<String>> getSubModulesOfMainModule({
  required String mainModule,
}) async {
  if (mainModule.isEmpty) {
    return [];
  }

  // Make sure the sub modules data is loaded.
  if (subModulesData == null) {
    await loadSubModulesData();
  }

  // Return a list of all sub modules for the given [mainModule].
  return subModulesData!
      .where((subModule) => subModule['mainModuleIdTitle'] == mainModule)
      .map<String>((subModule) => subModule['idTitle'] as String)
      .toList();
}
