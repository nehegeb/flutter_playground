// register_new_user.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_router/app_router.dart';
import 'package:flutter_playground/app/user/logic/generate_password_salt.dart';
import 'package:flutter_playground/app/user/logic/generate_password_hash.dart';
import 'package:flutter_playground/app/user/logic/update_users_data.dart';

/// Register a new user for the app.
/// Returns an error message if it fails, otherwise an empty string.
Future<String> registerNewUser(
  BuildContext context, {
  required String email,
  required String password,
  required String passwordConfirmation,
  required String name,
}) async {
  // Check if all parameters are given.
  if (email.isEmpty ||
      password.isEmpty ||
      passwordConfirmation.isEmpty ||
      name.isEmpty) {
    return 'errors.missingRequiredFields';
  }

  // Check, if both passwords are the same. If not, return false.
  if (password != passwordConfirmation) {
    return 'errors.passwordsDoNotMatch';
  }

  // Generate a hash for the password.
  final salt = generatePasswordSalt();
  final hash = generatePasswordHash(password: password, salt: salt);

  // Add the new user to the users data.
  bool isSuccess = await updateUsersData(
    email: email,
    name: name,
    passwordHash: hash,
    passwordSalt: salt,
    rolesIds: [
      "8fdd8d35-da28-4a23-9c40-d0f22d155145",
    ], // New users start as a basic member.
  );
  if (!isSuccess) {
    return 'errors.registrationFailed';
  }

  // Redirect the new user to the [LoginPage].
  appRouter.go('/login');

  // If the registration was successful, return no error message.
  return '';
}
