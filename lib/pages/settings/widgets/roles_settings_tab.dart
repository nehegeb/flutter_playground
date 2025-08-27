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

  // Load the data for the roles settings tab.
  Future<void> _loadRolesTableData() async {
    _rolesTableData = await SettingsUtils.rolesTabData;
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
            child: DataTable(
              dataRowMaxHeight: double.infinity,
              columns: [
                DataColumn(
                  label: Text(
                    Localization.getText('pages.settings.rolesTab.columnName'),
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
                    DataCell(
                      Text(
                        (roleData['subModule'] == null ||
                                roleData['subModule'].toString().isEmpty)
                            ? roleData['name']?.toString() ?? ''
                            : '${roleData['subModule'].toString()} ${roleData['name']?.toString() ?? ''}',
                      ),
                    ),
                    // Column for the permissions.
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children:
                              (roleData['permissions'] as List<dynamic>? ?? [])
                                  .map<Widget>((perm) => Text(perm.toString()))
                                  .toList(),
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
