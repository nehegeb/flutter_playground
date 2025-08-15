// pluto_grid_settings_configuration.dart
//

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';

final PlutoGridConfiguration plutoGridSettingsConfiguration =
    PlutoGridConfiguration(
      style: AppTheme.isLightMode
          // Light mode.
          ? PlutoGridStyleConfig(
              // Remove the lines in and around the table.
              borderColor: Colors.transparent,
              gridBorderColor: Colors.transparent,
            )
          // Dark mode.
          : PlutoGridStyleConfig.dark(
              // Remove the lines in and around the table.
              borderColor: Colors.transparent,
              gridBorderColor: Colors.transparent,
            ),
    );
