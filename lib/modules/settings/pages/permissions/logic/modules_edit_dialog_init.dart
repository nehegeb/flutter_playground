// modules_edit_dialog_init.dart
//

import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/permissions_page_utils.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/widgets/modules_edit_dialog.dart';

Future<void> modulesEditDialogInit({required String moduleId}) async {
  // Check whether the given [moduleId] is 'main'.
  final bool isMain = moduleId == 'main' ? true : false;

  // Get the [AppMainModule] by the given [moduleId].
  AppMainModule? appMainModule;
  if (isMain) {
    appMainModule = AppMainModule.fromMap({
      'id': 'main',
      'idTitle': 'main',
      'isPublic': true,
    });
  } else {
    appMainModule = Modules.getMainModule(moduleId: moduleId);
  }
  if (appMainModule == null) {
    popupDialogDataNotifier.value = {};
    return;
  }

  // Get all administrators of the [AppMainModule].
  List<AppUser>? appUsers = await PermissionsPageUtils.getAppUsersForMainModule(
    mainModule: appMainModule.idTitle,
  );
  // Filter [AppUser]s who have the ".*" permission for this [AppMainModule].
  List<AppUser> adminAppUsers = [];
  if (appUsers != null) {
    for (final user in appUsers) {
      final permissions = await PermissionsPageUtils.getPermissionsForUser(
        userId: user.id,
      );
      if (permissions != null &&
          // If it's the 'main' main module, add app administrators.
          ((isMain && permissions.any((perm) => perm == '*')) ||
              // If it's a proper [AppMainModule], add only module administrators.
              (!isMain &&
                  permissions.any(
                    (perm) => perm == '${appMainModule!.idTitle}.*',
                  )))) {
        adminAppUsers.add(user);
      }
    }
  }

  // Collect the needed data.
  Map<String, dynamic>? data = {
    'id': appMainModule.id,
    'appMainModule': appMainModule,
    'adminAppUsers': adminAppUsers,
  };

  // Set the [popupDialogDataNotifier] with all data for the [ModulesEditDialog].
  popupDialogDataNotifier.value = data;

  // GET ALL USERS.

  // Make sure, the users data is loaded.
  if (User.dbUsersData == null) {
    await User.initDbUsersData();
  }
  List<dynamic>? allUsers = User.dbUsersData;

  // Get all [AppUser]s that are registered with this app.
  List<AppUser>? allAppUsers;
  if (allUsers != null) {
    allAppUsers = [];
    for (final user in allUsers) {
      final appUser = await User.getUser(userId: user['id']);
      if (appUser != null) {
        allAppUsers.add(appUser);
      }
    }
  }

  // Set [availableAppUsersForAdmin] for the [ModulesEditDialog].
  availableAppUsersForAdmin = allAppUsers;
}
