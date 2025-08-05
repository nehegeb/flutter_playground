// set_app_sub_module.dart
//

import 'package:flutter_playground/app/modules/modules.dart';

/// Sets the sub module for the app.
Future<void> setAppSubModule({required String module}) async {
  // Only update if the new module is different from the current one.
  if (Modules.subModule != module) {
    // Update the sub module notifier with the new module.
    subModuleNotifier.value = module;
  }
}
