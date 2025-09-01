// users_edit_dialog_delete_role.dart
//

import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/user/user.dart';

void usersEditDialogDeleteRole({required String roleId}) {
  // Get the data from the [popupDialogDataNotifier].
  Map<String, dynamic>? notifierData = popupDialogDataNotifier.value;
  if (notifierData == null) return;

  // Remove the role with the given [roleId] from the list.
  AppUser? appUser = notifierData['appUser'] as AppUser?;
  if (appUser != null) {
    List<AppRole>? appRoles = appUser.roles
        ?.where((role) => role.id != roleId)
        .toList();
    appUser.roles = appRoles;
  }

  // Add the [roleId] to the list of deleted [AppRole] IDs.
  final deletedRoleIds = List<String>.from(
    notifierData['deletedRoleIds'] ?? [],
  );
  if (!deletedRoleIds.contains(roleId)) {
    deletedRoleIds.add(roleId);
  }

  // Update the [popupDialogDataNotifier] with the notifierData.
  popupDialogDataNotifier.value = {
    ...notifierData,
    'appUser': appUser,
    'deletedRoleIds': deletedRoleIds,
  };
}
