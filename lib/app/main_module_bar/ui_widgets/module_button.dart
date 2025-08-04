// module_button.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/main_module_bar/main_module_bar.dart';

/// A widget for the buttons in the [MainModuleBar].
class ModuleButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  const ModuleButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          // Set isBarHidden to true when a button is tapped.
          if (currentModuleBarNotifier.value.isNotEmpty) {
            currentModuleBarNotifier.value.first['isBarHidden'] = true;
          }
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
                Icon(
                  icon,
                  size: 32,
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
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
