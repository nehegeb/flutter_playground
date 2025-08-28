// users_tab.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/get_users_tab_data.dart';
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
    _usersTableData = await getUsersTabData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _usersTableData == null ? _loadUsersTableData() : null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_usersTableData == null) {
          return Center(
            child: Text(
              Localization.getText('pages.permissions.usersTab.errorNoData'),
            ),
          );
        }
        return SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: DataTable(
              dataRowMaxHeight: double.infinity,
              showCheckboxColumn: false,
              columns: [
                DataColumn(
                  label: Text(
                    Localization.getText(
                      'pages.permissions.usersTab.columnName',
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    Localization.getText(
                      'pages.permissions.usersTab.columnEmail',
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    Localization.getText(
                      'pages.permissions.usersTab.columnRoles',
                    ),
                  ),
                ),
              ],
              rows: _usersTableData!.map<DataRow>((userData) {
                String userName = userData['name']?.toString() ?? '';

                return DataRow(
                  onSelectChanged: (selected) {
                    if (selected == true) {
                      // Open the edit dialog for the clicked-on table entry.
                      AppPopup.widgetDialog(
                        context: context,
                        title: userName,
                        widget: UsersEditDialog(userId: userData['userId']),
                      );
                    }
                  },
                  cells: [
                    // Column for the user name.
                    DataCell(Text(userName)),
                    // Column for the user eMail address.
                    DataCell(Text(userData['email']?.toString() ?? '')),
                    // Column for the user's roles.
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: List<Widget>.generate(
                            (userData['roles'] as List<dynamic>? ?? []).length,
                            (index) {
                              final role =
                                  (userData['roles'] as List<dynamic>)[index];
                              final subModule =
                                  (userData['subModule'] as List<dynamic>? ??
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
        );
      },
    );
  }
}
