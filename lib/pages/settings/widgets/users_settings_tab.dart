// users_settings_tab.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/pages/settings/settings_utils.dart';

/// The users settings tab of the app settings.
class UsersSettingsTab extends StatefulWidget {
  const UsersSettingsTab({super.key});

  @override
  State<UsersSettingsTab> createState() => _UsersSettingsTabState();
}

class _UsersSettingsTabState extends State<UsersSettingsTab> {
  List<Map<String, dynamic>>? _usersTableData;

  // Load the data for the users settings tab.
  Future<void> _loadUsersTableData() async {
    _usersTableData = await SettingsUtils.usersTabData;
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
              Localization.getText('pages.settings.usersTab.errorNoData'),
            ),
          );
        }
        return SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: DataTable(
              dataRowMaxHeight: double.infinity,
              columns: [
                DataColumn(
                  label: Text(
                    Localization.getText('pages.settings.usersTab.columnName'),
                  ),
                ),
                DataColumn(
                  label: Text(
                    Localization.getText('pages.settings.usersTab.columnEmail'),
                  ),
                ),
                DataColumn(
                  label: Text(
                    Localization.getText('pages.settings.usersTab.columnRoles'),
                  ),
                ),
              ],
              rows: _usersTableData!.map<DataRow>((userData) {
                return DataRow(
                  cells: [
                    // Column for the user name.
                    DataCell(Text(userData['name']?.toString() ?? '')),
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
