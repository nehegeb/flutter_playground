// error_bad_request_page.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// The '400 - Bad Request' HTML error page.
class ErrorBadRequestPage extends StatelessWidget {
  final String? errorMessage;

  const ErrorBadRequestPage({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Title of the error.
        Text(
          Localization.getText('modules.main.pages.errorBadRequest.title'),
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // Message explaining the error.
        Text(
          Localization.getText('modules.main.pages.errorBadRequest.message'),
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
