// roles_edit_dialog.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_helper/widgets/dropdown_list.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/roles_edit_dialog_init.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/roles_edit_dialog_add_permission.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/roles_edit_dialog_delete_permission.dart';

List<String>? availablePermissionsForAppRole;

class RolesEditDialog extends StatefulWidget {
  final String? roleId;
  final String mainModule;

  const RolesEditDialog({super.key, this.roleId, required this.mainModule});

  @override
  State<RolesEditDialog> createState() => _RolesEditDialogState();
}

class _RolesEditDialogState extends State<RolesEditDialog> {
  bool isAddPermissionShown = false;
  String? selectedPermission;

  @override
  void initState() {
    super.initState();
    // Initialize the data for the [RolesEditDialog].
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await rolesEditDialogInit(
        roleId: widget.roleId,
        mainModule: widget.mainModule,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isNewRole = widget.roleId == null;
    double textSpacer = 12;
    double lineSpacer = 8;

    if (isNewRole) {
      return Text('UNDER DEVELOPMENT');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<Map<String, dynamic>?>(
          valueListenable: popupDialogDataNotifier,
          builder: (context, data, _) {
            final appRole = data?['appRole'] as AppRole?;
            final rolePermissions = appRole?.permissions ?? [];
            final bool isSubModuleRole =
                appRole?.subModuleIdTitle != null &&
                appRole?.subModuleIdTitle != '';

            if (data == null || appRole == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The name of the [AppMainModule] of this [AppRole].
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          Localization.getText(
                            'pages.permissions.rolesTab.editMainModule',
                          ),
                        ),
                        Text(':'),
                        SizedBox(width: textSpacer),
                        Text(
                          appRole.mainModuleIdTitle == ''
                              ? ''
                              : appRole.mainModuleIdTitle == 'main' ||
                                    appRole.mainModuleIdTitle == 'settings'
                              ? Localization.getText('appName')
                              : Localization.getText(
                                  'modules.${appRole.mainModuleIdTitle}.title',
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: lineSpacer),

                // The name of the [AppSubModule] of this [AppRole], if any.
                if (isSubModuleRole)
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            Localization.getText(
                              'pages.permissions.rolesTab.editSubModule',
                            ),
                          ),
                          Text(':'),
                          SizedBox(width: textSpacer),
                          Text(
                            appRole.subModuleIdTitle == ''
                                ? ''
                                : Localization.getText(
                                    'modules.${appRole.mainModuleIdTitle}.modules.${appRole.subModuleIdTitle}.title',
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                if (isSubModuleRole) SizedBox(height: lineSpacer),

                // The list of role permissions.
                ConstrainedBox(
                  // This height constraint is needed to make list scrollable.
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      showCheckboxColumn: false,
                      columns: [
                        // Column header for role permissions.
                        DataColumn(
                          label: Text(
                            Localization.getText(
                              'pages.permissions.rolesTab.columnPermissions',
                            ),
                          ),
                        ),

                        // Column header for permission actions for custom [AppRole]s.
                        if (!appRole.isDefaultRole)
                          DataColumn(
                            label: Align(
                              alignment: Alignment.centerRight,
                              child: !isAddPermissionShown
                                  ? IconButton(
                                      icon: const Icon(Icons.add),
                                      tooltip: Localization.getText(
                                        'misc.buttons.add',
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isAddPermissionShown = true;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.close),
                                      tooltip: Localization.getText(
                                        'misc.buttons.cancel',
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isAddPermissionShown = false;
                                          selectedPermission = null;
                                        });
                                      },
                                    ),
                            ),
                            numeric: true,
                          ),
                      ],
                      rows: [
                        // A row for a new entry to the list.
                        if (isAddPermissionShown)
                          DataRow(
                            color: WidgetStateProperty.resolveWith<Color?>((
                              Set<WidgetState> states,
                            ) {
                              return Theme.of(context).colorScheme.surface;
                            }),
                            cells: [
                              // Column for module roles.
                              DataCell(
                                DropdownList<String>(
                                  items: (availablePermissionsForAppRole ?? [])
                                      // Only include the permissions that are not already in the [AppRole].
                                      .where(
                                        (availablePerm) =>
                                            !(rolePermissions.any(
                                              (rolePerm) =>
                                                  rolePerm == availablePerm,
                                            )),
                                      )
                                      .toList(),
                                  filterEnabled: true,
                                  itemLabel: (permission) => permission,
                                  onChanged: (selectedPerm) {
                                    setState(() {
                                      selectedPermission = selectedPerm;
                                    });
                                  },
                                ),
                              ),

                              // Column for role actions for custom [AppRole]s.
                              DataCell(
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.check),
                                        tooltip: Localization.getText(
                                          'misc.buttons.add',
                                        ),
                                        onPressed: selectedPermission == null
                                            ? null
                                            : () {
                                                rolesEditDialogAddPermission(
                                                  permission:
                                                      selectedPermission,
                                                );
                                                setState(() {
                                                  isAddPermissionShown = false;
                                                  selectedPermission = null;
                                                });
                                              },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                        // All the list entries.
                        if (rolePermissions.isNotEmpty)
                          ...rolePermissions.map((perm) {
                            return DataRow(
                              cells: [
                                // Column for module roles.
                                DataCell(Text(perm)),

                                // Column for role actions for custom [AppRole]s.
                                if (!appRole.isDefaultRole)
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            tooltip: Localization.getText(
                                              'misc.buttons.delete',
                                            ),
                                            onPressed: () =>
                                                rolesEditDialogDeletePermission(
                                                  permission: perm,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          }),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
