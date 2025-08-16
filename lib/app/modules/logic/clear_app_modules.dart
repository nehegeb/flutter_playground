// clear_app_modules.dart
//

import 'package:flutter_playground/app/modules/modules.dart';

/// Clears the [mainModulesNotifier] and [subModulesNotifier].
/// This will be called whenever the currently logged in [AppUser] logs out.
void clearAppModules() {
  mainModulesNotifier.value = List<AppMainModule>.empty();
  subModulesNotifier.value = List<AppSubModule>.empty();
}
