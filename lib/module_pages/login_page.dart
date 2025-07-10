/// login_page.dart
///
library login_page;

import 'package:flutter/material.dart';
import 'package:flutter_playground/localization/localization.dart';

/// The login page.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(Localization.getText('loginPage.title'))],
    );
  }
}
