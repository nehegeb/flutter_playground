/// unauthorized_page.dart
///
library unauthorized_page;

import 'package:flutter/material.dart';
import 'package:flutter_playground/localization/localization.dart';

/// The unauthorized page.
class UnauthorizedPage extends StatelessWidget {
  const UnauthorizedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Localization.getText('unauthorizedPage.title')),
        Text(Localization.getText('unauthorizedPage.message')),
      ],
    );
  }
}
