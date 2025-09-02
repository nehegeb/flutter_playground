// modules_edit_dialog.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_helper/widgets/dropdown_list.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/modules_edit_dialog_init.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/modules_edit_dialog_add_admin.dart';
import 'package:flutter_playground/modules/settings/pages/permissions/logic/modules_edit_dialog_delete_admin.dart';

List<AppUser>? availableAppUsersForAdmin;

class ModulesEditDialog extends StatefulWidget {
  final String moduleId;

  const ModulesEditDialog({super.key, required this.moduleId});

  @override
  State<ModulesEditDialog> createState() => _ModulesEditDialogState();
}

class _ModulesEditDialogState extends State<ModulesEditDialog> {
  bool isAddAdminShown = false;
  AppUser? selectedAdmin;

  @override
  void initState() {
    super.initState();
    // Initialize the data for the [ModulesEditDialog].
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await modulesEditDialogInit(moduleId: widget.moduleId);
    });
  }

  @override
  Widget build(BuildContext context) {
    double textSpacer = 12;
    double lineSpacer = 8;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<Map<String, dynamic>?>(
          valueListenable: popupDialogDataNotifier,
          builder: (context, data, _) {
            final appMainModule = data?['appMainModule'] as AppMainModule?;
            final adminAppUsers =
                data?['adminAppUsers'] as List<AppUser>? ?? [];

            if (data == null || appMainModule == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Whether the module is public.
                Row(
                  children: [
                    Text(
                      Localization.getText(
                        'pages.permissions.modulesTab.editIsPublic',
                      ),
                    ),
                    Text(':'),
                    SizedBox(width: textSpacer),
                    Switch(
                      value: appMainModule.isPublic,
                      onChanged: null, // This deactivates the switch.
                    ),
                  ],
                ),
                SizedBox(height: lineSpacer),

                // The list of module administrators.
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
                        // Column header for module administrators.
                        DataColumn(
                          label: Text(
                            Localization.getText(
                              'pages.permissions.modulesTab.columnAdmins',
                            ),
                          ),
                        ),

                        // Column header for module actions.
                        DataColumn(
                          label: Align(
                            alignment: Alignment.centerRight,
                            child: !isAddAdminShown
                                ? IconButton(
                                    icon: const Icon(Icons.add),
                                    tooltip: Localization.getText(
                                      'misc.buttons.add',
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isAddAdminShown = true;
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
                                        isAddAdminShown = false;
                                        selectedAdmin = null;
                                      });
                                    },
                                  ),
                          ),
                          numeric: true,
                        ),
                      ],
                      rows: [
                        // A row for a new entry to the list.
                        if (isAddAdminShown)
                          DataRow(
                            color: WidgetStateProperty.resolveWith<Color?>((
                              Set<WidgetState> states,
                            ) {
                              return Theme.of(context).colorScheme.surface;
                            }),
                            cells: [
                              // Column for module administrators.
                              DataCell(
                                DropdownList<AppUser>(
                                  items: (availableAppUsersForAdmin ?? [])
                                      // Only include the [AppUser]s that are not already admin.
                                      .where(
                                        (availableUser) => !(adminAppUsers.any(
                                          (adminUser) =>
                                              adminUser.id == availableUser.id,
                                        )),
                                      )
                                      .toList(),
                                  filterEnabled: true,
                                  itemLabel: (appUser) => appUser.name,
                                  onChanged: (selectedAppUser) {
                                    setState(() {
                                      selectedAdmin = selectedAppUser;
                                    });
                                  },
                                ),
                              ),

                              // Column for module actions.
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
                                        onPressed: selectedAdmin == null
                                            ? null
                                            : () {
                                                modulesEditDialogAddAdmin(
                                                  appUser: selectedAdmin,
                                                );
                                                setState(() {
                                                  isAddAdminShown = false;
                                                  selectedAdmin = null;
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
                        if (adminAppUsers.isNotEmpty)
                          ...adminAppUsers.map((user) {
                            return DataRow(
                              cells: [
                                // column for module administrators.
                                DataCell(Text(user.name)),

                                // Column for module actions.
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
                                              modulesEditDialogDeleteAdmin(
                                                userId: user.id,
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
