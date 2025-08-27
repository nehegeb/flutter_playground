// roles_tab.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/pages/permissions/permissions_utils.dart';

/// The roles tab of the app permissions.
class RolesTab extends StatefulWidget {
  const RolesTab({super.key});

  @override
  State<RolesTab> createState() => _RolesTabState();
}

class _RolesTabState extends State<RolesTab> {
  List<Map<String, dynamic>>? _rolesTableData;

  // Load the data for the roles tab.
  Future<void> _loadRolesTableData() async {
    _rolesTableData = await PermissionsUtils.rolesTabData;
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
              Localization.getText('pages.permissions.rolesTab.errorNoData'),
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
                    Localization.getText(
                      'pages.permissions.rolesTab.columnName',
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    Localization.getText(
                      'pages.permissions.rolesTab.columnPermissions',
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
