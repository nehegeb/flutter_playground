// button_brightness.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';

/// A widget for the button to change app brightness, for wide screens.
/// It is used to the right within the [TopAppBar].
class ButtonBrightness extends StatefulWidget {
  const ButtonBrightness({super.key});

  @override
  ButtonBrightnessState createState() => ButtonBrightnessState();
}

class ButtonBrightnessState extends State<ButtonBrightness> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        AppTheme.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
      ),
      onPressed: () {
        setState(() {
          AppTheme.toggleBrightness();
        });
      },
      tooltip: Localization.getText('appBar.menu.switchAppBrightness'),
    );
  }
}
