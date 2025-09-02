// users_edit_dialog_add_role.dart
//

import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/user/user.dart';

void usersEditDialogAddRole({required AppRole? appRole}) {
  // If no [appRole] is given, exit.
  if (appRole == null) return;

  // Get the data from the [popupDialogDataNotifier].
  Map<String, dynamic>? notifierData = popupDialogDataNotifier.value;
  if (notifierData == null) return;

  // Add the given [appRole] to the [AppUser], if not already in it.
  AppUser? appUser = notifierData['appUser'] as AppUser?;
  if (appUser != null) {
    List<AppRole>? appRoles = List<AppRole>.from(appUser.roles ?? []);
    if (!appRoles.contains(appRole)) {
      appRoles.add(appRole);
      appUser.roles = appRoles;
    }
  }

  // Add the given [appRole] to the list of added [AppRole]s.
  final addedAppRoles = List<AppRole>.from(notifierData['addedAppRoles'] ?? []);
  if (!addedAppRoles.contains(appRole)) {
    addedAppRoles.add(appRole);
  }

  // Update the [popupDialogDataNotifier] with the notifierData.
  popupDialogDataNotifier.value = {
    ...notifierData,
    'appUser': appUser,
    'addedAppRoles': addedAppRoles,
  };
}
