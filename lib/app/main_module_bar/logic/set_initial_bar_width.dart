// set_initial_bar_width.dart
//

import 'package:flutter_playground/app/main_module_bar/main_module_bar.dart';
import 'package:flutter_playground/app/local_cache/local_cache.dart';
import 'package:flutter_playground/app/main_module_bar/main_module_bar_utils.dart';

/// Initializes the [MainModuleBar] width setting.
/// If the setting exists in the local cache, it sets the [MainModuleBar] width accordingly.
/// If it does not exist, it sets the width according to [currentModuleBarNotifier].
/// If the width cannot be determined, it defaults to wide.
Future<void> setInitialBarWidth() async {
  // Check, if there's something in the local cache already.
  final settingExists = await LocalCache.check(setting: 'ModuleBarIsWide');
  if (settingExists) {
    // If the setting exists, load it from the cache.
    final setting = await LocalCache.load(setting: 'ModuleBarIsWide');

    // Set the app brightness based on the loaded setting.
    if (setting == false) {
      // If the setting is true, display the [MainModuleBar] narrow.
      MainModuleBarUtils.setNarrow();
    } else {
      // Otherwise and as a fallback, display the [MainModuleBar] wide.
      MainModuleBarUtils.setWide();
    }
  } else {
    // Get the width from the [currentModuleBarNotifier].
    if (MainModuleBarUtils.isNarrow) {
      // If the width is narrow, display the [MainModuleBar] narrow.
      MainModuleBarUtils.setNarrow();
    } else {
      // Otherwise and as a fallback, display the [MainModuleBar] wide.
      MainModuleBarUtils.setWide();
    }
  }
}
