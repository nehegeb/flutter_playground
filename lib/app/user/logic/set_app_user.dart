// set_app_user.dart
//

import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/user/logic/get_user_roles.dart';
import 'package:flutter_playground/app/user/logic/get_user_permissions.dart';

/// Sets the [AppUser] for the [appUserNotifier].
/// If arguments are not given, it keeps the values already set for the currently logged in [AppUser], if any.
/// This always gets the user's complete [AppRoles] and extends them with the given roles.
/// This also always gets the user's title for the app.
///
/// This is performed after the login and whenever the user's information changes.
Future<void> setAppUser({
  required String id,
  String? email,
  String? name,
  String? passwordHash,
  String? passwordSalt,
  List<AppRole>? roles,
  List<String>? permissions,
}) async {
  // Check all given arguments.
  // If not given, use the value of the currently logged in [AppUser], if any.
  // If still nothing is found, just set an empty value.
  email ??= User.user?.email ?? '';
  name ??= User.user?.name ?? '';
  passwordHash ??= User.user?.passwordHash ?? '';
  passwordSalt ??= User.user?.passwordSalt ?? '';

  // Add any given [roles] to the user's existing [AppRoles], avoiding duplicates.
  List<AppRole>? userRoles = await getUserRoles(userId: id);
  if (roles != null && roles.isNotEmpty) {
    final Set<AppRole> combinedRoles = {...?userRoles, ...roles};
    roles = combinedRoles.toList();
  } else {
    roles = userRoles;
  }

  // Add any given [permissions] to the user's existing permissions, avoiding duplicates.
  List<String> userPermissions = await getUserPermissions(userId: id);
  if (permissions != null && permissions.isNotEmpty) {
    final Set<String> combinedPermissions = {
      ...userPermissions,
      ...permissions,
    };
    permissions = combinedPermissions.toList();
  } else {
    permissions = userPermissions;
  }

  // Set the [AppUser] for the [appUserNotifier].
  final AppUser user = AppUser(
    id: id,
    email: email,
    name: name,
    title: '', // Will be set afterwards.
    passwordHash: passwordHash,
    passwordSalt: passwordSalt,
    roles: roles,
    permissions: permissions,
  );
  appUserNotifier.value = user;

  // Set the now logged in [AppUser]'s title.
  User.setTitle();

  // Load the modules data (anew), to make sure changed modules are reflected.
  await Modules.initDbModulesData();

  // Set the [AppMainModule]s and [AppSubModule]s the [AppUser] has access to.
  await Modules.setPermittedModules();
}
