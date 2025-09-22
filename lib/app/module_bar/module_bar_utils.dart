// module_bar_utils.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/module_bar/logic/set_bar_width.dart';
import 'package:flutter_playground/app/module_bar/logic/set_bar_visibility.dart';
import 'package:flutter_playground/app/module_bar/logic/set_initial_bar_width.dart';
import 'package:flutter_playground/app/module_bar/logic/set_initial_bar_visibility.dart';

/// Notifier for the [ModuleBar].
///
/// Properties of the notifier list:
/// - isBarHidden: Whether the [ModuleBar] is hidden or visible, as a boolean.
/// - isBarWide: Whether the [ModuleBar] is wide or narrow, as a boolean.
final ValueNotifier<List<Map<String, dynamic>>> moduleBarNotifier =
    ValueNotifier<List<Map<String, dynamic>>>([
      {'isBarWide': true, 'isBarHidden': true},
    ]);

/// Utility class for [ModuleBar] management.
/// Provides static methods manipulate the [ModuleBar].
///
/// Static Methods:
/// - [isWide]: Checks if the [ModuleBar] is wide. Returns boolean.
/// - [isNarrow]: Checks if the [ModuleBar] is narrow. Returns boolean.
/// - [isHidden]: Checks if the [ModuleBar] is hidden. Returns boolean.
/// - [isVisible]: Checks if the [ModuleBar] is shown. Returns boolean.
/// - [setWide]: Sets the [ModuleBar] width to wide.
/// - [setNarrow]: Sets the [ModuleBar] width to narrow.
/// - [toggleWidth]: Toggles [ModuleBar] between wide and narrow.
/// - [setVisible]: Sets the [ModuleBar] visibility to shown.0,
/// - [setHidden]: Sets the [ModuleBar] visibility to hidden.
/// - [toggleVisibility]: Toggles [ModuleBar] between shown and hidden.
class ModuleBarUtils {
  /// Get the current [ModuleBar] wide status (defaults to true if not set).
  static bool get isWide {
    return moduleBarNotifier.value.isNotEmpty
        ? (moduleBarNotifier.value.first['isBarWide'] as bool? ?? true)
        : true;
  }

  /// Get the current [ModuleBar] narrow status (defaults to false if not set).
  static bool get isNarrow {
    return !isWide;
  }

  /// Get the current [ModuleBar] hidden status (defaults to true if not set).
  static bool get isHidden {
    return moduleBarNotifier.value.isNotEmpty
        ? (moduleBarNotifier.value.first['isBarHidden'] as bool? ?? true)
        : true;
  }

  /// Get the current [ModuleBar] shown status (defaults to false if not set).
  static bool get isVisible {
    return !isHidden;
  }

  /// Set the [ModuleBar] width to wide.
  static void setWide() {
    setBarWidth(width: 'wide');
  }

  /// Set the [ModuleBar] width to narrow.
  static void setNarrow() {
    setBarWidth(width: 'narrow');
  }

  /// Toggle [ModuleBar] between wide and narrow.
  static void toggleWidth() {
    setBarWidth(width: 'toggle');
  }

  /// Set the [ModuleBar] visibility to shown.
  static void setVisible() {
    setBarVisibility(visibility: 'shown');
  }

  /// Set the [ModuleBar] visibility to hidden.
  static void setHidden() {
    setBarVisibility(visibility: 'hidden');
  }

  /// Toggle [ModuleBar] between shown and hidden.
  static void toggleVisibility() {
    setBarVisibility(visibility: 'toggle');
  }

  /// Initializes the [ModuleBar].
  /// Loads the initial width and visibility of the [ModuleBar]
  /// or sets it based on the user's device settings.
  static Future<void> initBar() async {
    // Set the initial width.
    await setInitialBarWidth();
    // Set the initial visibility.
    await setInitialBarVisibility();
  }
}
