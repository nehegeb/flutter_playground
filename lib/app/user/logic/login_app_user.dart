// login_app_user.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';
import 'package:flutter_playground/app/user/logic/generate_password_hash.dart';
import 'package:flutter_playground/app/user/logic/set_app_user.dart';

/// Tries to log in the [AppUser], using its [email] and [password].
/// Returns true if the login was successful, otherwise false.
Future<bool> loginAppUser(
  BuildContext context, {
  required String email,
  required String password,
}) async {
  // Load the users data.
  await User.initDbUsersData();

  // Find the user within the users data by the given [email].
  final userData = User.dbUsersData!.firstWhere(
    (user) => user['email'] == email,
    orElse: () => null,
  );

  // Clear the users data as soon as its not needed anymore.
  // NOTE: This is necessary to prevent unnecessary data for all users from being kept in memory.
  User.clearDbUsersData();

  // If no data with the given [email] is found, return false.
  if (userData == null) {
    return false;
  }

  // Check, if the given [password] is correct.
  final userDataPassword = userData['passwordHash'];
  final userDataSalt = userData['passwordSalt'];
  final hashedPassword = generatePasswordHash(
    password: password,
    salt: userDataSalt,
  );
  if (userDataPassword != hashedPassword) {
    // The password does not match the saved one, return false.
    return false;
  }

  // Set the [AppUser] to the [appUserNotifier].
  // This will also set the [AppUser]s [AppRole]s and permissions.
  // This will also set the [AppMainModule]s and [AppSubModule]s the [AppUser] has access to.
  await setAppUser(
    id: userData['id'],
    email: userData['email'],
    name: userData['name'],
    passwordHash: userData['passwordHash'],
    passwordSalt: userData['passwordSalt'],
  );

  // Redirect the user.
  // If the user wanted to go to a specific page, redirect there.
  // Otherwise, navigate to the [HomePage].
  AppRouterUtils.gotoRedirectUrl(context);

  return true;
}
