// user_menu.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';
import 'package:flutter_playground/app/app_helper/app_helper.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/misc/widgets/popup_menu_entry_compact.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/top_app_bar/widgets/language_menu_mobile.dart';

class UserMenu extends StatefulWidget {
  final bool isMobile;
  final String appLanguage;
  final ValueNotifier<AppUser?> appUserNotifier;

  const UserMenu({
    super.key,
    required this.isMobile,
    required this.appLanguage,
    required this.appUserNotifier,
  });

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      tooltip: '', // Remove unnecessary tooltip.
      onSelected: (selectedAction) async {
        if (selectedAction == 'login') {
          // Save the current url for redirection after login.
          AppRouterUtils.saveRedirectUrl();
          // Navigate to the [LoginPage].
          await context.push('/login');
        } else if (selectedAction == 'logout') {
          User.logout(context);
        } else if (selectedAction == 'toggleThemeMode') {
          setState(() {
            AppTheme.toggleBrightness();
          });
        }
      },
      itemBuilder: (context) {
        final isUserLoggedIn = User.user != null;
        return [
          // User Card.
          PopupMenuItem<String>(
            enabled: false,
            height: 80, // Bigger than default height (default is 48).
            // Listen for changes in the active [AppUser].
            // This will rebuild the [UserCard] when the active user changes.
            child: ValueListenableBuilder<AppUser?>(
              valueListenable: widget.appUserNotifier,
              builder: (context, appUser, _) {
                final userName = appUser?.name ?? '';
                final userTitle = appUser?.title ?? '';
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
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
                                ? AppHelper.toNameCase(userName)
                                : Localization.getText('roles.guest'),
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),

                          // The currently logged in [AppUser]'s title.
                          Text(
                            appUser != null
                                ? userTitle
                                : Localization.getText('roles.unauthorized'),
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.normal),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Move some buttons from the app bar into this menu for mobile devices.
          if (widget.isMobile) ...[
            // Separator line before mobile buttons.
            PopupMenuDivider(),

            // Theme mode toggle for mobile devices.
            PopupMenuEntryCompact(
              value: 'toggleThemeMode',
              selected: false,
              child: Row(
                children: [
                  Icon(
                    AppTheme.isDarkMode
                        ? Icons.wb_sunny_outlined
                        : Icons.nightlight_round,
                  ),
                  SizedBox(width: 8),
                  Text(Localization.getText('appBar.menu.switchThemeMode')),
                ],
              ),
            ),

            // Language selector for mobile devices as a button.
            // It is only shown if there are multiple languages available.
            if ((Localization.dbLanguagesData?.length ?? 0) > 1) ...[
              PopupMenuEntryCompact(
                value: 'languageSelector',
                selected: false,
                child: LanguageMenuMobile(appLanguage: widget.appLanguage),
              ),
            ],

            // Separator line after mobile buttons.
            PopupMenuDivider(),
          ],

          // Login/Logout options.
          if (!isUserLoggedIn)
            PopupMenuEntryCompact(
              value: 'login',
              selected: false,
              child: Text(Localization.getText('appBar.menu.login')),
            ),
          if (isUserLoggedIn)
            PopupMenuEntryCompact(
              value: 'logout',
              selected: false,
              child: Text(Localization.getText('appBar.menu.logout')),
            ),
        ];
      },
    );
  }
}
