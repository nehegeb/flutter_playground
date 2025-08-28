// user_menu.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';
import 'package:flutter_playground/app/app_helper/widgets/popup_menu_entry_compact.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/top_app_bar/widgets/user_card.dart';
import 'package:flutter_playground/app/top_app_bar/widgets/button_brightness_mobile.dart';
import 'package:flutter_playground/app/top_app_bar/widgets/button_languages_mobile.dart';
import 'package:flutter_playground/app/top_app_bar/logic/show_languages_select_overlay.dart';

/// The user menu for the app.
/// It is shown when opening the menu at the top right of the [TopAppBar].
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
          // Logout the currently logged in [AppUser].
          await User.logout(context);
        } else if (selectedAction == 'toggleAppBrightness') {
          // Switch the app brightness.
          setState(() {
            AppTheme.toggleBrightness();
          });
        } else if (selectedAction == 'switchAppLanguage') {
          // Switch the app language.
          showLanguagesSelectOverlay(context);
        }
      },
      itemBuilder: (context) {
        final isUserLoggedIn = User.user != null;
        return [
          PopupMenuItem<String>(
            enabled: false,
            height: 80, // Bigger than default height (default is 48).
            child: UserCard(),
          ),

          // Move some buttons from the app bar into this menu for mobile devices.
          if (widget.isMobile) ...[
            // Separator line before mobile buttons.
            PopupMenuDivider(),

            // Button to toggle app brightness for mobile devices.
            buttonBrightnessMobile(context),

            // Button to show language selector for mobile devices.
            // It is only shown if there are multiple languages available.
            if ((Localization.dbLanguagesData?.length ?? 0) > 1) ...[
              buttonLanguagesMobile(context),
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
