// init_page.dart
//

import 'package:flutter_playground/app/modules/modules.dart';

/// Initializes the page the [appRouter] navigates to.
/// If no [mainModule] or [subModule] is specified, it defaults to the proper home page.
void initPage({String? mainModule = 'home', String? subModule = 'home'}) {
  // Make sure the [mainModule] is valid.
  if (mainModule == null || mainModule.isEmpty) {
    mainModule = 'home';
  }
  // Make sure the [subModule] is valid.
  if (subModule == null || subModule.isEmpty) {
    subModule = 'home';
  }

  // Update the [activeMainModuleNotifier] and the [activeSubModuleNotifier].
  Modules.setActiveMainModule(mainModule: mainModule);
  Modules.setActiveSubModule(mainModule: mainModule, subModule: subModule);
}
