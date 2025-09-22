// set_is_mobile.dart
//

import 'package:flutter_playground/app/app_notifiers/is_mobile_device_notifier/is_mobile_device_notifier.dart';
import 'package:flutter_playground/app/module_bar/module_bar_utils.dart';

/// Set whether the current device is mobile or not.
void setIsMobile(bool isMobile) {
  // Adjust the UI for the switch.
  ModuleBarUtils.setHidden();

  // Set the notifier value to the provided isMobile value.
  isMobileDeviceNotifier.value = isMobile;
}
