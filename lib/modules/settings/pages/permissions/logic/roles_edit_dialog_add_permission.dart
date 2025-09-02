// roles_edit_dialog_add_permission.dart
//

import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/roles/roles.dart';

void rolesEditDialogAddPermission({required String? permission}) {
  // If no [permission] is given, exit.
  if (permission == null) return;

  // Get the data from the [popupDialogDataNotifier].
  Map<String, dynamic>? notifierData = popupDialogDataNotifier.value;
  if (notifierData == null) return;

  // Add the given [permission] to the [AppRole], if not already in it.
  AppRole? appRole = notifierData['appRole'] as AppRole?;
  if (appRole != null) {
    List<String> rolePermissions = List<String>.from(appRole.permissions ?? []);
    if (!rolePermissions.contains(permission)) {
      rolePermissions.add(permission);
      appRole.permissions = rolePermissions;
    }
  }

  // Add the given [permission] to the list of added permissions.
  final addedPermissions = List<String>.from(
    notifierData['addedPermissions'] ?? [],
  );
  if (!addedPermissions.contains(permission)) {
    addedPermissions.add(permission);
  }

  // Update the [popupDialogDataNotifier] with the notifierData.
  popupDialogDataNotifier.value = {
    ...notifierData,
    'appRole': appRole,
    'addedPermissions': addedPermissions,
  };
}
