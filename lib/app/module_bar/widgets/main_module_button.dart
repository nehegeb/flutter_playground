// main_module_button.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/module_bar/module_bar_utils.dart';
import 'package:flutter_playground/app/module_bar/widgets/sub_module_button.dart';
import 'package:flutter_playground/app/modules/modules.dart';

/// A widget for the buttons in the [ModuleBar].
class MainModuleButton extends StatefulWidget {
  final String? mainModule;
  final Map<String, dynamic>? subModulesData;
  final String? iconPath;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  const MainModuleButton({
    super.key,
    this.mainModule,
    this.subModulesData,
    this.iconPath,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  @override
  State<MainModuleButton> createState() => _MainModuleButtonState();
}

/// The state for the [MainModuleButton].
class _MainModuleButtonState extends State<MainModuleButton> {
  @override
  Widget build(BuildContext context) {
    // Check if the mainModule is not null or empty.
    final String mainModule;
    if (widget.subModulesData != null &&
        widget.mainModule != null &&
        widget.mainModule!.isNotEmpty) {
      mainModule = widget.mainModule!;
    } else {
      mainModule = '';
    }

    // Check if the icon exists.
    final bool iconExists =
        widget.iconPath != null && widget.iconPath!.isNotEmpty;

    // Check if the button has sub-modules.
    final bool hasSubModules =
        widget.subModulesData != null && widget.subModulesData!.isNotEmpty;

    return ValueListenableBuilder<String>(
      valueListenable: mainModuleNotifier,
      builder: (context, currentModule, _) {
        final bool expanded = hasSubModules && currentModule == mainModule;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              child: Tooltip(
                // Display a tooltip if the [ModuleBar] is narrow.
                message: ModuleBarUtils.isNarrow ? widget.label : '',
                waitDuration: const Duration(milliseconds: 400),
                child: InkWell(
                  onTap: () {
                    ModuleBarUtils.setHidden();
                    widget.onTap();
                  },
                  child: Container(
                    color: widget.selected
                        ? Theme.of(context).colorScheme.primary.withAlpha(32)
                        : Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Row(
                        children: [
                          // Icon to the left.
                          iconExists
                              ? Image.asset(
                                  widget.iconPath!,
                                  width: 32,
                                  height: 32,
                                  color: widget.selected
                                      ? Theme.of(context).colorScheme.primary
                                      : null,
                                )
                              : const SizedBox(width: 32, height: 32),

                          // Label to the right.
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                widget.label,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: widget.selected
                                      ? Theme.of(context).colorScheme.primary
                                      : null,
                                  fontWeight: widget.selected
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
            ),
            if (expanded)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widget.subModulesData!.entries.map((entry) {
                  return SubModuleButton(
                    subModule: entry.key,
                    iconPath:
                        'assets/modules/$mainModule/images/${entry.key}Icon.png',
                    label: Localization.getText(
                      'modules.$mainModule.modules.${entry.key}.title',
                    ),
                    onTap: () => context.go('/$mainModule/${entry.key}'),
                    selected: Modules.subModule == entry.key,
                  );
                }).toList(),
              ),
          ],
        );
      },
    );
  }
}
