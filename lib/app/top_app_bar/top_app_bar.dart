// top_app_bar.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';
import 'package:flutter_playground/app/app_notifiers/is_mobile_device_notifier/is_mobile_device_notifier.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/module_bar/module_bar_utils.dart';
import 'package:flutter_playground/app/top_app_bar/widgets/button_brightness.dart';
import 'package:flutter_playground/app/top_app_bar/widgets/button_languages.dart';
import 'package:flutter_playground/app/top_app_bar/widgets/user_menu.dart';

/// A horizontal app bar at the top of the app.
/// It contains a menu button to toggle the [ModuleBar],
/// a title with the app name and module name,
/// and a user settings menu with the user's profile and several options.
///
/// The [TopAppBar] is responsive and adapts to mobile and wide screen layouts.
/// For wide screens, it uses the whole width including some option buttons to the right.
/// On mobile devices, it shows a compact version and moves the options to the user settings menu.
class TopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  State<TopAppBar> createState() => _TopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopAppBarState extends State<TopAppBar> {
  @override
  void initState() {
    super.initState();
  }

  // Generate the title to display in the app bar.
  String getAppBarTitle(bool isMobile) {
    final appName = Localization.getText('appName');

    // Get the module title.
    final moduleName = AppRouterUtils.getMainModuleTitle(context);

    // Build the title based on the module.
    if (moduleName.isNotEmpty && moduleName != '') {
      if (isMobile) {
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
    final double spacingWidth = 8;

    // Regarding the back button in the leading section.
    bool hasBackButton = Navigator.of(context).canPop();
    double leadingWidth = hasBackButton ? 100 : 56;

    return ValueListenableBuilder<bool>(
      valueListenable: isMobileDeviceNotifier,
      builder: (context, isMobile, _) {
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
                    tooltip: Localization.getText('appBar.back'),
                  ),
                  SizedBox(width: spacingWidth),
                ],
                // Menu button for the [ModuleBar].
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    // Do different things depending on the screen size / device type.
                    if (isMobile) {
                      // Toggle the visibility of the module bar on mobile devices.
                      ModuleBarUtils.toggleVisibility();
                    } else {
                      // Toggle the width of the module bar for wide screens.
                      ModuleBarUtils.toggleWidth();
                    }
                  },
                  tooltip: Localization.getText('appBar.moduleBar'),
                ),
              ],
            ),
            title: Row(
              children: [
                // App logo.
                GestureDetector(
                  onTap: () => context.go('/'),
                  child: SizedBox(
                    height: 35,
                    child: Image.asset(
                      'assets/app/images/appLogo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                // App title.
                Flexible(
                  child: Text(
                    getAppBarTitle(isMobile),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),

            actions: [
              // Display some buttons for wide screens.
              if (!isMobile) ...[
                // Button to toggle app brightness for wide screens.
                ButtonBrightness(),
                SizedBox(width: spacingWidth),

                // Button to show language selector for wide screens.
                // It is only shown if there are multiple languages available.
                if ((Localization.dbLanguagesData?.length ?? 0) > 1) ...[
                  ButtonLanguages(),
                  SizedBox(width: spacingWidth),
                ],
              ],

              // User menu.
              UserMenu(isMobile: isMobile),
              SizedBox(width: spacingWidth),
            ],
          ),
        );
      },
    );
  }
}
