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
  final String mainModule;
  final VoidCallback onTap;
  final bool selected;

  const MainModuleButton({
    super.key,
    required this.mainModule,
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
    final AppMainModule? appMainModule = Modules.getMainModule(
      mainModule: widget.mainModule,
    );

    // Define the label of the [AppMainModule].
    String label = '';
    switch (widget.mainModule) {
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
        label = Localization.getText('modules.${appMainModule?.idTitle}.title');
    }

    // Define the icon path of the [AppMainModule].
    String iconPath = '';
    bool iconExists = false;
    switch (widget.mainModule) {
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
        // Use the individual icon of the [AppMainModule], if it exists.
        iconPath =
            'assets/modules/${appMainModule?.idTitle}/images/${appMainModule?.idTitle}Icon.png';
        iconExists = appMainModule?.idTitle != null;
    }

    // Check if the button has sub modules.
    final List<AppSubModule>? appSubModules = Modules.subModules
        ?.where(
          (subModule) => subModule.mainModuleIdTitle == appMainModule?.idTitle,
        )
        .toList();
    final bool hasSubModules =
        appSubModules != null && appSubModules.isNotEmpty;

    // Listen for changes in the active [AppMainModule].
    // This will rebuild the [ModuleBar] when the active module changes.
    return ValueListenableBuilder<AppMainModule?>(
      valueListenable: activeMainModuleNotifier,
      builder: (context, activeAppMainModule, _) {
        final bool expanded =
            hasSubModules && activeAppMainModule == appMainModule;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              child: Tooltip(
                // Display a tooltip if the [ModuleBar] is narrow.
                message: ModuleBarUtils.isNarrow ? label : '',
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
                                  iconPath,
                                  width: 32,
                                  height: 32,
                                  color: widget.selected
                                      ? Theme.of(context).colorScheme.primary
                                      : Modules.getColor(
                                          appMainModule: appMainModule,
                                          shade: 800,
                                        ),
                                )
                              : const SizedBox(width: 32, height: 32),

                          // Label to the right.
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                label,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: widget.selected
                                      ? Theme.of(context).colorScheme.primary
                                      : Modules.getColor(
                                          appMainModule: appMainModule,
                                        ),
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
                children:
                    // Sub module buttons for which the [AppUser] has access to.
                    appSubModules
                        .map(
                          (entry) => SubModuleButton(
                            subModule: entry.idTitle,
                            onTap: () => context.go(
                              '/${widget.mainModule}/${entry.idTitle}',
                            ),
                            selected: Modules.subModule == entry,
                          ),
                        )
                        .toList(),
              ),
          ],
        );
      },
    );
  }
}
