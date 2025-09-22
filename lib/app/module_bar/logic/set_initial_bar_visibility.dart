// set_initial_bar_visibility.dart
//

import 'package:flutter_playground/app/module_bar/module_bar_utils.dart';

/// Initializes the [ModuleBar] visibility setting.
/// Sets the visibility according to [moduleBarNotifier].
/// If the visibility cannot be determined, it defaults to hidden.
Future<void> setInitialBarVisibility() async {
  // Get the visibility from the [moduleBarNotifier].
  if (ModuleBarUtils.isVisible) {
    // If the bar is visible, display the [ModuleBar] visible.
    ModuleBarUtils.setVisible();
  } else {
    // Otherwise and as a fallback, display the [ModuleBar] hidden.
    ModuleBarUtils.setHidden();
  }
}
