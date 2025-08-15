// users_settings_tab.dart
//

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/pages/settings/widgets/pluto_grid_settings_configuration.dart';

/// The users settings tab of the app settings.
class UsersSettingsTab extends StatefulWidget {
  const UsersSettingsTab({super.key});

  @override
  State<UsersSettingsTab> createState() => _UsersSettingsTabState();
}

class _UsersSettingsTabState extends State<UsersSettingsTab> {
  late final List<PlutoColumn> columns;
  late final List<PlutoRow> rows;
  PlutoGridStateManager? stateManager;

  @override
  void initState() {
    super.initState();
    columns = [
      PlutoColumn(title: 'Name', field: 'name', type: PlutoColumnType.text()),
      PlutoColumn(title: 'Age', field: 'age', type: PlutoColumnType.number()),
    ];

    rows = [
      PlutoRow(
        cells: {
          'name': PlutoCell(value: 'Alice'),
          'age': PlutoCell(value: 30),
        },
      ),
      PlutoRow(
        cells: {
          'name': PlutoCell(value: 'Bob'),
          'age': PlutoCell(value: 25),
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PlutoGrid(
        columns: columns,
        rows: rows,
        onLoaded: (event) {
          stateManager = event.stateManager;
        },
        onChanged: (event) {},
        configuration: plutoGridSettingsConfiguration,
      ),
    );
  }
}
