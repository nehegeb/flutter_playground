// roles_tab.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/permissions_page_utils.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/get_roles_tab_data.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/roles_edit_dialog_save.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/roles_edit_dialog_delete.dart';
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
    final data = await getRolesTabData();
    setState(() {
      _rolesTableData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    String activeMainModule = PermissionsPageUtils.activeMainModule;

    return FutureBuilder<void>(
      future: _rolesTableData == null ? _loadRolesTableData() : null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_rolesTableData == null) {
          return Stack(
            children: [
              // Centered message for when no data is available.
              Center(
                child: Text(
                  Localization.getText(
                    'pages.permissions.rolesTab.errorNoData',
                  ),
                ),
              ),

              // 'Add' button at bottom right.
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  mini: true,
                  tooltip: Localization.getText('misc.buttons.add'),
                  onPressed: () => AppPopup.widgetDialog(
                    context: context,
                    title: Localization.getText(
                      'pages.permissions.rolesTab.addNew',
                    ),
                    widget: RolesEditDialog(
                      roleId: null,
                      mainModule: activeMainModule,
                    ),
                    onCancel: () {},
                    onSave: (data) async =>
                        await rolesEditDialogSave(roleData: data),
                  ),
                  child: const Icon(Icons.add, size: 20),
                ),
              ),
            ],
          );
        }

        return Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  dataRowMaxHeight: double.infinity,
                  showCheckboxColumn: false,
                  columns: [
                    // Column header for the [AppRole] name.
                    DataColumn(
                      label: Text(
                        Localization.getText(
                          'pages.permissions.rolesTab.columnName',
                        ),
                      ),
                    ),

                    // Column header for the [AppRole]'s permissions.
                    DataColumn(
                      label: Text(
                        Localization.getText(
                          'pages.permissions.rolesTab.columnPermissions',
                        ),
                      ),
                    ),
                  ],
                  rows: _rolesTableData!.map<DataRow>((roleData) {
                    final String roleName =
                        (roleData['subModule'] == null ||
                            roleData['subModule'].toString().isEmpty)
                        ? roleData['name']?.toString() ?? ''
                        : '${roleData['subModule'].toString()} ${roleData['name']?.toString() ?? ''}';
                    final bool isDefaultRole = roleData['isDefaultRole'];

                    return DataRow(
                      onSelectChanged: (selected) {
                        if (selected == true) {
                          if (isDefaultRole) {
                            // For default [AppRole]s, open the view dialog for the clicked-on table entry.
                            AppPopup.widgetDialog(
                              context: context,
                              title: roleName,
                              widget: RolesEditDialog(
                                roleId: roleData['roleId'],
                                mainModule: activeMainModule,
                              ),
                              onConfirm: () {},
                            );
                          } else {
                            // For custom [AppRole]s, open the edit dialog for the clicked-on table entry.
                            AppPopup.widgetDialog(
                              context: context,
                              title: roleName,
                              widget: RolesEditDialog(
                                roleId: roleData['roleId'],
                                mainModule: activeMainModule,
                              ),
                              onCancel: () {},
                              onSave: (data) async {
                                await rolesEditDialogSave(roleData: data);
                                await _loadRolesTableData();
                              },
                              onDelete: (id) async {
                                await rolesEditDialogDelete(roleId: id);
                                await _loadRolesTableData();
                              },
                            );
                          }
                        }
                      },
                      cells: [
                        // Column for the [AppRole] name.
                        DataCell(Text(roleName)),

                        // Column for the [AppRole]'s permissions.
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
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
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),

            // 'Add' button at bottom right.
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                mini: true,
                tooltip: Localization.getText('misc.buttons.add'),
                onPressed: () => AppPopup.widgetDialog(
                  context: context,
                  title: Localization.getText(
                    'pages.permissions.rolesTab.addNew',
                  ),
                  widget: RolesEditDialog(
                    roleId: null,
                    mainModule: activeMainModule,
                  ),
                  onCancel: () {},
                  onSave: (data) async =>
                      await rolesEditDialogSave(roleData: data),
                ),
                child: const Icon(Icons.add, size: 20),
              ),
            ),
          ],
        );
      },
    );
  }
}
