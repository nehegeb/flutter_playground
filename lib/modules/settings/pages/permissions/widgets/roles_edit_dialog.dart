// roles_edit_dialog.dart
//

import 'package:flutter/material.dart';
// import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';

class RolesEditDialog extends StatelessWidget {
  final String roleId;

  const RolesEditDialog({super.key, required this.roleId});

  @override
  Widget build(BuildContext context) {
    // Load the initial data for the [RolesEditDialog].
    initData() {
      popupDialogDataNotifier.value = {'id': roleId};
    }

    initData();

    return Text('ID: $roleId');
  }
}
