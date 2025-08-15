// user.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/user/logic/login_app_user.dart';
import 'package:flutter_playground/app/user/logic/logout_app_user.dart';
import 'package:flutter_playground/app/user/logic/register_new_user.dart';
import 'package:flutter_playground/app/user/logic/check_entered_password_strength.dart';
import 'package:flutter_playground/app/user/logic/set_user_password.dart';

final ValueNotifier<AppUser?> appUserNotifier = ValueNotifier<AppUser?>(null);

/// Utility class for user management.
/// Provides static methods manage the currently logged in user.
///
/// Static Methods:
/// - [user]: Gets the currently logged in [AppUser].
/// - [register]: Registers a new user. Returns Boolean.
/// - [login]: Logs in a user. Returns Boolean.
/// - [logout]: Logs out the logged in user. Returns Boolean.
/// - [setPassword]: Sets a new password for the logged in user. Returns Boolean.
/// - [checkPasswordStrength]: Checks the strength of the password. Returns String.
class User {
  /// Get the currently logged in [AppUser] from the [appUserNotifier].
  static AppUser? get user {
    return appUserNotifier.value;
  }

  /// Register a new user for the app.
  /// Returns true if it worked, otherwise false.
  static Future<bool> register(
    BuildContext context, {
    required String email,
    required String password,
    required String name,
  }) async {
    return await registerNewUser(
      context,
      email: email,
      password: password,
      name: name,
    );
  }

  /// Login a user.
  /// Returns true if it worked, otherwise false.
  static Future<bool> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    return await loginAppUser(context, email: email, password: password);
  }

  /// Logout the currently logged in user.
  static void logout(BuildContext context) {
    return logoutAppUser(context);
  }

  /// Set a new password for the user.
  /// This only works if the user is logged in.
  /// Returns true if it worked, otherwise false.
  static Future<bool> setPassword({required String password}) async {
    return await setUserPassword(password: password);
  }

  /// Checks the strength of a password.
  /// Returns an error message if the password is too weak.
  static String checkPasswordStrength({required String password}) {
    return checkEnteredPasswordStrength(password: password);
  }
}

/// A user of the app.
class AppUser {
  final int id;
  final String email;
  final String name;
  final String passwordHash;
  final String passwordSalt;
  final String roles;
  AppUser(
    this.id,
    this.email,
    this.name,
    this.passwordHash,
    this.passwordSalt,
    this.roles,
  );
}
