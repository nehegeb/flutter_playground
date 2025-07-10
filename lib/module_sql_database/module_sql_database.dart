/// module_sql_database.dart
///
library module_sql_database;

import 'package:flutter/material.dart';
import 'package:flutter_playground/localization/localization.dart';

/// The SQL database module.
class SqlDatabaseModule extends StatelessWidget {
  const SqlDatabaseModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(Localization.getText('sqlDatabaseModule.title'))],
    );
  }
}
