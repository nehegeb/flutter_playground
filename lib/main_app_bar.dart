/// main_app_bar.dart
///
/// Provides a reusable [MainAppBar] widget for the app.
/// It displays a given module title and a language selector popup menu,
/// as well as a user profile menu with login/logout options.
library main_app_bar;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/helpers/app_router.dart';
import 'package:country_flags/country_flags.dart';
import 'localization/localization.dart';
import 'main_module_bar.dart';
import 'helpers/ui_widgets.dart';
import 'helpers/app_permissions.dart';
import 'helpers/global_notifiers.dart';
import 'module_pages/login_page.dart';

/// A customizable app bar for the app.
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

    // Build the title based on the module.
    if (moduleName.isNotEmpty && moduleName != '') {
      return '$appName   |   $moduleName';
    }
    return appName;
  }

  // Converts a string to name case (capitalize each word).
  // TODO: Move to helper_methods.dart (or helper_widgets.dart).
  String toNameCase(String input) {
    return input
        .split(' ')
        .map(
          (word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1)}'
              : '',
        )
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final String currentLanguage = currentLanguageNotifier.value;
    final double spacingWidth = 8;

    // Regarding the back button in the leading section.
    bool hasBackButton = Navigator.of(context).canPop();
    double leadingWidth = hasBackButton ? 100 : 56;

    // Check the device type.
    final bool isMobileDevice = GlobalNotifiers.isMobile();

    // Toggle the width of the module bar between wide and narrow, updating the notifier.
    void toggleBarNotifier(String key) {
      // Only allow specific keys.
      if (key != 'isBarHidden' && key != 'isBarWide') {
        throw ArgumentError(
          "Invalid key: $key. Allowed keys are 'isBarHidden', 'isBarWide'.",
        );
      }
      // Toggle the specified key in the notifier.
      final current = currentModuleBarNotifier.value.isNotEmpty
          ? currentModuleBarNotifier.value.first
          : {key: true, key: false};
      final updated = {...current, key: !(current[key] as bool)};
      // Update the notifier with the new value.
      currentModuleBarNotifier.value = [updated];
    }

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
                  toggleBarNotifier('isBarHidden');
                } else {
                  // Toggle the width of the module bar for wide screens.
                  toggleBarNotifier('isBarWide');
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
                child: Image.asset('lib/img/appLogo.png', fit: BoxFit.contain),
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
          // Language selector.
          PopupMenuButton<String>(
            icon: CountryFlag.fromCountryCode(
              Localization.getText('language.countryCode'),
              shape: Circle(),
              width: 24,
            ),
            tooltip: "", // Remove unnecessary tooltip.
            initialValue: currentLanguage,
            onSelected: (selectedLanguage) async {
              await Localization.setCurrentLanguage(selectedLanguage);
            },
            itemBuilder: (context) => [
              PopupMenuEntryCompact(
                value: 'en',
                selected: currentLanguage == 'en',
                child: FlagMenuItem(
                  countryCode: 'us',
                  label: Localization.getText(
                    'appBar.languageSelector.english',
                  ),
                ),
              ),
              PopupMenuEntryCompact(
                value: 'de',
                selected: currentLanguage == 'de',
                child: FlagMenuItem(
                  countryCode: 'de',
                  label: Localization.getText('appBar.languageSelector.german'),
                ),
              ),
              // NOTE: Add more languages here as needed.
            ],
          ),
          SizedBox(width: spacingWidth),

          // Logout selector.
          PopupMenuButton<String>(
            icon: const Icon(Icons.person),
            tooltip: '', // Remove unnecessary tooltip.
            onSelected: (selectedAction) async {
              if (selectedAction == 'login') {
                await context.push('/login');
              } else if (selectedAction == 'logout') {
                LoginPage.logout(context);
              }
            },
            itemBuilder: (context) {
              final isLoggedIn = currentUserNotifier.value != null;
              return [
                // User Card.
                PopupMenuItem<String>(
                  enabled: false,
                  height: 80, // double the default height (default is 48)
                  child: ValueListenableBuilder<User?>(
                    valueListenable: currentUserNotifier,
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
                                      ? toNameCase(username)
                                      : '',
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
                                          'authorization.roles.guest',
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
                // Login/Logout options.
                if (!isLoggedIn)
                  PopupMenuEntryCompact(
                    value: 'login',
                    selected: false,
                    child: Text(
                      Localization.getText('appBar.profileSelector.login'),
                    ),
                  ),
                if (isLoggedIn)
                  PopupMenuEntryCompact(
                    value: 'logout',
                    selected: false,
                    child: Text(
                      Localization.getText('appBar.profileSelector.logout'),
                    ),
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

/// A menu item for the language selector that displays a country flag and a label.
class FlagMenuItem extends StatelessWidget {
  final String countryCode;
  final String label;

  const FlagMenuItem({
    required this.countryCode,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CountryFlag.fromCountryCode(
          countryCode,
          shape: RoundedRectangle(4),
          width: 30,
          height: 20,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
