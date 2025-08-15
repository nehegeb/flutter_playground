// update_users_data.dart
//

import 'dart:io';
import 'dart:convert';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/user/logic/load_users_data.dart';
import 'package:flutter_playground/app/user/logic/set_app_user.dart';

/// Update the entry in the users data JSON file by the users ID.
/// Also sets the [AppUser] for the [appUserNotifier] afterwards.
/// Returns true if the update was successful, false otherwise.
Future<bool> updateUsersData({
  int id = 0,
  String email = '',
  String name = '',
  String passwordArgon2 = '',
  String argon2Salt = '',
}) async {
  // Load the users data, if it's not already loaded.
  bool wasAlreadyLoaded = true;
  if (usersData == null) {
    wasAlreadyLoaded = false;
    await loadUsersData();
  }

  bool isNewUser = id == 0 ? true : false;
  bool usersDataUpdated = false;

  // If its a NEW USER, try to add it to the users data.
  if (isNewUser) {
    // Check, if the eMail address already exists in the users data.
    final existingUser = usersData!.firstWhere(
      (user) => user['email'] == email,
      orElse: () => null,
    );

    // If the eMail address already exists in the users data, return false.
    if (existingUser != null) {
      return false;
    }

    // Add the new user to the users data.
    final newUser = {
      'id': usersData!.length + 1,
      'email': email,
      'name': name,
      'passwordArgon2': passwordArgon2,
      'argon2Salt': argon2Salt,
    };

    usersData!.add(newUser);

    usersDataUpdated = true;
  }

  // If its a KNOWN USER, update the given values for the users id in the users data.
  if (!isNewUser) {
    for (var user in usersData!) {
      if (user['id'] == id) {
        email = email.isNotEmpty ? email : user['email'];
        name = name.isNotEmpty ? name : user['name'];
        passwordArgon2 = passwordArgon2.isNotEmpty
            ? passwordArgon2
            : user['passwordArgon2'];
        argon2Salt = argon2Salt.isNotEmpty ? argon2Salt : user['argon2Salt'];

        user['email'] = email;
        user['name'] = name;
        user['passwordArgon2'] = passwordArgon2;
        user['argon2Salt'] = argon2Salt;

        usersDataUpdated = true;
        break;
      }
    }
  }

  // If the users data could not be updated, return false.
  if (!usersDataUpdated) {
    return false;
  }

  // Save the updated users data back to the JSON file.
  final file = File('lib/app/user/data/users.json');
  final jsonString = jsonEncode(usersData);
  await file.writeAsString(jsonString);

  // If its a KNOWN USER, set the [AppUser] for the [appUserNotifier].
  if (!isNewUser) {
    setAppUser(
      id: id,
      email: email,
      name: name,
      passwordHash: passwordArgon2,
      passwordSalt: argon2Salt,
    );
  }

  // Clear the users data afterwards, if it was not already loaded before.
  // If it was already loaded before, it should stay in memory and be cleared later on.
  // NOTE: This is necessary to prevent unnecessary data for all users from being kept in memory.
  if (!wasAlreadyLoaded) {
    usersData = null;
  }

  return true;
}
