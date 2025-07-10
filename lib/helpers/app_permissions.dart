/// app_permissions.dart
///
library app_permissions;

import 'package:flutter/foundation.dart';

/// The user and their permissions. Saved in a [ValueNotifier] to allow reactive updates.
class User {
  final String id;
  final Set<String> permissions;
  User(this.id, this.permissions);
}

final ValueNotifier<User?> currentUserNotifier = ValueNotifier<User?>(null);

// TODO: Add a dropdown menu to the app bar with a login/logout button.
// TODO: Make the login page work and set some permissions for the user.
// TODO: Do a nice design for the login page and the unauthorized page.
