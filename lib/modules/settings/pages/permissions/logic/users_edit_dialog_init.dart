// users_edit_dialog_init.dart
//

import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/user/user.dart';

Future<void> usersEditDialogInit({
  String? userId,
  required String mainModule,
}) async {
  // If no [userId] is given, a new [AppUser] is being added.
  if (userId == null) {
    popupDialogDataNotifier.value = {};
    return;
  }

  // Get the [AppUser] by the given [userId].
  AppUser? appUser = await User.getUser(userId: userId);
  if (appUser == null) {
    popupDialogDataNotifier.value = {};
    return;
  }

  // To through the [AppUser]s [AppRole]s and remove all that do not fit the given [mainModule].
  appUser.roles?.removeWhere((role) => role.mainModuleIdTitle != mainModule);

  // Collect the needed data.
  Map<String, dynamic>? data = {'id': appUser.id, 'appUser': appUser};

  // Set the [popupDialogDataNotifier] with all data for the [ModulesEditDialog].
  popupDialogDataNotifier.value = data;
}
