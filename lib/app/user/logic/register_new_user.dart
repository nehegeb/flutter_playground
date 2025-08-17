// register_new_user.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/user/logic/generate_argon2_salt.dart';
import 'package:flutter_playground/app/user/logic/generate_argon2_hash.dart';
import 'package:flutter_playground/app/user/logic/update_users_data.dart';

/// Register a new user for the app.
/// Returns true if it worked, otherwise false.
Future<bool> registerNewUser(
  BuildContext context, {
  required String email,
  required String password,
  required String passwordConfirmation,
  required String name,
}) async {
  // Check, if both passwords are the same. If not, return false.
  if (password != passwordConfirmation) {
    return false;
  }

  // Generate a hash for the password.
  final salt = generateArgon2Salt();
  final hash = generateArgon2Hash(text: password, salt: salt);

  // Add the new user to the users data.
  bool isSuccess = await updateUsersData(
    email: email,
    name: name,
    passwordHash: hash,
    passwordSalt: salt,
    rolesIds: [], // New users don't have any roles in the beginning.
  );
  if (!isSuccess) {
    return false;
  }

  // Redirect the new user to the [LoginPage].
  context.go('/login', extra: DateTime.now().millisecondsSinceEpoch);

  return isSuccess;
}
