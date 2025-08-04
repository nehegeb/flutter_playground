// set_bar_visibility.dart
//

import 'package:flutter_playground/app/main_module_bar/main_module_bar.dart';
import 'package:flutter_playground/app/main_module_bar/main_module_bar_utils.dart';

/// Sets the visibility of the [MainModuleBar].
/// The visibility can be 'hidden', 'shown', or 'toggle'.
void setBarVisibility({required String visibility}) {
  // Check if the given visibility is valid.
  const allowedModes = ['hidden', 'shown', 'toggle'];
  if (!allowedModes.contains(visibility)) {
    throw ArgumentError(
      "Invalid visibility: $visibility. Allowed values are 'hidden', 'shown', or 'toggle'.",
    );
  }

  // Set the [MainModuleBar] visibility.
  switch (visibility) {
    case 'hidden':
      // If the given visibility is 'hidden', set the [MainModuleBar] to hidden.

      // Set the [currentModuleBarNotifier] to hidden.
      currentModuleBarNotifier.value = [
        {...currentModuleBarNotifier.value.first, 'isBarHidden': true},
      ];

      break;
    case 'shown':
      // If the given visibility is 'shown', set the [MainModuleBar] to shown.

      // Set the [currentModuleBarNotifier] to shown.
      currentModuleBarNotifier.value = [
        {...currentModuleBarNotifier.value.first, 'isBarHidden': false},
      ];

      break;
    case 'toggle':
      // If the given visibility is 'toggle', switch between hidden and shown.

      // Set the [MainModuleBar] to the opposite visibility.
      setBarVisibility(
        visibility: MainModuleBarUtils.isVisible ? 'hidden' : 'shown',
      );

      break;
  }
}
