// main_app_bar.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/app_router/app_router.dart';
import 'package:flutter_playground/app/app_user/app_user.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';
import 'package:flutter_playground/app/app_notifiers/user_device_notifier.dart';
import 'package:flutter_playground/app/main_app_bar/widgets/language_menu.dart';
import 'package:flutter_playground/app/main_module_bar/main_module_bar_utils.dart';
import 'package:flutter_playground/app/app_helper/app_helper.dart';
import 'package:flutter_playground/app/misc/widgets/popup_menu_entry_compact.dart';
import 'package:flutter_playground/pages/login/login.dart';

/// A horizontal app bar at the top of the app.
/// It contains a menu button to toggle the [MainModuleBar],
/// a title with the app name and module name,
/// and a user settings menu with the user's profile and several options.
///
/// The [MainAppBar] is responsive and adapts to mobile and wide screen layouts.
/// For wide screens, it uses the whole width including some option buttons to the right.
/// On mobile devices, it shows a compact version and moves the options to the user settings menu.
class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  void initState() {
    super.initState();
  }

  // Generate the title to display in the app bar.
  String getAppBarTitle() {
    final appName = Localization.getText('appName');

    // Get the module title from the url.
    final moduleName = AppRouter.getModuleTitle(context);

    // Check the device type.
    final bool isMobileDevice = UserDeviceNotifier.isMobile;

    // Build the title based on the module.
    if (moduleName.isNotEmpty && moduleName != '') {
      if (isMobileDevice) {
        // On mobile devices, show only the module name.
        return moduleName;
      } else {
        // On wide screens, show both the app name and the module name.
        return '$appName   |   $moduleName';
      }
    }
    // If no module name is available, just return the app name.
    return appName;
  }

  @override
  Widget build(BuildContext context) {
    final String appLanguage = Localization.appLanguage;
    final double spacingWidth = 8;

    // Regarding the back button in the leading section.
    bool hasBackButton = Navigator.of(context).canPop();
    double leadingWidth = hasBackButton ? 100 : 56;

    // Check the device type.
    final bool isMobileDevice = UserDeviceNotifier.isMobile;

    return SafeArea(
      child: AppBar(
        leadingWidth: leadingWidth,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: spacingWidth),
            // Show the back button if the navigator can pop.
            if (hasBackButton) ...[
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).maybePop(),
                tooltip: '',
              ),
              SizedBox(width: spacingWidth),
            ],
            // Menu button for the [MainModuleBar].
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Do different things depending on the screen size / device type.
                if (isMobileDevice) {
                  // Toggle the visibility of the module bar on mobile devices.
                  MainModuleBarUtils.toggleVisibility();
                } else {
                  // Toggle the width of the module bar for wide screens.
                  MainModuleBarUtils.toggleWidth();
                }
              },
              tooltip: '', // Remove unnecessary tooltip.
            ),
          ],
        ),
        title: Row(
          children: [
            // App logo.
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: 35,
                child: Image.asset(
                  'assets/app/images/appLogo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 20),
            Flexible(
              child: Text(
                getAppBarTitle(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),

        actions: [
          // Light/Dark mode toggle for wide screens.
          if (!isMobileDevice) ...[
            IconButton(
              icon: Icon(
                AppTheme.isDarkMode
                    ? Icons.wb_sunny_outlined
                    : Icons.nightlight_round,
              ),
              onPressed: () {
                setState(() {
                  AppTheme.toggleBrightness();
                });
              },
              tooltip: '', // Remove unnecessary tooltip.
            ),
            SizedBox(width: spacingWidth),
          ],

          // Language selector for wide screens.
          if (!isMobileDevice) ...[
            LanguageMenu(
              appLanguage: appLanguage,
              onSelected: (selectedLanguage) async {
                await Localization.setLanguage(language: selectedLanguage);
              },
            ),
            SizedBox(width: spacingWidth),
          ],

          // Menu.
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            tooltip: '', // Remove unnecessary tooltip.
            onSelected: (selectedAction) async {
              if (selectedAction == 'login') {
                await context.push('/login');
              } else if (selectedAction == 'logout') {
                LoginPage.logout(context);
              } else if (selectedAction == 'toggleThemeMode') {
                setState(() {
                  AppTheme.toggleBrightness();
                });
              }
            },
            itemBuilder: (context) {
              final isLoggedIn = appUserNotifier.value != null;
              return [
                // User Card.
                PopupMenuItem<String>(
                  enabled: false,
                  height: 80, // Bigger than default height (default is 48).
                  child: ValueListenableBuilder<AppUser?>(
                    valueListenable: appUserNotifier,
                    builder: (context, user, _) {
                      final username = user?.username ?? '';
                      final role = user?.role ?? '';
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withAlpha(60),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.account_circle, size: 32),
                            SizedBox(width: spacingWidth),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  username.isNotEmpty
                                      ? AppHelper.toNameCase(username)
                                      : Localization.getText(
                                          'authorization.roles.guest',
                                        ),
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  role.isNotEmpty
                                      ? Localization.getText(
                                          'authorization.roles.$role',
                                        )
                                      : Localization.getText(
                                          'authorization.roles.unauthorized',
                                        ),
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
                if (isMobileDevice) ...[
                  PopupMenuDivider(), // Separator line.
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
                        Text(
                          Localization.getText('appBar.menu.switchThemeMode'),
                        ),
                      ],
                    ),
                  ),

                  // Language selector for mobile devices as a button.
                  PopupMenuEntryCompact(
                    value: '', // No value, handle tap manually.
                    selected: false,
                    child: Builder(
                      builder: (context) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            // Close the current menu.
                            Navigator.of(context).pop();
                            // Wait for the menu to close before showing the next.
                            await Future.delayed(
                              const Duration(milliseconds: 100),
                            );
                            // Show the language selector popup.
                            final RenderBox button =
                                context.findRenderObject() as RenderBox;
                            final RenderBox overlay =
                                Overlay.of(context).context.findRenderObject()
                                    as RenderBox;
                            final Offset position = button.localToGlobal(
                              Offset.zero,
                              ancestor: overlay,
                            );
                            final selectedLanguage = await showMenu<String>(
                              context: context,
                              position: RelativeRect.fromLTRB(
                                position.dx,
                                position.dy,
                                position.dx + button.size.width,
                                position.dy + button.size.height,
                              ),
                              items: LanguageMenu.menuItems(
                                context,
                                appLanguage,
                              ),
                            );
                            if (selectedLanguage != null) {
                              await Localization.setLanguage(
                                language: selectedLanguage,
                              );
                            }
                          },
                          child: Row(
                            children: [
                              CountryFlag.fromCountryCode(
                                Localization.getText('language.countryCode'),
                                shape: Circle(),
                                width: 24,
                              ),
                              SizedBox(width: 8),
                              Text(
                                Localization.getText(
                                  'appBar.menu.switchLanguage',
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  PopupMenuDivider(), // Separator line.
                ],

                // Login/Logout options.
                if (!isLoggedIn)
                  PopupMenuEntryCompact(
                    value: 'login',
                    selected: false,
                    child: Text(Localization.getText('appBar.menu.login')),
                  ),
                if (isLoggedIn)
                  PopupMenuEntryCompact(
                    value: 'logout',
                    selected: false,
                    child: Text(Localization.getText('appBar.menu.logout')),
                  ),
              ];
            },
          ),
          SizedBox(width: spacingWidth),
        ],
      ),
    );
  }
}
