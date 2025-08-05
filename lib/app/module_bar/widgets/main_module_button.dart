// main_module_button.dart
//

import 'package:flutter/material.dart';
// import 'package:flutter_playground/app/app_helper/app_helper.dart';
import 'package:flutter_playground/app/module_bar/module_bar_utils.dart';

/// A widget for the buttons in the [ModuleBar].
class MainModuleButton extends StatelessWidget {
  final String? iconPath;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  const MainModuleButton({
    super.key,
    this.iconPath,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    // Check, if the icon exists.
    final bool iconExists = iconPath != null && iconPath!.isNotEmpty;
    // TODO: AppHelper.fileExists() doesn't work on web. Remove the function!
    // final bool iconExists = iconPath != null && iconPath!.isNotEmpty
    //     ? AppHelper.fileExists(path: iconPath!)
    //     : false;

    return Material(
      child: InkWell(
        onTap: () {
          // Hide the [ModuleBar] when any button is tapped.
          ModuleBarUtils.setHidden();
          onTap();
        },
        child: Container(
          color: selected
              ? Theme.of(context).colorScheme.primary.withAlpha(32)
              : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              children: [
                iconExists
                    // If the given icon exists, show it.
                    ? Image.asset(
                        iconPath!,
                        width: 32,
                        height: 32,
                        color: selected
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      )
                    // If the icon does not exist, show a placeholder.
                    : const SizedBox(width: 32, height: 32),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 18,
                        color: selected
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      overflow: TextOverflow.clip,
                      softWrap: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
