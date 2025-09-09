// roles_edit_dialog_delete.dart
//

import 'package:flutter_playground/app/roles/logic/update_roles_data.dart';

Future<void> rolesEditDialogDelete({required String roleId}) async {
  // Delete the [roleId] from the roles data.
  await updateRolesData(id: roleId, doDelete: true);
}
