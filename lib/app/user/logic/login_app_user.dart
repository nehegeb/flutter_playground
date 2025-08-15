// login_app_user.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';
import 'package:flutter_playground/app/user/logic/load_users_data.dart';
import 'package:flutter_playground/app/user/logic/generate_argon2_hash.dart';
import 'package:flutter_playground/app/user/logic/set_app_user.dart';

/// Tries to log in the [AppUser].
/// Returns true if the login was successful, otherwise false.
Future<bool> loginAppUser(
  BuildContext context, {
  required String email,
  required String password,
}) async {
  // Load the users data.
  await loadUsersData();

  // Find the user within the users data by the users eMail.
  final userData = usersData!.firstWhere(
    (user) => user['email'] == email,
    orElse: () => null,
  );
  if (userData == null) {
    // No user found. Clear the users data and return false.
    usersData = null;
    return false;
  }

  // Check, if the entered password is correct.
  final userDataPassword = userData['passwordArgon2'];
  final userDataSalt = userData['argon2Salt'];
  final hashedPassword = generateArgon2Hash(text: password, salt: userDataSalt);
  if (userDataPassword != hashedPassword) {
    // Password does not match. Clear the users data and return false.
    usersData = null;
    return false;
  }

  // Set the [AppUser] to the appUserNotifier.
  setAppUser(
    id: userData['id'],
    email: userData['email'],
    name: userData['name'],
    passwordHash: userData['passwordArgon2'],
    passwordSalt: userData['argon2Salt'],
  );

  // Clear the users data afterwards.
  // NOTE: This is necessary to prevent unnecessary data for all users from being kept in memory.
  usersData = null;

  // Redirect the user.
  // If the user wanted to go to a specific page, redirect there.
  // Otherwise, navigate to the [HomePage].
  AppRouterUtils.gotoRedirectUrl(context);

  return true;
}
