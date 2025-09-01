// modules_tab.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/app_notifiers/is_mobile_device_notifier/is_mobile_device_notifier.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/get_modules_tab_data.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/modules_edit_dialog_save.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/widgets/modules_edit_dialog.dart';

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
    _modulesTableData = await getModulesTabData();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = isMobileDeviceNotifier.value;

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
            scrollDirection: Axis.vertical,
            child: DataTable(
              dataRowMaxHeight: double.infinity,
              showCheckboxColumn: false,
              columns: [
                // Column header for the [AppMainModule] name.
                DataColumn(
                  label: Text(
                    Localization.getText(
                      'pages.permissions.modulesTab.columnName',
                    ),
                  ),
                ),

                // Column header for the public flag.
                if (!isMobile)
                  DataColumn(
                    label: Text(
                      Localization.getText(
                        'pages.permissions.modulesTab.columnIsPublic',
                      ),
                    ),
                  ),

                // Column for the [AppMainModule]'s administrators.
                DataColumn(
                  label: Text(
                    Localization.getText(
                      'pages.permissions.modulesTab.columnAdmins',
                    ),
                  ),
                ),
              ],
              rows: _modulesTableData!.map<DataRow>((moduleData) {
                String localizedModuleName = moduleData['moduleName'] == 'main'
                    ? Localization.getText('appName')
                    : Localization.getText(
                        'modules.${moduleData['moduleName']}.title',
                      );

                return DataRow(
                  onSelectChanged: (selected) {
                    if (selected == true) {
                      // Open the edit dialog for the clicked-on table entry.
                      AppPopup.widgetDialog(
                        context: context,
                        title: localizedModuleName,
                        widget: ModulesEditDialog(
                          moduleId: moduleData['moduleName'] == 'main'
                              ? 'main' // For the 'main' main module.
                              : moduleData['moduleId'],
                        ),
                        onCancel: () {},
                        onSave: (data) =>
                            modulesEditDialogSave(moduleData: data),
                      );
                    }
                  },
                  cells: [
                    // Column for the [AppMainModule] name.
                    DataCell(Text(localizedModuleName)),

                    // Column for the public flag.
                    if (!isMobile)
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

                    // Column for the [AppMainModule]'s administrators.
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
