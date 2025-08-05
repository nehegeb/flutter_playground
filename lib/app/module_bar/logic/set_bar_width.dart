// set_bar_width.dart
//

import 'package:flutter_playground/app/local_cache/local_cache.dart';
import 'package:flutter_playground/app/module_bar/module_bar_utils.dart';

/// Sets the width of the [ModuleBar] and saves it to local cache.
/// The width can be 'wide', 'narrow', or 'toggle'.
void setBarWidth({required String width}) {
  // Check if the given width is valid.
  const allowedModes = ['wide', 'narrow', 'toggle'];
  if (!allowedModes.contains(width)) {
    throw ArgumentError(
      "Invalid width: $width. Allowed values are 'wide', 'narrow', or 'toggle'.",
    );
  }

  // Set the [ModuleBar] width and save it to local cache.
  switch (width) {
    case 'wide':
      // If the given width is 'wide', set the [ModuleBar] to wide.

      // Set the [moduleBarNotifier] to wide.
      moduleBarNotifier.value = [
        {...moduleBarNotifier.value.first, 'isBarWide': true},
      ];

      // Save the width setting to local cache.
      LocalCache.save(setting: 'ModuleBarIsWide', value: true);

      break;
    case 'narrow':
      // If the given width is 'narrow', set the [ModuleBar] to narrow.

      // Set the [moduleBarNotifier] to narrow.
      moduleBarNotifier.value = [
        {...moduleBarNotifier.value.first, 'isBarWide': false},
      ];

      // Save the narrow setting to local cache.
      LocalCache.save(setting: 'ModuleBarIsWide', value: false);

      break;
    case 'toggle':
      // If the given width is 'toggle', switch between narrow and wide.

      // Set the [ModuleBar] to the opposite width.
      setBarWidth(width: ModuleBarUtils.isWide ? 'narrow' : 'wide');

      break;
  }
}
