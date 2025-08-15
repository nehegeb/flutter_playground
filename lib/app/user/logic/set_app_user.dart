// set_app_user.dart
//

import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/permissions/permissions.dart';

/// Sets the [AppUser] for the [appUserNotifier].
/// If arguments are not given, it keeps the ones already set for the [AppUser].
/// This is done after the login and whenever the users information changes.
void setAppUser({
  required int id,
  String email = '',
  String name = '',
  String passwordHash = '',
  String passwordSalt = '',
  String roles = '',
}) {
  // If an argument is not given, use the one already set for [AppUser].
  email = email.isNotEmpty ? email : User.user?.email ?? '';
  name = name.isNotEmpty ? name : User.user?.name ?? '';
  passwordHash = passwordHash.isNotEmpty
      ? passwordHash
      : User.user?.passwordHash ?? '';
  passwordSalt = passwordSalt.isNotEmpty
      ? passwordSalt
      : User.user?.passwordSalt ?? '';

  // If none are given, gather the users permission roles.
  roles = roles.isNotEmpty ? roles : (Permissions.getAppUserRoles() ?? '');

  // Set the [AppUser] for the [appUserNotifier].
  final AppUser user = AppUser(
    id,
    email,
    name,
    passwordHash,
    passwordSalt,
    roles,
  );
  appUserNotifier.value = user;
}
