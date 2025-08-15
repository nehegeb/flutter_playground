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
  required String name,
}) async {
  // Generate a hash for the password.
  final salt = generateArgon2Salt();
  final hash = generateArgon2Hash(text: password, salt: salt);

  // Add the new user to the users data.
  bool isSuccess = await updateUsersData(
    email: email,
    name: name,
    passwordArgon2: hash,
    argon2Salt: salt,
  );

  // Redirect the new user to the [LoginPage].
  context.go('/login', extra: DateTime.now().millisecondsSinceEpoch);

  return isSuccess;
}
