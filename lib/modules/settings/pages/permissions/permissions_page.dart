// permissions_page.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_helper/widgets/error_no_view_permission.dart';
import 'package:flutter_playground/app/permissions/permissions.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/permissions_page_utils.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/widgets/users_tab.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/widgets/modules_tab.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/widgets/roles_tab.dart';

/// The permissions page.
class PermissionsPage extends StatefulWidget {
  const PermissionsPage({super.key});

  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
  @override
  void dispose() {
    super.dispose();
    // Clear the users data as soon as the [PermissionsPage] is closed.
    // This might have been loaded in any of the permissions tabs.
    _clearUsersData();
  }

  // Clear the users data from the app.
  _clearUsersData() {
    User.clearDbUsersData();
  }

  @override
  Widget build(BuildContext context) {
    // If the [AppUser] has no '.view' permission for this page,
    // show them an error message instead.
    String activeMainModule = PermissionsPageUtils.activeMainModule;
    if (!Permissions.check(permission: '$activeMainModule.permissions.view')) {
      return ErrorNoViewPermission();
    }

    final String activeModule = PermissionsPageUtils.activeMainModule;
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
                  length: isMainAppModule ? 1 : 2,
                  child: Column(
                    children: [
                      // Tab bar headers.
                      TabBar(
                        tabs: [
                          if (isMainAppModule)
                            Tab(
                              text: Localization.getText(
                                'pages.permissions.modulesTab.title',
                              ),
                            ),
                          if (!isMainAppModule)
                            Tab(
                              text: Localization.getText(
                                'pages.permissions.usersTab.title',
                              ),
                            ),
                          if (!isMainAppModule)
                            Tab(
                              text: Localization.getText(
                                'pages.permissions.rolesTab.title',
                              ),
                            ),
                        ],
                      ),
                      // Tab content.
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 146,
                        child: TabBarView(
                          children: isMainAppModule
                              ? [ModulesTab()]
                              : [UsersTab(), RolesTab()],
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
