// logout_app_user.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/user/user.dart';

/// Logs out the currently logged in [AppUser].
void logoutAppUser(BuildContext context) {
  // Clear the [appUserNotifier].
  appUserNotifier.value = null;

  // Navigate to the [HomePage], even if the user is already there.
  context.go('/home', extra: DateTime.now().millisecondsSinceEpoch);
}
