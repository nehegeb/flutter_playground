// home.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/app_helper/app_helper.dart';

/// The home page of the app.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Define the welcome message for the home page.
  static String get welcomeMessage {
    // Get the current user from the app permissions.
    final AppUser? user = User.user;
    final String userName = user?.name ?? '';

    // If no user is logged in, return a generic welcome message.
    if (user == null || userName.isEmpty) {
      return '${Localization.getText('pages.home.messageWelcome')}!';
    }
    // Otherwise, display the user name next to the welcome message.
    return '${Localization.getText('pages.home.messageWelcome')} ${AppHelper.toNameCase(userName)}!';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Scrollable main content column stretched across the screen.
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title of the home page.
                  Text(
                    welcomeMessage,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // A notification with a link to the login page if the user is not logged in.
                  if (User.user == null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Center(
                        child: TextButton(
                          onPressed: () => context.go('/login'),
                          child: Text(
                            Localization.getText('pages.home.messageLogin'),
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),

                  // A notification if the currently logged in [AppUser] doesn't have any module roles yet.
                  if (User.user != null && (User.user!.roles!.isEmpty))
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            Localization.getText('pages.home.messageNoModules'),
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        // 'About' button at bottom right.
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            mini: true,
            tooltip: Localization.getText('pages.about.title'),
            onPressed: () {
              context.go('/about');
            },
            child: const Icon(Icons.info_outline, size: 20),
          ),
        ),
      ],
    );
  }
}
