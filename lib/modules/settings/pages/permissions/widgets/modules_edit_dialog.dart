// modules_edit_dialog.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';

class ModulesEditDialog extends StatelessWidget {
  final String moduleId;

  const ModulesEditDialog({super.key, required this.moduleId});

  @override
  Widget build(BuildContext context) {
    // Load the initial data for the [ModulesEditDialog].
    initData() {
      popupDialogDataNotifier.value = {'id': moduleId};
    }

    initData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Whether the module is public.
        Row(
          children: [
            Text('Module is public:'),
            SizedBox(width: 24),
            Switch(value: true, onChanged: null),
          ],
        ),
        SizedBox(height: 8),

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
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      tooltip: Localization.getText('misc.buttons.add'),
                      onPressed: () {},
                    ),
                  ),
                  numeric: true,
                ),
              ],
              rows: [
                DataRow(
                  cells: [
                    // Column for module administrators.
                    const DataCell(Text('Frodo Baggins')),
                    // Column for module actions.
                    DataCell(
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            // Delete button.
                            IconButton(
                              icon: const Icon(Icons.delete),
                              tooltip: Localization.getText(
                                'misc.buttons.delete',
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                DataRow(
                  cells: [
                    // Column for module administrators.
                    const DataCell(Text('Gandalf the White')),
                    // Column for module actions.
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            tooltip: Localization.getText(
                              'misc.buttons.delete',
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
