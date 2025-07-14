// global_notifiers.dart
//

import 'package:flutter/material.dart';

/// Notifier for the current device.
final ValueNotifier<List<Map<String, dynamic>>> currentDeviceNotifier =
    ValueNotifier<List<Map<String, dynamic>>>([
      {'isMobile': false},
    ]);

/// Notifier for the current user.
///
/// Static Methods:
/// - [of]: Returns an instance for the global notifiers.
/// - [isMobile]: Check, if the current device is a mobile device.
/// - [setMobile]: Sets the current device type.
class GlobalNotifiers {
  /// Get the current device type.
  static bool isMobile() {
    return currentDeviceNotifier.value.isNotEmpty
        ? (currentDeviceNotifier.value.first['isMobile'] as bool? ?? false)
        : false;
  }

  /// Set the current device type.
  static void setMobile(bool isMobile) {
    currentDeviceNotifier.value = [
      {'isMobile': isMobile},
    ];
  }
}
