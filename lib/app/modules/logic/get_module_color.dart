// get_module_color.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/modules/modules.dart';

/// Returns a valid color of a module.
/// Only one [AppMainModule] OR [AppSubModule] can be given.
/// If no valid color could been found or none or both arguments are given, it returns null.
Color? getModuleColor({
  AppMainModule? appMainModule,
  AppSubModule? appSubModule,
  int shade = 500, // 500 is the default shade.
}) {
  // Make sure, only one of the arguments is given.
  if (appMainModule == null && appSubModule == null ||
      appMainModule != null && appSubModule != null) {
    return null;
  }

  String colorName = '';

  // Get the color of the [AppMainModule].
  if (appMainModule != null) {
    colorName = appMainModule.color?.toLowerCase() ?? '';
  }

  // Get the color of the [AppSubModule].
  if (appSubModule != null) {
    colorName = appSubModule.color?.toLowerCase() ?? '';
  }

  // Return a color for the module.
  switch (colorName) {
    case 'red':
      return Colors.red[shade];
    case 'blue':
      return Colors.blue[shade];
    case 'green':
      return Colors.green[shade];
    case 'yellow':
      return Colors.yellow[shade];
    case 'orange':
      return Colors.orange[shade];
    case 'purple':
      return Colors.purple[shade];
    case 'pink':
      return Colors.pink[shade];
    case 'brown':
      return Colors.brown[shade];
    case 'grey':
    case 'gray':
      return Colors.grey[shade];
    case 'black':
      return Colors.black; // Black does not support shades.
    case 'white':
      return Colors.white; // White does not support shades.
    default:
      return null;
  }
}
