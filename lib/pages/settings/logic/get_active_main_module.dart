// get_active_main_module.dart
//

import 'package:flutter_playground/app/modules/modules.dart';

/// Get the currently active main module.
/// If it's null or the 'settings' main module, return 'main'.
/// This is, because the settings [AppMainModule] belongs to the 'main' main module.
String getActiveMainModule() {
  return (Modules.activeMainModule != null &&
          Modules.activeMainModule!.idTitle != 'settings')
      ? Modules.activeMainModule!.idTitle
      : 'main';
}
