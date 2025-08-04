// module_bar_floating.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/main_module_bar/ui_widgets/module_bar.dart';

/// A widget that uses the [ModuleBar] in a floating side bar.
class ModuleBarFloating extends StatelessWidget {
  final bool isWide;
  final String currentModule;
  final dynamic user;

  const ModuleBarFloating({
    super.key,
    required this.isWide,
    required this.currentModule,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isWide ? ModuleBar.barWidthWide : ModuleBar.barWidthNarrow,
      child: ModuleBar(
        isWide: isWide,
        currentModule: currentModule,
        user: user,
      ),
    );
  }
}
