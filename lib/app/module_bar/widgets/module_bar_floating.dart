// module_bar_floating.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/module_bar/widgets/module_bar_widget.dart';

/// A widget that uses the [ModuleBar] in a floating side bar.
class ModuleBarFloating extends StatelessWidget {
  final bool isWide;
  final String mainModule;
  final dynamic user;

  const ModuleBarFloating({
    super.key,
    required this.isWide,
    required this.mainModule,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isWide
          ? ModuleBarWidget.barWidthWide
          : ModuleBarWidget.barWidthNarrow,
      child: ModuleBarWidget(isWide: isWide, user: user),
    );
  }
}
