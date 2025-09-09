// users_tab.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_notifiers/is_mobile_device_notifier/is_mobile_device_notifier.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/permissions_page_utils.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/get_users_tab_data.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/users_edit_dialog_save.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/users_edit_dialog_delete.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/widgets/users_edit_dialog.dart';

/// The users tab of the app permissions.
class UsersTab extends StatefulWidget {
  const UsersTab({super.key});

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  List<Map<String, dynamic>>? _usersTableData;

  // Load the data for the users tab.
  Future<void> _loadUsersTableData() async {
    final data = await getUsersTabData();
    setState(() {
      _usersTableData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = isMobileDeviceNotifier.value;
    String activeMainModule = PermissionsPageUtils.activeMainModule;

    return FutureBuilder<void>(
      future: _usersTableData == null ? _loadUsersTableData() : null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_usersTableData == null) {
          return Stack(
            children: [
              // Centered message for when no data is available.
              Center(
                child: Text(
                  Localization.getText(
                    'pages.permissions.usersTab.errorNoData',
                  ),
                ),
              ),

              // 'Add' button at bottom right.
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  mini: true,
                  tooltip: Localization.getText('misc.buttons.add'),
                  onPressed: () => AppPopup.widgetDialog(
                    context: context,
                    title: Localization.getText(
                      'pages.permissions.usersTab.addNew',
                    ),
                    widget: UsersEditDialog(
                      userId: null,
                      mainModule: activeMainModule,
                    ),
                    onCancel: () {},
                    onSave: (data) async =>
                        await usersEditDialogSave(userData: data),
                  ),
                  child: const Icon(Icons.add, size: 20),
                ),
              ),
            ],
          );
        }

        return Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  dataRowMaxHeight: double.infinity,
                  showCheckboxColumn: false,
                  columns: [
                    // Column header for the [AppUser] name.
                    DataColumn(
                      label: Text(
                        Localization.getText(
                          'pages.permissions.usersTab.columnName',
                        ),
                      ),
                    ),

                    // Column header for the [AppUser]'s eMail address.
                    if (!isMobile)
                      DataColumn(
                        label: Text(
                          Localization.getText(
                            'pages.permissions.usersTab.columnEmail',
                          ),
                        ),
                      ),

                    // Column for the [AppUser]'s roles.
                    DataColumn(
                      label: Text(
                        Localization.getText(
                          'pages.permissions.usersTab.columnRoles',
                        ),
                      ),
                    ),
                  ],
                  rows: _usersTableData!.map<DataRow>((userData) {
                    final String userName = userData['name']?.toString() ?? '';
                    final bool isAdminUser = userData['isAdmin'];

                    return DataRow(
                      onSelectChanged: (selected) {
                        if (selected == true) {
                          if (isAdminUser) {
                            // For admin [AppUser]s, open the view dialog for the clicked-on table entry.
                            AppPopup.widgetDialog(
                              context: context,
                              title: userName,
                              widget: UsersEditDialog(
                                userId: userData['userId'],
                                mainModule: activeMainModule,
                              ),
                              onConfirm: () {},
                            );
                          } else {
                            // For normal [AppUser]s, open the edit dialog for the clicked-on table entry.
                            AppPopup.widgetDialog(
                              context: context,
                              title: userName,
                              widget: UsersEditDialog(
                                userId: userData['userId'],
                                mainModule: activeMainModule,
                              ),
                              onCancel: () {},
                              onSave: (data) async {
                                await usersEditDialogSave(userData: data);
                                await _loadUsersTableData();
                              },
                              onDelete: (id) async {
                                await usersEditDialogDelete(userId: id);
                                await _loadUsersTableData();
                              },
                            );
                          }
                        }
                      },
                      cells: [
                        // Column for the [AppUser] name.
                        DataCell(Text(userName)),

                        // Column for the [AppUser]'s eMail address.
                        if (!isMobile)
                          DataCell(Text(userData['email']?.toString() ?? '')),

                        // Column for the [AppUser]'s roles.
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: List<Widget>.generate(
                                (userData['roles'] as List<dynamic>? ?? [])
                                    .length,
                                (index) {
                                  final role =
                                      (userData['roles']
                                          as List<dynamic>)[index];
                                  final subModule =
                                      (userData['subModule']
                                                      as List<dynamic>? ??
                                                  [])
                                              .length >
                                          index
                                      ? (userData['subModule']
                                            as List<dynamic>)[index]
                                      : '';
                                  return Text(
                                    (subModule == null ||
                                            subModule.toString().isEmpty)
                                        ? role.toString()
                                        : '${subModule.toString()} ${role.toString()}',
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),

            // 'Add' button at bottom right.
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                mini: true,
                tooltip: Localization.getText('misc.buttons.add'),
                onPressed: () => AppPopup.widgetDialog(
                  context: context,
                  title: Localization.getText(
                    'pages.permissions.usersTab.addNew',
                  ),
                  widget: UsersEditDialog(
                    userId: null,
                    mainModule: activeMainModule,
                  ),
                  onCancel: () {},
                  onSave: (data) async =>
                      await usersEditDialogSave(userData: data),
                ),
                child: const Icon(Icons.add, size: 20),
              ),
            ),
          ],
        );
      },
    );
  }
}
