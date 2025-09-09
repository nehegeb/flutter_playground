// users_edit_dialog_delete.dart
//

import 'package:flutter_playground/app/user/logic/update_users_data.dart';

Future<void> usersEditDialogDelete({required String userId}) async {
  // Delete the [userId] from the users data.
  await updateUsersData(id: userId, doDelete: true);
}
