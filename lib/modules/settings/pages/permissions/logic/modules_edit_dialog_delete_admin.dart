// modules_edit_dialog_delete_admin.dart
//

import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/user/user.dart';

void modulesEditDialogDeleteAdmin({required String userId}) {
  // Get the data from the [popupDialogDataNotifier].
  Map<String, dynamic>? notifierData = popupDialogDataNotifier.value;
  if (notifierData == null) return;

  // Remove the [AppUser] with the given [userId] from the list.
  List<AppUser>? adminAppUsers = List<AppUser>.from(
    notifierData['adminAppUsers'] ?? [],
  );
  adminAppUsers.removeWhere((user) => user.id == userId);

  // Add the [userId] to the list of deleted [AppUser] IDs.
  final deletedUserIds = List<String>.from(
    notifierData['deletedUserIds'] ?? [],
  );
  if (!deletedUserIds.contains(userId)) {
    deletedUserIds.add(userId);
  }

  // Update the [popupDialogDataNotifier] with the notifierData.
  popupDialogDataNotifier.value = {
    ...notifierData,
    'adminAppUsers': adminAppUsers,
    'deletedUserIds': deletedUserIds,
  };
}
