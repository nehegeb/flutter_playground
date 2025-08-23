// user_menu.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/misc/widgets/popup_menu_entry_compact.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/top_app_bar/widgets/user_card.dart';
import 'package:flutter_playground/app/top_app_bar/widgets/language_menu_mobile.dart';

class UserMenu extends StatefulWidget {
  final bool isMobile;

  const UserMenu({super.key, required this.isMobile});

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
          AppRouterUtils.saveRedirectUrl(context);
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
            child: UserCard(),
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
                child: LanguageMenuMobile(),
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
