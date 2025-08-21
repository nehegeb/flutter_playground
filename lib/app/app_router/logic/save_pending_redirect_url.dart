// save_pending_redirect_url.dart
//

import 'package:flutter_playground/app/app_router/app_router_utils.dart';

/// Gets the current url and saves it to [pendingRedirectUrl].
/// The [pendingRedirectUrl] is used to redirect the [AppUser] after logging in.
void savePendingRedirectUrl() {
  // Get the current url.
  String currentUrl = Uri.base.toString();

  // Only save everything after the '#'.
  pendingRedirectUrl = currentUrl.split('/#').last;
}
