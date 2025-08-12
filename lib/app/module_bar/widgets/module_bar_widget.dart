// module_bar_widget.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/modules/modules.dart';
import 'package:flutter_playground/app/module_bar/widgets/main_module_button.dart';

/// A widget module bar of [ModuleBar] itself.
class ModuleBarWidget extends StatelessWidget {
  final bool isWide;
  final dynamic user;

  static const double barWidthWide = 300;
  static const double barWidthNarrow = 65;

  const ModuleBarWidget({super.key, required this.isWide, required this.user});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isWide ? barWidthWide : barWidthNarrow,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          // LayoutBuilder ensures the scroll view fills the available height.
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueListenableBuilder<String>(
                        valueListenable: mainModuleNotifier,
                        builder: (context, mainModule, child) {
                          return Column(
                            children: [
                              // [HomePage] button.
                              MainModuleButton(
                                iconPath: 'assets/app/images/homeIcon.png',
                                label: Localization.getText('pages.home.title'),
                                onTap: () => context.go('/home'),
                                selected: mainModule == 'home',
                              ),

                              // Module buttons for the user.
                              ...?Modules.getPermittedData()?.entries.map(
                                (entry) => MainModuleButton(
                                  mainModule: entry.key,
                                  subModules: entry.value['subModules'],
                                  isThisModuleAdministrative:
                                      entry.value['isAdministrative'] ?? false,
                                  iconPath: entry.key != 'settings'
                                      // Use the individual icon of the main module.
                                      ? 'assets/modules/${entry.key}/images/${entry.key}Icon.png'
                                      // Use the global settings icon for the settings module.
                                      : 'assets/app/images/settingsIcon.png',
                                  label: entry.key != 'settings'
                                      // Use the individual text of the main module.
                                      ? Localization.getText(
                                          'modules.${entry.key}.title',
                                        )
                                      // Use the global settings page for the settings module.
                                      : Localization.getText(
                                          'pages.settings.title',
                                        ),
                                  onTap: () => context.go('/${entry.key}'),
                                  selected: mainModule == entry.key,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
