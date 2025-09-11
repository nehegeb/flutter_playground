// error_gateway_timeout_page.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// The '504 - Gateway Timeout' HTML error page.
class ErrorGatewayTimeoutPage extends StatelessWidget {
  const ErrorGatewayTimeoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Title of the error.
        Text(
          Localization.getText('pages.errorGatewayTimeout.title'),
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Message explaining the error.
        Text(
          Localization.getText('pages.errorGatewayTimeout.message'),
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
