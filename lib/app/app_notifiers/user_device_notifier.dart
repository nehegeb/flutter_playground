// user_device_notifier.dart
//

import 'package:flutter/material.dart';

/// Notifier for the current device.
final ValueNotifier<List<Map<String, dynamic>>> currentDeviceNotifier =
    ValueNotifier<List<Map<String, dynamic>>>([
      {'isMobile': false},
    ]);

/// Notifier for the device the user is using.
///
/// Static Methods:
/// - [isMobile]: Checks if the current device is a mobile device. Returns boolean.
/// - [setMobile]: Sets the current device type.
class UserDeviceNotifier {
  /// Get the current device type.
  static bool get isMobile {
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
