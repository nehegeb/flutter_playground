// main.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/localization/localization.dart';

/// The dashboard module.
class DashboardModule extends StatelessWidget {
  const DashboardModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(Localization.getText('modules.dashboard.title'))],
    );
  }
}
