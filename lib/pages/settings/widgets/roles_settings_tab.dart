// roles_settings_tab.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/pages/settings/settings_utils.dart';

/// The user settings tab of the app settings.
class RolesSettingsTab extends StatefulWidget {
  const RolesSettingsTab({super.key});

  @override
  State<RolesSettingsTab> createState() => _RolesSettingsTabState();
}

class _RolesSettingsTabState extends State<RolesSettingsTab> {
  List<Map<String, dynamic>>? _rolesTableData;

  Future<void> _loadRolesTableData() async {
    // Load the roles data.
    final appRoles = SettingsUtils.appRolesForActiveMainModule;

    // TODO: Implement subModule.

    // Prepare the data for the table.
    final List<Map<String, dynamic>> rolesTableData = [];
    for (final role in appRoles ?? []) {
      rolesTableData.add({
        'name': role.idTitle,
        'subModule': '',
        'permissions': role.permissions,
      });
    }
    _rolesTableData = rolesTableData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _rolesTableData == null ? _loadRolesTableData() : null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_rolesTableData == null) {
          return Center(
            child: Text(
              Localization.getText('pages.settings.rolesTab.errorNoData'),
            ),
          );
        }
        return SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    Localization.getText('pages.settings.rolesTab.columnName'),
                  ),
                ),
                DataColumn(
                  label: Text(
                    Localization.getText(
                      'pages.settings.rolesTab.columnSubModule',
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    Localization.getText(
                      'pages.settings.rolesTab.columnPermissions',
                    ),
                  ),
                ),
              ],
              rows: _rolesTableData!.map<DataRow>((roleData) {
                return DataRow(
                  cells: [
                    // Column for the role name.
                    DataCell(Text(roleData['name']?.toString() ?? '')),
                    // Column for the role name.
                    DataCell(Text(roleData['subModule']?.toString() ?? '')),
                    // Column for the permissions.
                    // TODO: Make the height of the rows as high as needed.
                    DataCell(
                      SizedBox(
                        height: 60, // TODO: Make this dynamic based on content.
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children:
                                (roleData['permissions'] as List<dynamic>? ??
                                        [])
                                    .map<Widget>(
                                      (perm) => Text(perm.toString()),
                                    )
                                    .toList(),
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
