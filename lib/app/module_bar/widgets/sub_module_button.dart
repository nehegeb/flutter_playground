// sub_module_button.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/module_bar/module_bar_utils.dart';

/// A widget for the buttons in the [ModuleBar].
class SubModuleButton extends StatelessWidget {
  final String subModule;
  final String? iconPath;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  const SubModuleButton({
    super.key,
    required this.subModule,
    this.iconPath,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the icon exists.
    final bool iconExists = iconPath != null && iconPath!.isNotEmpty;

    return Material(
      child: Tooltip(
        // Display a tooltip if the [ModuleBar] is narrow.
        message: ModuleBarUtils.isNarrow ? label : '',
        waitDuration: const Duration(milliseconds: 400),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // Icon to the left.
                  const SizedBox(width: 4),
                  iconExists
                      ? Image.asset(
                          iconPath!,
                          width: 24,
                          height: 24,
                          color: selected
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        )
                      : const SizedBox(width: 24, height: 24),
                  const SizedBox(width: 4),

                  // Label to the right.
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 14,
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
      ),
    );
  }
}
