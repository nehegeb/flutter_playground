// error_no_view_permission.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';

class ErrorNoViewPermission extends StatelessWidget {
  const ErrorNoViewPermission({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Localization.getText('errors.noViewPermission'),
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
