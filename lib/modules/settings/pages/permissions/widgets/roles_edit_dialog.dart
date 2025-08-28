// roles_edit_dialog.dart
//

import 'package:flutter/material.dart';

class RolesEditDialog extends StatelessWidget {
  final String roleId;

  const RolesEditDialog({super.key, required this.roleId});

  @override
  Widget build(BuildContext context) {
    return Text('ID: $roleId');
  }
}
