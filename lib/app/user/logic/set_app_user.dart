// set_app_user.dart
//

import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/user/logic/get_user_roles.dart';
import 'package:flutter_playground/app/user/logic/get_user_title.dart';

/// Sets the [AppUser] for the [appUserNotifier].
/// If arguments are not given, it keeps the values already set for the currently logged in [AppUser], if any.
/// This always gets the users complete [AppRoles] and extends them with the given roles.
/// This also always gets the users title for the app.
/// This is performed after the login and whenever the users information changes.
Future<void> setAppUser({
  required int id,
  String? email,
  String? name,
  String? passwordHash,
  String? passwordSalt,
  List<AppRole>? roles,
}) async {
  // Check all given arguments.
  // If not given, use the value of the currently logged in [AppUser], if any.
  // If still nothing is found, just set an empty value.
  email ??= User.user?.email ?? '';
  name ??= User.user?.name ?? '';
  passwordHash ??= User.user?.passwordHash ?? '';
  passwordSalt ??= User.user?.passwordSalt ?? '';

  // Add any given [roles] to the users existing [AppRoles], avoiding duplicates.
  List<AppRole>? userRoles = await getUserRoles(userId: id);
  if (roles != null && roles.isNotEmpty) {
    final Set<AppRole> combinedRoles = {...?userRoles, ...roles};
    roles = combinedRoles.toList();
  } else {
    roles = userRoles;
  }

  // Get the user's title to display in the app.
  String title = getUserTitle(appRoles: roles);

  // Set the [AppUser] for the [appUserNotifier].
  final AppUser user = AppUser(
    id: id,
    email: email,
    name: name,
    title: title,
    passwordHash: passwordHash,
    passwordSalt: passwordSalt,
    roles: roles,
  );
  appUserNotifier.value = user;

  // Load the modules data (anew), to make sure changed modules are reflected.
  await Modules.initDbModulesData();

  // Set the [AppMainModule]s and [AppSubModule]s the [AppUser] has access to.
  await Modules.setPermittedModules();
}
