// settings.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/pages/settings/settings_utils.dart';
import 'package:flutter_playground/pages/settings/widgets/users_settings_tab.dart';
import 'package:flutter_playground/pages/settings/widgets/modules_settings_tab.dart';
import 'package:flutter_playground/pages/settings/widgets/roles_settings_tab.dart';

/// The settings page.
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void dispose() {
    super.dispose();
    // Clear the users data as soon as the [SettingsPage] is closed.
    // This might have been loaded in any of the settings tabs.
    _clearUsersData();
  }

  // Clear the users data from the app.
  _clearUsersData() {
    User.clearDbUsersData();
  }

  @override
  Widget build(BuildContext context) {
    final String activeModule = SettingsUtils.activeMainModule;
    final bool isMainAppModule = activeModule == "main";

    return Stack(
      children: [
        // Scrollable main content column stretched across the screen.
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tab bar for different settings categories.
                DefaultTabController(
                  length: isMainAppModule ? 3 : 2,
                  child: Column(
                    children: [
                      // Tab bar headers.
                      TabBar(
                        tabs: [
                          if (isMainAppModule)
                            Tab(
                              text: Localization.getText(
                                'pages.settings.modulesTab.title',
                              ),
                            ),
                          Tab(
                            text: Localization.getText(
                              'pages.settings.usersTab.title',
                            ),
                          ),
                          Tab(
                            text: Localization.getText(
                              'pages.settings.rolesTab.title',
                            ),
                          ),
                        ],
                      ),
                      // Tab content.
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 146,
                        child: TabBarView(
                          children: isMainAppModule
                              ? [
                                  ModulesSettingsTab(),
                                  UsersSettingsTab(),
                                  RolesSettingsTab(),
                                ]
                              : [UsersSettingsTab(), RolesSettingsTab()],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
