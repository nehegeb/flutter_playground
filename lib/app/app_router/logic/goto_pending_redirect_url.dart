// goto_pending_redirect_url.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';

/// Navigates to the 'pendingRedirectUrl'.
/// If none is set, navigate to the [HomePage].
void gotoPendingRedirectUrl(BuildContext context) {
  // If no pending redirect url is set, navigate to the home page.
  String redirectUrl = pendingRedirectUrl ?? '/';

  // Clear the pending redirect url.
  pendingRedirectUrl = null;

  // Navigate to the url.
  context.go(redirectUrl);
}
