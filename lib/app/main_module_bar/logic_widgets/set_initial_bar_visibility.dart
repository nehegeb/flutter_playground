// set_initial_bar_visibility.dart
//

import 'package:flutter_playground/app/main_module_bar/main_module_bar.dart';
import 'package:flutter_playground/app/main_module_bar/main_module_bar_utils.dart';

/// Initializes the [MainModuleBar] visibility setting.
/// Sets the visibility according to [currentModuleBarNotifier].
/// If the visibility cannot be determined, it defaults to hidden.
Future<void> setInitialBarVisibility() async {
  // Get the visibility from the [currentModuleBarNotifier].
  if (MainModuleBarUtils.isVisible) {
    // If the bar is visible, display the [MainModuleBar] visible.
    MainModuleBarUtils.setVisible();
  } else {
    // Otherwise and as a fallback, display the [MainModuleBar] hidden.
    MainModuleBarUtils.setHidden();
  }
}
