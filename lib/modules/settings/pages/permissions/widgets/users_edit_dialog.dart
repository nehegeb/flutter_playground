// users_edit_dialog.dart
//

import 'package:flutter/material.dart';
// import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';

class UsersEditDialog extends StatelessWidget {
  final String userId;

  const UsersEditDialog({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Load the initial data for the [UsersEditDialog].
    initData() {
      popupDialogDataNotifier.value = {'id': userId};
    }

    initData();

    return Text('ID: $userId');
  }
}
