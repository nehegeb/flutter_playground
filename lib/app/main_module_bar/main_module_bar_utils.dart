// main_module_bar_utils.dart
//

import 'package:flutter_playground/app/main_module_bar/logic_widgets/set_bar_width.dart';
import 'package:flutter_playground/app/main_module_bar/logic_widgets/set_bar_visibility.dart';
import 'package:flutter_playground/app/main_module_bar/logic_widgets/set_initial_bar_width.dart';
import 'package:flutter_playground/app/main_module_bar/logic_widgets/set_initial_bar_visibility.dart';
import 'package:flutter_playground/app/main_module_bar/main_module_bar.dart';

/// Utility class for [MainModuleBar] management.
/// Provides static methods manipulate the [MainModuleBar].
///
/// Static Methods:
/// - [isWide]: Checks if the [MainModuleBar] is wide. Returns boolean.
/// - [isNarrow]: Checks if the [MainModuleBar] is narrow. Returns boolean.
/// - [isHidden]: Checks if the [MainModuleBar] is hidden. Returns boolean.
/// - [isVisible]: Checks if the [MainModuleBar] is shown. Returns boolean.
/// - [setWide]: Sets the [MainModuleBar] width to wide.
/// - [setNarrow]: Sets the [MainModuleBar] width to narrow.
/// - [toggleWidth]: Toggles [MainModuleBar] between wide and narrow.
/// - [setVisible]: Sets the [MainModuleBar] visibility to shown.0,
/// - [setHidden]: Sets the [MainModuleBar] visibility to hidden.
/// - [toggleVisibility]: Toggles [MainModuleBar] between shown and hidden.
class MainModuleBarUtils {
  /// Get the current [MainModuleBar] wide status (defaults to true if not set).
  static bool get isWide {
    return currentModuleBarNotifier.value.isNotEmpty
        ? (currentModuleBarNotifier.value.first['isBarWide'] as bool? ?? true)
        : true;
  }

  /// Get the current [MainModuleBar] narrow status (defaults to false if not set).
  static bool get isNarrow {
    return !isWide;
  }

  /// Get the current [MainModuleBar] hidden status (defaults to true if not set).
  static bool get isHidden {
    return currentModuleBarNotifier.value.isNotEmpty
        ? (currentModuleBarNotifier.value.first['isBarHidden'] as bool? ?? true)
        : true;
  }

  /// Get the current [MainModuleBar] shown status (defaults to false if not set).
  static bool get isVisible {
    return !isHidden;
  }

  /// Set the [MainModuleBar] width to wide.
  static void setWide() {
    setBarWidth(width: 'wide');
  }

  /// Set the [MainModuleBar] width to narrow.
  static void setNarrow() {
    setBarWidth(width: 'narrow');
  }

  /// Toggle [MainModuleBar] between wide and narrow.
  static void toggleWidth() {
    setBarWidth(width: 'toggle');
  }

  /// Set the [MainModuleBar] visibility to shown.
  static void setVisible() {
    setBarVisibility(visibility: 'shown');
  }

  /// Set the [MainModuleBar] visibility to hidden.
  static void setHidden() {
    setBarVisibility(visibility: 'hidden');
  }

  /// Toggle [MainModuleBar] between shown and hidden.
  static void toggleVisibility() {
    setBarVisibility(visibility: 'toggle');
  }

  /// Initializes the [MainModuleBar].
  /// Loads the initial width and visibility of the [MainModuleBar]
  /// or sets it based on the user's device settings.
  static Future<void> initBar() async {
    // Set the initial width.
    await setInitialBarWidth();
    // Set the initial visibility.
    await setInitialBarVisibility();
  }
}
