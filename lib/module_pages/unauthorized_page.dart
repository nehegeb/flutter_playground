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
        // Title of the unauthorized page.
        Text(
          Localization.getText('unauthorizedPage.title'),
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Message explaining the unauthorized access.
        Text(
          Localization.getText('unauthorizedPage.message'),
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
