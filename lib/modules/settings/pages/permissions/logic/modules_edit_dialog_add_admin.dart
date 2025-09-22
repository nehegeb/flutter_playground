// modules_edit_dialog_add_admin.dart
//

import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/user/user.dart';

void modulesEditDialogAddAdmin({required AppUser? appUser}) {
  // If no [appUser] is given, exit.
  if (appUser == null) return;

  // Get the data from the [popupDialogDataNotifier].
  Map<String, dynamic>? notifierData = popupDialogDataNotifier.value;
  if (notifierData == null) return;

  // Add the given [appUser] to the list, if not already in it.
  List<AppUser>? adminAppUsers = List<AppUser>.from(
    notifierData['adminAppUsers'] ?? [],
  );
  if (!adminAppUsers.contains(appUser)) {
    adminAppUsers.add(appUser);
  }

  // Add the given [appUser] to the list of added [AppUser]s.
  final addedAppUsers = List<AppUser>.from(notifierData['addedAppUsers'] ?? []);
  if (!addedAppUsers.contains(appUser)) {
    addedAppUsers.add(appUser);
  }

  // Update the [popupDialogDataNotifier] with the notifierData.
  popupDialogDataNotifier.value = {
    ...notifierData,
    'adminAppUsers': adminAppUsers,
    'addedAppUsers': addedAppUsers,
  };
}
