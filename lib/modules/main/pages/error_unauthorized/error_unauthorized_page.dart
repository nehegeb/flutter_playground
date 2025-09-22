// error_unauthorized_page.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_router/app_router.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// The '401 - Unauthorized' HTML error page.
class ErrorUnauthorizedPage extends StatelessWidget {
  final String? errorMessage;

  const ErrorUnauthorizedPage({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Title of the error.
        Text(
          Localization.getText('modules.main.pages.errorUnauthorized.title'),
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // Message explaining the error.
        Text(
          Localization.getText('modules.main.pages.errorUnauthorized.message'),
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        // Display the [errorMessage] if given.
        if (errorMessage != null) ...[
          Text(
            errorMessage!,
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
        ],

        // A button to the [LoginPage].
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: TextButton(
              onPressed: () => appRouter.go('/login'),
              child: Text(
                Localization.getText('modules.main.pages.home.messageLogin'),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
