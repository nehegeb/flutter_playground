// is_mobile_device_notifier.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_notifiers/is_mobile_device_notifier/logic/set_is_mobile.dart';
import 'package:flutter_playground/app/app_notifiers/is_mobile_device_notifier/logic/set_by_context.dart';

/// Notifier whether the users device is mobile or a wide screen.
final ValueNotifier<bool> isMobileDeviceNotifier = ValueNotifier<bool>(false);

/// Notifier whether the users device is mobile or a wide screen.
///
/// Static Methods:
/// - [isMobile]: Gets whether the current device is a mobile device. Returns boolean.
/// - [setMobile]: Sets whether the current device is mobile or not. (!)
/// - [checkAndSet]: Checks if the device is mobile and updates the notifier.
class IsMobileDeviceNotifier {
  /// Get whether the current device is a mobile device from the notifier.
  static bool get isMobile {
    return isMobileDeviceNotifier.value;
  }

  /// Set the current device type for the [isMobileDeviceNotifier].
  ///
  /// Note: This method is used to update the device type for the [isMobileDeviceNotifier] directly.
  /// To reliably detect the actually used device type, use the [checkAndSet] method.
  static void setMobile(bool isMobile) {
    setIsMobile(isMobile);
  }

  /// Check if the device type (detected by screen size) has changed and update the [isMobileDeviceNotifier].
  static void checkAndSet(BuildContext context) {
    setByContext(context);
  }
}
