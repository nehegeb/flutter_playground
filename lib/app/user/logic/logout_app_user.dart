// logout_app_user.dart
//

import 'package:flutter_playground/app/app_router/app_router.dart';
import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/user/user.dart';

/// Logs out the currently logged in [AppUser].
Future<void> logoutAppUser() async {
  // Navigate to the main [HomePage] of the app.
  appRouter.go('/home', extra: DateTime.now().millisecondsSinceEpoch);

  // Clear the [appUserNotifier].
  // This removes the currently logged in [AppUser] including its [AppRoles] and permissions.
  appUserNotifier.value = null;

  // Load only the public modules for the app.
  // While no [AppUser] is set for the [appUserNotifier], this sets only public modules.
  await Modules.setPermittedModules();
}
