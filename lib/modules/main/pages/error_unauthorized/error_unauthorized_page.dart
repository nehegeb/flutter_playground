// error_unauthorized_page.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_router/app_router.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// The '401 - Unauthorized' HTML error page.
class ErrorUnauthorizedPage extends StatelessWidget {
  const ErrorUnauthorizedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Title of the error.
        Text(
          Localization.getText('pages.errorUnauthorized.title'),
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Message explaining the error.
        Text(
          Localization.getText('pages.errorUnauthorized.message'),
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // A notification with a link to the [LoginPage].
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: TextButton(
              onPressed: () => appRouter.go('/login'),
              child: Text(
                Localization.getText('pages.home.messageLogin'),
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
