/// global_notifiers.dart
///
/// Provides global notifiers to be used across the app.
///
/// Usage:
///
/// To update (set) a notifier value:
///   currentModuleNotifier.value = 'FirebaseModule';
///   currentLanguageNotifier.value = 'de';
///
/// To listen to a notifier in a widget:
///   ValueListenableBuilder<String>(
///     valueListenable: currentModuleNotifier,
///     builder: (context, module, child) {
///       return Text('Current module: ' + module);
///     },
///   );
///
/// Import this file where you need to access or listen to the notifiers.
library global_notifiers;

import 'package:flutter/foundation.dart';

/// Notifier for the currently selected app language, with an initial value.
final ValueNotifier<String> currentLanguageNotifier = ValueNotifier<String>(
  'en',
);

/// Notifier for the currently active module, with an initial value.
final ValueNotifier<String> currentModuleNotifier = ValueNotifier<String>(
  'DashboardModule',
);

// TODO: Replace the current language logic with this notifier.
// TODO: Write the currentModuleNotifier from the module bar.
