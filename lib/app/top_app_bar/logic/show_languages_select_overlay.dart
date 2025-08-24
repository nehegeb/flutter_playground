// show_languages_select_overlay.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/top_app_bar/widgets/languages_select_overlay.dart';

/// Shows the [LanguagesSelectOverlay] at the top right of the screen.
void showLanguagesSelectOverlay(BuildContext context) {
  // Position the [LanguagesSelectOverlay] in a box.
  final int offsetTop = 56;
  final int offsetRight = 10;
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;
  final Offset topRight = Offset(overlay.size.width - offsetRight, 0);

  // Create the [LanguagesSelectOverlay] widget.
  showMenu<String>(
    context: context,
    position: RelativeRect.fromLTRB(topRight.dx, topRight.dy + offsetTop, 0, 0),
    items: LanguagesSelectOverlay.languagesSelectEntry(context),
  ).then((selected) async {
    if (selected != null) {
      await Localization.setLanguage(languageId: selected);
    }
  });
}
