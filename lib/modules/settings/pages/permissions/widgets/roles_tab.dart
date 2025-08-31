// roles_tab.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/get_roles_tab_data.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/save_role.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/delete_role.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/widgets/roles_edit_dialog.dart';

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
    _rolesTableData = await getRolesTabData();
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
            scrollDirection: Axis.vertical,
            child: DataTable(
              dataRowMaxHeight: double.infinity,
              showCheckboxColumn: false,
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
                String roleName =
                    (roleData['subModule'] == null ||
                        roleData['subModule'].toString().isEmpty)
                    ? roleData['name']?.toString() ?? ''
                    : '${roleData['subModule'].toString()} ${roleData['name']?.toString() ?? ''}';

                return DataRow(
                  onSelectChanged: (selected) {
                    if (selected == true) {
                      // Open the edit dialog for the clicked-on table entry.
                      AppPopup.widgetDialog(
                        context: context,
                        title: roleName,
                        widget: RolesEditDialog(roleId: roleData['roleId']),
                        onCancel: () {},
                        onSave: (data) => saveRole(),
                        onDelete: (id) => deleteRole(roleId: id),
                      );
                    }
                  },
                  cells: [
                    // Column for the role name.
                    DataCell(Text(roleName)),
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
