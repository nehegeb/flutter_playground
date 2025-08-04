// main.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// The template module.
class TemplateModule extends StatelessWidget {
  const TemplateModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(Localization.getText('modules.template.title'))],
    );
  }
}
