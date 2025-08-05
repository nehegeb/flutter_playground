// set_app_main_module.dart
//

import 'package:flutter_playground/app/modules/modules.dart';

/// Sets the main module for the app.
Future<void> setAppMainModule({required String module}) async {
  // Only update if the new module is different from the current one.
  if (Modules.mainModule != module) {
    // Update the main module notifier with the new module.
    mainModuleNotifier.value = module;

    // Set the sub module to the main modules home page.
    Modules.setSubModule(module: 'home');
  }
}
