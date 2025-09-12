// error_service_unavailable_page.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// The '503 - Service Unavailable' HTML error page.
class ErrorServiceUnavailablePage extends StatelessWidget {
  final String? errorMessage;

  const ErrorServiceUnavailablePage({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Title of the error.
        Text(
          Localization.getText('pages.errorServiceUnavailable.title'),
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // Message explaining the error.
        Text(
          Localization.getText('pages.errorServiceUnavailable.message'),
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),

        // Display the [errorMessage] if given.
        if (errorMessage != null) ...[
          SizedBox(height: 32),
          Text(
            errorMessage!,
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
