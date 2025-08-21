// logout_app_user.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/user/user.dart';

/// Logs out the currently logged in [AppUser].
void logoutAppUser(BuildContext context) {
  // Clear the [appUserNotifier].
  // This removes the currently logged in [AppUser] including its [AppRoles] and permissions.
  appUserNotifier.value = null;

  // Clear the [mainModulesNotifier] and [subModulesNotifier].
  // This removes the [AppMainModule]s and [AppSubModule]s the [AppUser] has access to.
  Modules.clearPermittedModules();

  // Navigate to the main [HomePage] of the app.
  context.go('/home', extra: DateTime.now().millisecondsSinceEpoch);
}
