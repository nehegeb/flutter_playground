// set_initial_bar_width.dart
//

import 'package:flutter_playground/app/local_cache/local_cache.dart';
import 'package:flutter_playground/app/module_bar/module_bar_utils.dart';

/// Initializes the [ModuleBar] width setting.
/// If the setting exists in the local cache, it sets the [ModuleBar] width accordingly.
/// If it does not exist, it sets the width according to [moduleBarNotifier].
/// If the width cannot be determined, it defaults to wide.
Future<void> setInitialBarWidth() async {
  // Check, if there's something in the local cache already.
  final settingExists = await LocalCache.check(setting: 'ModuleBarIsWide');
  if (settingExists) {
    // If the setting exists, load it from the cache.
    final setting = await LocalCache.load(setting: 'ModuleBarIsWide');

    // Set the app brightness based on the loaded setting.
    if (setting == false) {
      // If the setting is true, display the [ModuleBar] narrow.
      ModuleBarUtils.setNarrow();
    } else {
      // Otherwise and as a fallback, display the [ModuleBar] wide.
      ModuleBarUtils.setWide();
    }
  } else {
    // Get the width from the [moduleBarNotifier].
    if (ModuleBarUtils.isNarrow) {
      // If the width is narrow, display the [ModuleBar] narrow.
      ModuleBarUtils.setNarrow();
    } else {
      // Otherwise and as a fallback, display the [ModuleBar] wide.
      ModuleBarUtils.setWide();
    }
  }
}
