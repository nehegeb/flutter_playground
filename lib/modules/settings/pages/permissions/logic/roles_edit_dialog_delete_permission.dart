// roles_edit_dialog_delete_permission.dart
//

import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/roles/roles.dart';

void usersEditDialogDeletePermission({required String permission}) {
  // Get the data from the [popupDialogDataNotifier].
  Map<String, dynamic>? notifierData = popupDialogDataNotifier.value;
  if (notifierData == null) return;

  // Remove the given [permission] from the list.
  AppRole? appRole = notifierData['appRole'] as AppRole?;
  if (appRole != null) {
    List<String> rolePermissions = List<String>.from(appRole.permissions ?? []);
    rolePermissions.remove(permission);
    appRole.permissions = rolePermissions;
  }

  // Add the [permission] to the list of deleted permissions.
  final deletedPermissions = List<String>.from(
    notifierData['deletedPermissions'] ?? [],
  );
  if (!deletedPermissions.contains(permission)) {
    deletedPermissions.add(permission);
  }

  // Update the [popupDialogDataNotifier] with the notifierData.
  popupDialogDataNotifier.value = {
    ...notifierData,
    'appRole': appRole,
    'deletedPermissions': deletedPermissions,
  };
}
