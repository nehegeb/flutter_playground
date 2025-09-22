// roles_edit_dialog.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_helper/app_helper.dart';
import 'package:flutter_playground/app/app_helper/widgets/dropdown_list.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/roles/roles.dart';
import 'package:flutter_playground/app/roles/logic/update_roles_data.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/permissions_page_utils.dart';
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
  final TextEditingController _newRoleName = TextEditingController();
  final TextEditingController _newRoleSubModule = TextEditingController();
  String? selectedPermission;
  bool isAddPermissionShown = false;
  bool isAddRoleActive = false;
  bool isNewRole = false;

  @override
  void initState() {
    super.initState();
    isNewRole = widget.roleId == null;

    // Load the roles data for the [RolesEditDialog].
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await rolesEditDialogInit(
        roleId: widget.roleId,
        mainModule: widget.mainModule,
      );
    });
  }

  @override
  void dispose() {
    _newRoleName.dispose();
    _newRoleSubModule.dispose();
    super.dispose();
  }

  // Add a new [AppRole] for the given [mainModule].
  Future<void> addNewRole() async {
    // Generate an UUID for the new role.
    String newRoleId = AppHelper.uuid;

    // Add the new role to the roles data.
    await updateRolesData(
      id: newRoleId,
      idTitle: _newRoleName.text,
      mainModuleIdTitle: widget.mainModule,
      subModuleIdTitle: _newRoleSubModule.text,
      permissions: [],
      isNewRole: true,
    );

    // Load the updated roles data.
    await Roles.initDbRolesData();

    // Reload the roles data to include the new role.
    await rolesEditDialogInit(roleId: newRoleId, mainModule: widget.mainModule);

    // Switch from add new role form to edit role dialog.
    setState(() {
      isNewRole = false;
    });

    // Activate the save button until the required fields are filled.
    AppPopup.activateConfirmationButton();
  }

  // Get all sub modules of the given [mainModule] for adding a new role.
  Future<List<dynamic>?> getSubModules() async {
    return await PermissionsPageUtils.getSubModulesForMainModule(
      mainModule: widget.mainModule,
    );
  }

  @override
  Widget build(BuildContext context) {
    double textSpacer = 12;
    double lineSpacer = 8;

    // Display the add new role form.
    if (isNewRole) {
      // Deactivate the save button until the required fields are filled.
      AppPopup.deactivateConfirmationButton();

      return Column(
        children: [
          Row(
            children: [
              // An input box for the role name.
              Text(
                Localization.getText(
                  'modules.main.pages.permissions.rolesTab.columnName',
                ),
              ),
              Text(':'),
              SizedBox(width: textSpacer),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _newRoleName,
                  onChanged: (role) {
                    // If any role is selected, activate the add button, otherwise deactivate it.
                    if (role != '') {
                      setState(() {
                        isAddRoleActive = true;
                      });
                    } else {
                      setState(() {
                        isAddRoleActive = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: lineSpacer),

          // The main module for the new role.
          Row(
            children: [
              Text(
                Localization.getText(
                  'modules.main.pages.permissions.rolesTab.editMainModule',
                ),
              ),
              Text(':'),
              SizedBox(width: textSpacer),
              Text(widget.mainModule),
            ],
          ),
          SizedBox(height: lineSpacer),

          // A [DropdownList] for selecting a sub module for the new role.
          Row(
            children: [
              Text(
                Localization.getText(
                  'modules.main.pages.permissions.rolesTab.editSubModule',
                ),
              ),
              Text(':'),
              SizedBox(width: textSpacer),
              SizedBox(
                width: 200,
                child: FutureBuilder<List<dynamic>?>(
                  future: getSubModules(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox(
                        height: 40,
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    }
                    final subModules = snapshot.data ?? [];
                    return DropdownList<dynamic>(
                      items: subModules,
                      itemLabel: (subModule) => subModule.toString(),
                      onChanged: (selectedSubModule) {
                        _newRoleSubModule.text =
                            selectedSubModule?.toString() ?? '';
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: lineSpacer),

          // The add button.
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: isAddRoleActive
                  ? () async => await addNewRole()
                  : null,
              child: Text(Localization.getText('misc.buttons.add')),
            ),
          ),
        ],
      );
    }

    // Display the edit role dialog.
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
                            'modules.main.pages.permissions.rolesTab.editMainModule',
                          ),
                        ),
                        Text(':'),
                        SizedBox(width: textSpacer),
                        Text(
                          appRole.mainModuleIdTitle == ''
                              ? ''
                              : appRole.mainModuleIdTitle == 'main' ||
                                    appRole.mainModuleIdTitle == 'settings'
                              ? Localization.getText('modules.main.title')
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
                              'modules.main.pages.permissions.rolesTab.editSubModule',
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
                              'modules.main.pages.permissions.rolesTab.columnPermissions',
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
