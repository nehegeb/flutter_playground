// users_settings_tab.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/pages/settings/settings_utils.dart';

/// The users settings tab of the app settings.
class UsersSettingsTab extends StatefulWidget {
  const UsersSettingsTab({super.key});

  @override
  State<UsersSettingsTab> createState() => _UsersSettingsTabState();
}

class _UsersSettingsTabState extends State<UsersSettingsTab> {
  List<Map<String, dynamic>>? _usersTableData;

  Future<void> _loadUsersTableData() async {
    // Load the users data.
    await User.initDbUsersData();
    final appUsers = await SettingsUtils.appUsersForActiveMainModule;

    // TODO: Implement subModule as prefix of the role.

    // Prepare the data for the table.
    final List<Map<String, dynamic>> usersTableData = [];
    for (final user in appUsers ?? []) {
      usersTableData.add({
        'name': user.name,
        'email': user.email,
        'roles': (user.roles ?? [])
            .map((role) => role?.idTitle)
            .where(
              (idTitle) => idTitle != null && idTitle.toString().isNotEmpty,
            )
            .map((idTitle) => idTitle.toString())
            .toList(),
        'mainModule': (user.roles ?? []).map((role) {
          if (role == null ||
              role.mainModuleIdTitle == null ||
              role.mainModuleIdTitle.toString().isEmpty) {
            return '';
          }
          return role.mainModuleIdTitle.toString();
        }).toList(),
        'subModule': (user.roles ?? []).map((role) {
          if (role == null ||
              role.subModuleIdTitle == null ||
              role.subModuleIdTitle.toString().isEmpty) {
            return '';
          }
          return role.subModuleIdTitle.toString();
        }).toList(),
      });
    }
    _usersTableData = usersTableData;
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
            scrollDirection: Axis.horizontal,
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
