// user.dart
//

import 'package:flutter/foundation.dart';

final ValueNotifier<AppUser?> appUserNotifier = ValueNotifier<AppUser?>(null);

/// The user of the app.
class AppUser {
  final num id;
  final String username;
  final String password; // For debugging store password in plain text.
  final String role;
  final Set<String> permissions;
  AppUser(this.id, this.username, this.password, this.role, this.permissions);
}

// --- DEBUGGING ---

/// Table of available permissions.
const Set<String> permissions = {'module_dashboard', 'module_template'};

/// Table of available roles.
const Set<String> roles = {'admin', 'user', 'guest'};

/// Predefined users for testing purposes.
final AppUser user1 = AppUser(1, 'admin', 'password', 'admin', {
  'module_dashboard',
});
final AppUser user2 = AppUser(2, 'arthur', 'dent', 'user', {
  'module_dashboard',
});
final AppUser user3 = AppUser(3, 'ford', 'prefect', 'user', {
  'module_template',
});
final List<AppUser> users = [user1, user2, user3];
