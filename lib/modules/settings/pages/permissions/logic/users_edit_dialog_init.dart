// users_edit_dialog_init.dart
//

import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/permissions_page_utils.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/widgets/users_edit_dialog.dart';

Future<void> usersEditDialogInit({
  String? userId,
  required String mainModule,
}) async {
  // If no [userId] is given, a new [AppUser] is being added.
  if (userId == null) {
    popupDialogDataNotifier.value = {};
    return;
  }

  // Get the [AppUser] by the given [userId].
  final AppUser? appUser = await User.getUser(userId: userId);
  if (appUser == null) {
    popupDialogDataNotifier.value = {};
    return;
  }

  // Check whether the [AppUser] has any [AppRole] with admin permissions.
  final List<dynamic>? userPermissions =
      await PermissionsPageUtils.getPermissionsForUser(userId: userId);
  final bool isAdmin =
      userPermissions != null &&
      userPermissions.any((perm) => perm == ('$mainModule.*'));

  // To through the [AppUser]s [AppRole]s and remove all that do not fit the given [mainModule].
  appUser.roles?.removeWhere((role) => role.mainModuleIdTitle != mainModule);

  // Collect the needed data.
  Map<String, dynamic>? data = {
    'id': appUser.id,
    'isAdmin': isAdmin,
    'appUser': appUser,
  };

  // Set the [popupDialogDataNotifier] with all data for the [ModulesEditDialog].
  popupDialogDataNotifier.value = data;

  // GET ALL ROLES.

  // Make sure, the roles data is loaded.
  if (Roles.dbRolesData == null) {
    await Roles.initDbRolesData();
  }
  List<dynamic>? allRoles = Roles.dbRolesData;

  // Get all [AppRoles]s that are registered with this app.
  List<AppRole>? allAppRoles;
  if (allRoles != null) {
    allAppRoles = [];
    for (final role in allRoles) {
      // Only add [AppRole]s for the given [mainModule].
      if (role['mainModuleIdTitle'] == mainModule) {
        final appRole = Roles.getRole(roleId: role['id']);
        if (appRole != null) {
          // Do not add the administrator [AppRole] of the given [mainModule].
          List<String>? rolePermissions = appRole.permissions;
          final bool isAdminRole =
              rolePermissions != null &&
              rolePermissions.any((perm) => perm == ('$mainModule.*'));
          if (!isAdminRole) {
            allAppRoles.add(appRole);
          }
        }
      }
    }
  }

  // Set [availableAppRolesForAppUser] for the [ModulesEditDialog].
  availableAppRolesForAppUser = allAppRoles;
}
