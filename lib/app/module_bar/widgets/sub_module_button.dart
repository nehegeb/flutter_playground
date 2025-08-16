// sub_module_button.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/module_bar/module_bar_utils.dart';
import 'package:flutter_playground/app/modules/modules.dart';

/// A widget for the buttons in the [ModuleBar].
class SubModuleButton extends StatelessWidget {
  final String subModule;
  final VoidCallback onTap;
  final bool selected;

  const SubModuleButton({
    super.key,
    required this.subModule,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final AppSubModule? appSubModule = Modules.getSubModule(
      subModule: subModule,
    );

    // Define the label of the [AppSubModule].
    String label = '';
    switch (subModule) {
      case 'home':
        // Use the global home page for the home module.
        label = Localization.getText('pages.home.title');
        break;
      case 'settings':
        // Use the global settings page for the settings module.
        label = Localization.getText('pages.settings.title');
        break;
      default:
        // Use the individual text of the [MainAppModule], if it exists.
        label = Localization.getText(
          'modules.${appSubModule?.mainModuleIdTitle}.modules.${appSubModule?.idTitle}.title',
        );
    }

    // Define the icon path of the [AppSubModule].
    String iconPath = '';
    bool iconExists = false;
    switch (subModule) {
      case 'home':
        // Use the global home icon for the home page.
        iconPath = 'assets/app/images/homeIcon.png';
        iconExists = true;
        break;
      case 'settings':
        // Use the global settings icon for the settings module.
        iconPath = 'assets/app/images/settingsIcon.png';
        iconExists = true;
        break;
      default:
        // Use the individual icon of the [AppSubModule], if it exists.
        iconPath =
            'assets/modules/${appSubModule?.mainModuleIdTitle}/images/${appSubModule?.idTitle}Icon.png';
        iconExists = appSubModule?.idTitle != null;
    }

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
                  const SizedBox(width: 6),
                  iconExists
                      ? Image.asset(
                          iconPath,
                          width: 20,
                          height: 20,
                          color: selected
                              ? Theme.of(context).colorScheme.primary
                              : Modules.getColor(
                                  appSubModule: appSubModule,
                                  shade: 800,
                                ),
                        )
                      : const SizedBox(width: 20, height: 20),
                  const SizedBox(width: 6),

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
                              : Modules.getColor(appSubModule: appSubModule),
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
