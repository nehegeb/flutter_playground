// set_by_context.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/notifiers/is_mobile_device_notifier/is_mobile_device_notifier.dart';

/// Define the width threshold for mobile devices.
/// 600 pixels is a common breakpoint for mobile devices.
double _mobileWidth = 600;

/// Previous state of the device type to avoid unnecessary updates.
/// This is used to check if the device type has changed since the last check.
bool _isMobilePrevious = false;

/// Check if the device type has changed since the last check and update the notifier.
void setByContext(BuildContext context) {
  bool isMobile = MediaQuery.of(context).size.width < _mobileWidth;
  if (_isMobilePrevious != isMobile) {
    _isMobilePrevious = isMobile;
    IsMobileDeviceNotifier.setMobile(isMobile);
  }
}
