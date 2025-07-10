// app_permissions.dart
//

import 'package:flutter/foundation.dart';

/// The user and their permissions. Saved in a [ValueNotifier] to allow reactive updates.
class User {
  final num id;
  final String username;
  final String password; // For debugging store password in plain text.
  final String role;
  final Set<String> permissions;
  User(this.id, this.username, this.password, this.role, this.permissions);
}

final ValueNotifier<User?> currentUserNotifier = ValueNotifier<User?>(null);

// --- DEBUGGING ---

/// Table of available permissions.
const Set<String> permissions = {
  'module_dashboard',
  'module_firebase',
  'module_sql_database',
};

/// Table of available roles.
const Set<String> roles = {'admin', 'user', 'guest'};

/// Predefined users for testing purposes.
final User user1 = User(1, 'admin', 'password', 'admin', {'module_dashboard'});
final User user2 = User(2, 'arthur', 'dent', 'user', {
  'module_dashboard',
  'module_sql_database',
});
final User user3 = User(3, 'ford', 'prefect', 'user', {'module_firebase'});
final List<User> users = [user1, user2, user3];
