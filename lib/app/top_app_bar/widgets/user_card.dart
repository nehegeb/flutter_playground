// user_card.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_helper/app_helper.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/user/user.dart';

/// A card widget displaying the current user's information.
class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen for changes in the currently logged in [AppUser].
    // This will rebuild the [UserCard] when the user changes.
    return ValueListenableBuilder<AppUser?>(
      valueListenable: appUserNotifier,
      builder: (context, appUser, _) {
        final userName = appUser?.name ?? '';
        final userTitle = appUser?.title ?? '';

        // The user card.
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withAlpha(60),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.account_circle, size: 32),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // The currently logged in [AppUser]'s name.
                  Text(
                    appUser != null
                        ? userName
                        : Localization.getText('roles.guest'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  // The currently logged in [AppUser]'s title.
                  Text(
                    appUser != null
                        ? Localization.getText('roles.$userTitle')
                        : Localization.getText('roles.notLoggedIn'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
