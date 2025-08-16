// init_page.dart
//

import 'package:flutter_playground/app/modules/modules.dart';

/// Initializes the page the [appRouter] navigates to.
/// If nothing is specified, defaults to the home page.
void initPage({String? mainModule = 'home', String? subModule = 'home'}) {
  // Make sure the mainModule is valid.
  if (mainModule == null || mainModule.isEmpty) {
    mainModule = 'home';
  }
  // Make sure the subModule is valid.
  if (subModule == null || subModule.isEmpty) {
    subModule = 'home';
  }

  // Update the [activeMainModuleNotifier] and the [activeSubModuleNotifier].
  Modules.setMainModule(mainModule: mainModule);
  Modules.setSubModule(mainModule: mainModule, subModule: subModule);
}
