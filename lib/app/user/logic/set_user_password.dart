// set_user_password.dart
//

import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/user/logic/generate_password_salt.dart';
import 'package:flutter_playground/app/user/logic/generate_password_hash.dart';
import 'package:flutter_playground/app/user/logic/update_users_data.dart';

/// Sets the password for the currently logged in [AppUser].
/// This only works if the user is logged in.
/// Returns true if the password was successfully set, otherwise false.
Future<bool> setUserPassword({required String password}) async {
  // Get the ID of the currently logged in [AppUser].
  // If no user is logged in, return false.
  if (User.user == null) {
    return false;
  }
  final userId = User.user!.id;

  // Load the users data.
  await User.initDbUsersData();

  // Find the user within the users data by the users ID.
  // If the user cannot be found, return false.
  final userData = User.dbUsersData!.firstWhere(
    (user) => user['id'] == userId,
    orElse: () => null,
  );
  if (userData == null) return false;

  // Clear the users data as soon as its not needed anymore.
  // NOTE: This is necessary to prevent unnecessary data for all users from being kept in memory.
  User.clearDbUsersData();

  // Generate a hash for the password.
  final salt = generatePasswordSalt();
  final hash = generatePasswordHash(password: password, salt: salt);

  // Update the user's password in the users data.
  // This also updates the [AppUser] for the [appUserNotifier].
  bool isSuccess = await updateUsersData(
    id: userData['id'],
    passwordHash: hash,
    passwordSalt: salt,
  );

  return isSuccess;
}
