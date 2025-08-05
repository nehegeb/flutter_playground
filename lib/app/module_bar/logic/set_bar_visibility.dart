// set_bar_visibility.dart
//

import 'package:flutter_playground/app/module_bar/module_bar_utils.dart';

/// Sets the visibility of the [ModuleBar].
/// The visibility can be 'hidden', 'shown', or 'toggle'.
void setBarVisibility({required String visibility}) {
  // Check if the given visibility is valid.
  const allowedModes = ['hidden', 'shown', 'toggle'];
  if (!allowedModes.contains(visibility)) {
    throw ArgumentError(
      "Invalid visibility: $visibility. Allowed values are 'hidden', 'shown', or 'toggle'.",
    );
  }

  // Set the [ModuleBar] visibility.
  switch (visibility) {
    case 'hidden':
      // If the given visibility is 'hidden', set the [ModuleBar] to hidden.

      // Set the [moduleBarNotifier] to hidden.
      moduleBarNotifier.value = [
        {...moduleBarNotifier.value.first, 'isBarHidden': true},
      ];

      break;
    case 'shown':
      // If the given visibility is 'shown', set the [ModuleBar] to shown.

      // Set the [moduleBarNotifier] to shown.
      moduleBarNotifier.value = [
        {...moduleBarNotifier.value.first, 'isBarHidden': false},
      ];

      break;
    case 'toggle':
      // If the given visibility is 'toggle', switch between hidden and shown.

      // Set the [ModuleBar] to the opposite visibility.
      setBarVisibility(
        visibility: ModuleBarUtils.isVisible ? 'hidden' : 'shown',
      );

      break;
  }
}
