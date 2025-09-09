// users_edit_dialog.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_helper/widgets/dropdown_list.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/get_users_tab_data.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/users_edit_dialog_init.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/users_edit_dialog_add_role.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/users_edit_dialog_delete_role.dart';

List<AppRole>? availableAppRolesForAppUser;

class UsersEditDialog extends StatefulWidget {
  final String? userId;
  final String mainModule;

  const UsersEditDialog({super.key, this.userId, required this.mainModule});

  @override
  State<UsersEditDialog> createState() => _UsersEditDialogState();
}

class _UsersEditDialogState extends State<UsersEditDialog> {
  final TextEditingController _newUserId = TextEditingController();
  AppRole? selectedRole;
  bool isAddRoleShown = false;
  bool isAddUserActive = false;
  bool isNewUser = false;

  @override
  void initState() {
    super.initState();
    isNewUser = widget.userId == null;

    // Load the users data for the [UsersEditDialog].
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await usersEditDialogInit(
        userId: widget.userId,
        mainModule: widget.mainModule,
      );
    });
  }

  @override
  void dispose() {
    _newUserId.dispose();
    super.dispose();
  }

  // Add a new [AppUser] to the given [mainModule].
  Future<void> addNewUser({required String userId}) async {
    // Reload the users data to include the new user.
    await usersEditDialogInit(userId: userId, mainModule: widget.mainModule);

    // Switch from add new user form to edit user dialog.
    setState(() {
      isNewUser = false;
    });

    // Activate the save button until the required fields are filled.
    AppPopup.activateConfirmationButton();
  }

  // Get all [AppUser]s that are not yet added to the given [mainModule].
  Future<List<dynamic>?> getUsers() async {
    List<dynamic>? allUsers = User.dbUsersData;
    List<Map<String, dynamic>>? mainModuleUsers = await getUsersTabData();

    // Get all users that are not yet assigned to the given [mainModule].
    List<dynamic>? eligibleUsers = [];
    if (allUsers != null) {
      for (var user in allUsers) {
        bool isUserInTabData =
            mainModuleUsers?.any(
              (tabUser) => tabUser['userId'] == user['id'],
            ) ??
            false;
        if (!isUserInTabData) {
          eligibleUsers.add(user);
        }
      }
    }

    return eligibleUsers;
  }

  @override
  Widget build(BuildContext context) {
    double textSpacer = 12;
    double lineSpacer = 8;

    // Display the add new user form.
    if (isNewUser) {
      // Deactivate the save button until the required fields are filled.
      AppPopup.deactivateConfirmationButton();

      return Column(
        children: [
          // A [DropdownList] for the new user.
          Row(
            children: [
              Text(
                Localization.getText('pages.permissions.usersTab.columnName'),
              ),
              Text(':'),
              SizedBox(width: textSpacer),
              SizedBox(
                width: 200,
                child: FutureBuilder<List<dynamic>?>(
                  future: getUsers(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox(
                        height: 40,
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    }
                    final users = snapshot.data ?? [];
                    return DropdownList<dynamic>(
                      items: users,
                      itemLabel: (user) => user['name'],
                      filterEnabled: true,
                      onChanged: (selectedUser) {
                        _newUserId.text = selectedUser['id'];
                        // If any user is selected, activate the add button, otherwise deactivate it.
                        if (selectedUser != null) {
                          setState(() {
                            isAddUserActive = true;
                          });
                        } else {
                          setState(() {
                            isAddUserActive = false;
                          });
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: lineSpacer),

          // The add button.
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: isAddUserActive
                  ? () async => await addNewUser(userId: _newUserId.text)
                  : null,
              child: Text(Localization.getText('misc.buttons.add')),
            ),
          ),
        ],
      );
    }

    // Display the edit user dialog.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<Map<String, dynamic>?>(
          valueListenable: popupDialogDataNotifier,
          builder: (context, data, _) {
            final appUser = data?['appUser'] as AppUser?;
            final userAppRoles = appUser?.roles ?? [];

            if (data == null || appUser == null) {
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
                        Text(appUser.email),
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

                        // Column header for role actions for normal [AppUser]s.
                        if (!data['isAdmin'])
                          DataColumn(
                            label: Align(
                              alignment: Alignment.centerRight,
                              child: !isAddRoleShown
                                  ? IconButton(
                                      icon: const Icon(Icons.add),
                                      tooltip: Localization.getText(
                                        'misc.buttons.add',
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isAddRoleShown = true;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.close),
                                      tooltip: Localization.getText(
                                        'misc.buttons.cancel',
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isAddRoleShown = false;
                                          selectedRole = null;
                                        });
                                      },
                                    ),
                            ),
                            numeric: true,
                          ),
                      ],
                      rows: [
                        // A row for a new entry to the list.
                        if (isAddRoleShown)
                          DataRow(
                            color: WidgetStateProperty.resolveWith<Color?>((
                              Set<WidgetState> states,
                            ) {
                              return Theme.of(context).colorScheme.surface;
                            }),
                            cells: [
                              // Column for module roles.
                              DataCell(
                                DropdownList<AppRole>(
                                  items: (availableAppRolesForAppUser ?? [])
                                      // Only include the [AppRole]s that are not already in the [AppUser].
                                      .where(
                                        (availableRole) => !(userAppRoles.any(
                                          (userRole) =>
                                              userRole.id == availableRole.id,
                                        )),
                                      )
                                      .toList(),
                                  filterEnabled: true,
                                  itemLabel: (appRole) =>
                                      (appRole.subModuleIdTitle
                                          .toString()
                                          .isEmpty)
                                      ? appRole.idTitle.toString()
                                      : '${appRole.subModuleIdTitle.toString()} ${appRole.idTitle.toString()}',
                                  onChanged: (selectedAppRole) {
                                    setState(() {
                                      selectedRole = selectedAppRole;
                                    });
                                  },
                                ),
                              ),

                              // Column for role actions for normal [AppUser]s.
                              DataCell(
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.check),
                                        tooltip: Localization.getText(
                                          'misc.buttons.add',
                                        ),
                                        onPressed: selectedRole == null
                                            ? null
                                            : () {
                                                usersEditDialogAddRole(
                                                  appRole: selectedRole,
                                                );
                                                setState(() {
                                                  isAddRoleShown = false;
                                                  selectedRole = null;
                                                });
                                              },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                        // All the list entries.
                        if (userAppRoles.isNotEmpty)
                          ...userAppRoles.map((role) {
                            // Define the complete name of the [AppRole].
                            String roleNameComplete =
                                (role.subModuleIdTitle.toString().isEmpty)
                                ? role.idTitle.toString()
                                : '${role.subModuleIdTitle.toString()} ${role.idTitle.toString()}';

                            return DataRow(
                              cells: [
                                // Column for module roles.
                                DataCell(Text(roleNameComplete)),

                                // Column for role actions for normal [AppUser]s.
                                if (!data['isAdmin'])
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            tooltip: Localization.getText(
                                              'misc.buttons.delete',
                                            ),
                                            onPressed: () =>
                                                usersEditDialogDeleteRole(
                                                  roleId: role.id,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          }),
                      ],
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
