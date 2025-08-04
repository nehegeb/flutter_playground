// set_bar_width.dart
//

import 'package:flutter_playground/app/local_cache/local_cache.dart';
import 'package:flutter_playground/app/main_module_bar/main_module_bar.dart';
import 'package:flutter_playground/app/main_module_bar/main_module_bar_utils.dart';

/// Sets the width of the [MainModuleBar] and saves it to local cache.
/// The width can be 'wide', 'narrow', or 'toggle'.
void setBarWidth({required String width}) {
  // Check if the given width is valid.
  const allowedModes = ['wide', 'narrow', 'toggle'];
  if (!allowedModes.contains(width)) {
    throw ArgumentError(
      "Invalid width: $width. Allowed values are 'wide', 'narrow', or 'toggle'.",
    );
  }

  // Set the [MainModuleBar] width and save it to local cache.
  switch (width) {
    case 'wide':
      // If the given width is 'wide', set the [MainModuleBar] to wide.

      // Set the [currentModuleBarNotifier] to wide.
      currentModuleBarNotifier.value = [
        {...currentModuleBarNotifier.value.first, 'isBarWide': true},
      ];

      // Save the width setting to local cache.
      LocalCache.save(setting: 'ModuleBarIsWide', value: true);

      break;
    case 'narrow':
      // If the given width is 'narrow', set the [MainModuleBar] to narrow.

      // Set the [currentModuleBarNotifier] to narrow.
      currentModuleBarNotifier.value = [
        {...currentModuleBarNotifier.value.first, 'isBarWide': false},
      ];

      // Save the narrow setting to local cache.
      LocalCache.save(setting: 'ModuleBarIsWide', value: false);

      break;
    case 'toggle':
      // If the given width is 'toggle', switch between narrow and wide.

      // Set the [MainModuleBar] to the opposite width.
      setBarWidth(width: MainModuleBarUtils.isWide ? 'narrow' : 'wide');

      break;
  }
}
