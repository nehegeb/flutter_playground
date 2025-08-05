// set_is_mobile.dart
//

import 'package:flutter_playground/notifiers/is_mobile_device_notifier/is_mobile_device_notifier.dart';

/// Set whether the current device is mobile or not.
void setIsMobile(bool isMobile) {
  isMobileDeviceNotifier.value = isMobile;
}
