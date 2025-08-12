// user.dart
//

import 'package:flutter/foundation.dart';

final ValueNotifier<AppUser?> appUserNotifier = ValueNotifier<AppUser?>(null);

/// Utility class for user management.
/// Provides static methods manage the currently logged in user.
///
/// Static Methods:
/// - [user]: Gets the app user.
/// - [setUser]: Sets the currently logged in user.
class User {
  /// Get the app user.
  static AppUser? get user {
    return appUserNotifier.value;
  }

  /// Set the currently logged in user.
  static void setUser(AppUser? user) {
    appUserNotifier.value = user;
  }
}

/// The user of the app.
class AppUser {
  final num id;
  final String username;
  final String password; // For debugging store password in plain text.
  final String role;
  final Set<String> permissions;
  AppUser(this.id, this.username, this.password, this.role, this.permissions);
}

// --- DEBUGGING BELOW ---

/// Table of available permissions.
const Set<String> permissions = {'module_template', 'module_settings'};

/// Table of available roles.
const Set<String> roles = {'admin', 'user', 'guest'};

/// Predefined users for testing purposes.
final AppUser user1 = AppUser(2, 'arthur', 'dent', 'admin', {});
final AppUser user2 = AppUser(3, 'ford', 'prefect', 'user', {
  'module_template',
});
final List<AppUser> users = [user1, user2];
