// modules_settings_tab.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/pages/settings/settings_utils.dart';

/// The user settings tab of the app settings.
class ModulesSettingsTab extends StatefulWidget {
  const ModulesSettingsTab({super.key});

  @override
  State<ModulesSettingsTab> createState() => _ModulesSettingsTabState();
}

class _ModulesSettingsTabState extends State<ModulesSettingsTab> {
  List<Map<String, dynamic>>? _modulesTableData;

  Future<void> _loadModulesTableData() async {
    // Get the [AppRole]s for the currently active main module.
    final appRoles = SettingsUtils.appRolesForActiveMainModule;

    // Prepare the data for the table.
    final List<Map<String, dynamic>> rolesTableData = [];
    for (final role in appRoles ?? []) {
      rolesTableData.add({
        'name': role.idTitle,
        'permissions': role.permissions,
        'mainModule': role.mainModuleIdTitle,
        'subModule': role.subModuleIdTitle,
      });
    }
    _modulesTableData = rolesTableData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _modulesTableData == null ? _loadModulesTableData() : null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_modulesTableData == null) {
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
              dataRowMaxHeight: double.infinity,
              columns: [
                DataColumn(
                  label: Text(
                    Localization.getText(
                      'pages.settings.modulesTab.columnName',
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    Localization.getText(
                      'pages.settings.modulesTab.columnAdmins',
                    ),
                  ),
                ),
              ],
              rows: _modulesTableData!.map<DataRow>((moduleData) {
                return DataRow(
                  cells: [
                    // Column for the role name.
                    DataCell(
                      Text(
                        (moduleData['subModule'] == null ||
                                moduleData['subModule'].toString().isEmpty)
                            ? moduleData['name']?.toString() ?? ''
                            : '${moduleData['subModule'].toString()} ${moduleData['name']?.toString() ?? ''}',
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
                              (moduleData['permissions'] as List<dynamic>? ??
                                      [])
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
