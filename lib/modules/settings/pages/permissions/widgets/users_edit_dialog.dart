// users_edit_dialog.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/permissions_page_utils.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/users_edit_dialog_init.dart';

class UsersEditDialog extends StatelessWidget {
  final String? userId;
  final String mainModule;

  const UsersEditDialog({super.key, this.userId, required this.mainModule});

  @override
  Widget build(BuildContext context) {
    bool isNewUser = userId == null;

    // Initialize the data for the [UsersEditDialog].
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await usersEditDialogInit(userId: userId, mainModule: mainModule);
    });

    String activeMainModule = PermissionsPageUtils.activeMainModule;
    double textSpacer = 12;
    double lineSpacer = 8;

    if (isNewUser) {
      return Text('UNDER DEVELOPMENT');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<Map<String, dynamic>?>(
          valueListenable: popupDialogDataNotifier,
          builder: (context, data, _) {
            final appUser = data?['appUser'] as AppUser?;
            final userAppRoles = appUser?.roles ?? [];

            if (data == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The eMail address of the user.
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          Localization.getText(
                            'pages.permissions.usersTab.columnEmail',
                          ),
                        ),
                        Text(':'),
                        SizedBox(width: textSpacer),
                        Text(appUser?.email ?? ''),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: lineSpacer),

                // The list of user roles.
                ConstrainedBox(
                  // This height constraint is needed to make list scrollable.
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      showCheckboxColumn: false,
                      columns: [
                        // Column header for roles.
                        DataColumn(
                          label: Text(
                            Localization.getText(
                              'pages.permissions.usersTab.columnRoles',
                            ),
                          ),
                        ),

                        // Column header for role actions.
                        DataColumn(
                          label: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              tooltip: Localization.getText('misc.buttons.add'),
                              onPressed: () {},
                            ),
                          ),
                          numeric: true,
                        ),
                      ],
                      rows: userAppRoles.isEmpty
                          ? []
                          : userAppRoles.map((role) {
                              // Define the complete name of the [AppRole].
                              String roleNameComplete =
                                  (role.subModuleIdTitle.toString().isEmpty)
                                  ? role.idTitle.toString()
                                  : '${role.subModuleIdTitle.toString()} ${role.idTitle.toString()}';

                              // Check whether this is an admin role.
                              List<String>? rolePermissions = role.permissions;
                              bool isAdminRole =
                                  rolePermissions != null &&
                                  rolePermissions.any(
                                    (perm) => perm == ('$activeMainModule.*'),
                                  );

                              return DataRow(
                                cells: [
                                  // column for module roles.
                                  DataCell(Text(roleNameComplete)),

                                  // Column for role actions.
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        children: [
                                          if (!isAdminRole)
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              tooltip: Localization.getText(
                                                'misc.buttons.delete',
                                              ),
                                              onPressed: () {},
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
