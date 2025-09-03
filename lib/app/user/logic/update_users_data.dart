// update_users_data.dart
//

import 'dart:io';
import 'dart:convert';
import 'package:flutter_playground/app/app_helper/app_helper.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/user/logic/set_app_user.dart';

/// Update the entry in the users data JSON file by the users ID.
/// If no [id] is given, it assumes this is a new user for the app and adds it.
/// Otherwise it also sets the [AppUser] for the [appUserNotifier] afterwards.
///
/// Returns true if the update was successful, false otherwise.
Future<bool> updateUsersData({
  String? id,
  String? email,
  String? name,
  String? passwordHash,
  String? passwordSalt,
  List<String>? rolesIds,
}) async {
  // Define default values if not provided.
  id ??= '';
  email ??= '';
  name ??= '';
  passwordHash ??= '';
  passwordSalt ??= '';
  rolesIds ??= [];

  // Load the users data to make sure it's the most current version.
  bool wasAlreadyLoaded = true;
  if (User.dbUsersData == null) {
    wasAlreadyLoaded = false;
  }
  await User.initDbUsersData();

  bool isNewUser = id == '' ? true : false;
  bool usersDataUpdated = false;

  // If its a NEW USER, try to add it to the users data.
  if (isNewUser) {
    // Check, if the eMail address already exists in the users data.
    final existingUser = User.dbUsersData!.firstWhere(
      (user) => user['email'] == email,
      orElse: () => null,
    );

    // If the given [email] already exists in the users data, return false.
    if (existingUser != null) {
      // Clear the users data as soon as its not needed anymore, if it was not already loaded before.
      // If it was already loaded before, it should stay in memory and be cleared later on.
      if (!wasAlreadyLoaded) {
        User.clearDbUsersData();
      }
      return false;
    }

    // Add the new user to the users data.
    final newUser = {
      'id': AppHelper.uuid,
      'email': email,
      'name': name,
      'passwordHash': passwordHash,
      'passwordSalt': passwordSalt,
      'rolesIds': rolesIds.isNotEmpty ? rolesIds : [],
    };
    User.dbUsersData!.add(newUser);

    usersDataUpdated = true;
  }

  // If its a KNOWN USER, update the given values for the users id in the users data.
  if (!isNewUser) {
    for (var user in User.dbUsersData!) {
      if (user['id'] == id) {
        email = email != null && email.isNotEmpty ? email : user['email'];
        name = name != null && name.isNotEmpty ? name : user['name'];
        passwordHash = passwordHash != null && passwordHash.isNotEmpty
            ? passwordHash
            : user['passwordHash'];
        passwordSalt = passwordSalt != null && passwordSalt.isNotEmpty
            ? passwordSalt
            : user['passwordSalt'];
        rolesIds = rolesIds != null && rolesIds.isNotEmpty
            ? rolesIds
            : user['rolesIds'] ?? [];

        user['email'] = email;
        user['name'] = name;
        user['passwordHash'] = passwordHash;
        user['passwordSalt'] = passwordSalt;
        user['rolesIds'] = rolesIds;

        usersDataUpdated = true;
        break;
      }
    }
  }

  // If the users data has been updated
  // save the updated users data back to the JSON file.
  if (usersDataUpdated) {
    final file = File('lib/app/user/data/users.json');
    final jsonString = jsonEncode(User.dbUsersData);
    await file.writeAsString(jsonString);
  }

  // Clear the users data as soon as its not needed anymore, if it was not already loaded before.
  // If it was already loaded before, it should stay in memory and be cleared later on.
  // NOTE: This is necessary to prevent unnecessary data for all users from being kept in memory.
  if (!wasAlreadyLoaded) {
    User.clearDbUsersData();
  }

  // If its a KNOWN USER and it's the one currently logged in,
  // update the [AppUser] with the new data for the [appUserNotifier].
  if (!isNewUser && User.user != null && User.user!.id == id) {
    await setAppUser(
      id: id,
      email: email,
      name: name,
      passwordHash: passwordHash,
      passwordSalt: passwordSalt,
    );
  }

  return true;
}
