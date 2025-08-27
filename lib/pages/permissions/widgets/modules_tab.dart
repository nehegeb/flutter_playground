// modules_tab.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/pages/permissions/permissions_utils.dart';

/// The modules tab of the permissions.
class ModulesTab extends StatefulWidget {
  const ModulesTab({super.key});

  @override
  State<ModulesTab> createState() => _ModulesTabState();
}

class _ModulesTabState extends State<ModulesTab> {
  List<Map<String, dynamic>>? _modulesTableData;

  // Load the data for the modules tab.
  Future<void> _loadModulesTableData() async {
    _modulesTableData = await PermissionsUtils.modulesTabData;
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
              Localization.getText('pages.permissions.modulesTab.errorNoData'),
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
                      'pages.permissions.modulesTab.columnName',
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    Localization.getText(
                      'pages.permissions.modulesTab.columnIsPublic',
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    Localization.getText(
                      'pages.permissions.modulesTab.columnAdmins',
                    ),
                  ),
                ),
              ],
              rows: _modulesTableData!.map<DataRow>((moduleData) {
                return DataRow(
                  cells: [
                    // Column for the main module name.
                    DataCell(
                      Text(
                        moduleData['moduleName'] == 'main'
                            ? Localization.getText('appName')
                            : Localization.getText(
                                'modules.${moduleData['moduleName']}.title',
                              ),
                      ),
                    ),
                    // Column for the public flag.
                    DataCell(
                      Icon(
                        moduleData['moduleIsPublic'] == true
                            ? Icons.check
                            : Icons.close,
                        color: moduleData['moduleIsPublic'] == true
                            ? Colors.green
                            : Colors.red,
                        size: 20,
                      ),
                    ),
                    // Column for the main module's administrators.
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children:
                              (((moduleData['users'] as Map<String, dynamic>?)
                                          ?.values
                                          .toList() ??
                                      [])
                                  .map<Widget>(
                                    (user) => Text(
                                      user['userName']?.toString() ?? '',
                                    ),
                                  )
                                  .toList()),
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
