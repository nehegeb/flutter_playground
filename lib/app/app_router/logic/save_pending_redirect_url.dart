// save_pending_redirect_url.dart
//

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';

/// Gets the current url and saves it to [pendingRedirectUrl].
/// The [pendingRedirectUrl] is used to redirect the [AppUser] after logging in.
void savePendingRedirectUrl(BuildContext? context) {
  String currentUrl = '';

  // If [context] is given, try using the GoRouter to get the current url.
  if (context != null) {
    final router = GoRouter.of(context);
    currentUrl = router.routerDelegate.currentConfiguration.fullPath;
  }

  // If above did not work, try using the Uri.base to get the current url.
  // Note: This will only work for web apps.
  currentUrl = currentUrl.isNotEmpty ? currentUrl : Uri.base.toString();

  // Only save everything after the '#' to the [pendingRedirectUrl].
  pendingRedirectUrl = currentUrl.split('/#').last;
}
