// button_brightness_mobile.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/misc/widgets/popup_menu_entry_compact.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';

/// A widget for the button to change app brightness, for mobile devices.
/// It is used in the [UserMenu] at the top right of the [TopAppBar].
PopupMenuEntry<String> buttonBrightnessMobile(BuildContext context) {
  return PopupMenuEntryCompact(
    value: 'toggleAppBrightness',
    selected: false,
    child: Row(
      children: [
        Icon(
          AppTheme.isDarkMode
              ? Icons.wb_sunny_outlined
              : Icons.nightlight_round,
        ),
        const SizedBox(width: 8),
        Text(Localization.getText('appBar.menu.switchAppBrightness')),
      ],
    ),
  );
}
