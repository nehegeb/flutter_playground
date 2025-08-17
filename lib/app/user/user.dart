// user.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/user/logic/get_empty_app_user.dart';
import 'package:flutter_playground/app/user/logic/login_app_user.dart';
import 'package:flutter_playground/app/user/logic/logout_app_user.dart';
import 'package:flutter_playground/app/user/logic/set_user_title.dart';
import 'package:flutter_playground/app/user/logic/register_new_user.dart';
import 'package:flutter_playground/app/user/logic/check_entered_password_strength.dart';
import 'package:flutter_playground/app/user/logic/set_user_password.dart';
import 'package:flutter_playground/app/user/logic/check_app_user_permission.dart';
import 'package:flutter_playground/app/user/logic/load_users_data.dart';

/// Notifier for the currently logged in [AppUser].
final ValueNotifier<AppUser?> appUserNotifier = ValueNotifier<AppUser?>(null);

/// Utility class for user management.
/// Provides static methods manage the currently logged in user.
///
/// Static Methods:
/// - [user]: Gets the currently logged in [AppUser].
/// - [emptyUser]: Gets an empty [AppUser].
/// - [dbUsersData]: Gets the users data.
/// - [register]: Registers a new user. Returns Boolean.
/// - [login]: Logs in an [AppUser]. Returns Boolean.
/// - [logout]: Logs out the logged in [AppUser]. Returns Boolean.
/// - [setTitle]: Sets the current title for the currently logged in [AppUser].
/// - [setPassword]: Sets a new password for the currently logged in [AppUser]. Returns Boolean.
/// - [checkPasswordStrength]: Checks the strength of a password. Returns String.
/// - [checkPermission]: Checks if the user has permission for something. Returns Boolean.
/// - [initDbUsersData]: Initializes the users data for the app.
/// - [clearDbUsersData]: Clears the users data from the app.
class User {
  /// Get the currently logged in [AppUser] from the [appUserNotifier].
  static AppUser? get user {
    return appUserNotifier.value;
  }

  /// Get an empty [AppUser].
  static AppUser get emptyUser {
    return getEmptyAppUser();
  }

  /// Get the users data of the database.
  static List<dynamic>? get dbUsersData {
    return usersData;
  }

  /// Register a new user for the app.
  /// Returns true if it worked, otherwise false.
  static Future<bool> register(
    BuildContext context, {
    required String email,
    required String password,
    required String passwordConfirmation,
    required String name,
  }) async {
    return await registerNewUser(
      context,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
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

  /// Set the current title for the currently logged in [AppUser].
  /// This depends on the module the [AppUser] is currently in.
  static void setTitle() {
    setUserTitle();
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

  /// Checks if the currently logged in [AppUser] has permission for something.
  /// It checks the user's roles against the requested permission.
  /// Returns true if the user has permission, otherwise false.
  static bool checkPermission({required String? permission}) {
    return checkAppUserPermission(permission: permission);
  }

  /// Initializes the users data for the app.
  static Future<void> initDbUsersData() async {
    await loadUsersData();
  }

  /// Clear the users data of the database from the app.
  static void clearDbUsersData() {
    usersData = null;
  }
}

/// A user of the app.
///
/// Arguments:
/// - [id]: The unique identifier of the user, as an integer.
/// - [email]: The email address of the user.
/// - [name]: The name of the user.
/// - [passwordHash]: The hashed password of the user.
/// - [passwordSalt]: The salt used to hash the password.
/// - [roles]: A list of [AppRole]s the user has.
class AppUser {
  final int id;
  final String email;
  final String name;
  final String title;
  final String passwordHash;
  final String passwordSalt;
  final List<AppRole>? roles;
  AppUser({
    required this.id,
    required this.email,
    required this.name,
    required this.title,
    required this.passwordHash,
    required this.passwordSalt,
    this.roles,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      title: map['title'],
      passwordHash: map['passwordHash'],
      passwordSalt: map['passwordSalt'],
      roles: [Roles.emptyRole], // Default to empty role.
    );
  }
}
