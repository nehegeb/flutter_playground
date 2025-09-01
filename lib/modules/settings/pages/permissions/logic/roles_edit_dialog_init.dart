// roles_edit_dialog_init.dart
//

import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/roles/roles.dart';

Future<void> rolesEditDialogInit({
  String? roleId,
  required String mainModule,
}) async {
  // If no [roleId] is given, a new [AppRole] is being created.
  if (roleId == null) {
    popupDialogDataNotifier.value = {};
    return;
  }

  // Get the [AppRole] by the given [roleId].
  AppRole? appRole;
  appRole = Roles.getRole(roleId: roleId);
  if (appRole == null) {
    popupDialogDataNotifier.value = {};
    return;
  }

  // Collect the needed data.
  Map<String, dynamic>? data = {'id': appRole.id, 'appRole': appRole};

  // Set the [popupDialogDataNotifier] with all data for the [ModulesEditDialog].
  popupDialogDataNotifier.value = data;
}
