// modules_edit_dialog.dart
//

import 'package:flutter/material.dart';

class ModulesEditDialog extends StatelessWidget {
  final String moduleId;

  const ModulesEditDialog({super.key, required this.moduleId});

  @override
  Widget build(BuildContext context) {
    return Text('ID: $moduleId');
  }
}
