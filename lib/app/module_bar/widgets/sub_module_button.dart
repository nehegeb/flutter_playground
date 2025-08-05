// sub_module_button.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/module_bar/module_bar_utils.dart';

/// A widget for the buttons in the [ModuleBar].
class SubModuleButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool selected;

  const SubModuleButton({
    super.key,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
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
                SizedBox(width: 32), // Some indent at the start.
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
