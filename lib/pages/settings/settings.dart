// settings.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/pages/settings/widgets/users_settings_tab.dart';
import 'package:flutter_playground/pages/settings/widgets/roles_settings_tab.dart';
import 'package:flutter_playground/pages/settings/widgets/modules_settings_tab.dart';

/// The settings page.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  length: 3,
                  child: Column(
                    children: [
                      // Tab bar headers.
                      TabBar(
                        tabs: [
                          Tab(
                            text: Localization.getText('pages.settings.users'),
                          ),
                          Tab(
                            text: Localization.getText('pages.settings.roles'),
                          ),
                          Tab(
                            text: Localization.getText(
                              'pages.settings.modules',
                            ),
                          ),
                        ],
                      ),
                      // Tab content.
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 146,
                        child: TabBarView(
                          children: [
                            UsersSettingsTab(),
                            RolesSettingsTab(),
                            ModulesSettingsTab(),
                          ],
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
