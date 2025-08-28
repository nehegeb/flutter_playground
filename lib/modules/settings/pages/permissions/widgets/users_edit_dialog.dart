// users_edit_dialog.dart
//

import 'package:flutter/material.dart';

class UsersEditDialog extends StatelessWidget {
  final String userId;

  const UsersEditDialog({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Text('ID: $userId');
  }
}
