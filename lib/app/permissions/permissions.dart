// permissions.dart
//
// Features:
// - Provides a class [Permissions] with static methods to get permissions for the app.

import 'package:flutter_playground/app/permissions/logic/check_app_user_permission.dart';
import 'package:flutter_playground/app/permissions/data/permissions_main.dart';
import 'package:flutter_playground/app/permissions/data/permissions_template.dart';
import 'package:flutter_playground/app/permissions/data/permissions_settings.dart';

/// All the permissions available in the app.
///
/// To check, if the currently logged in [AppUser] has a certain permission, use
/// "Permissions.check(Permissions.main.access)".
///
/// To simply get the value of a specific permission, use
/// "Permissions.main.access".
///
/// Static methods:
/// - [check]: Checks if the currently logged in [AppUser] has the given permission. Returns Boolean.
/// - Get a specific permission like [Permissions.main.access].
class Permissions {
  static const String admin = '*';
  static const Main main = Main();
  static const Template template = Template();
  static const Settings settings = Settings();

  /// Checks if the currently logged in [AppUser] has the given [permission].
  /// It first checks the modules [isHidden] and [isPublic] parameters.
  /// It then checks the [AppUser]'s [AppRole]s against the given [permission].
  ///
  /// Returns true if the user has permission, otherwise false.
  static bool check({required String? permission}) {
    return checkAppUserPermission(permission: permission);
  }
}
