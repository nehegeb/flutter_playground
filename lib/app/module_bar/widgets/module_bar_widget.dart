// module_bar_widget.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_router/app_router.dart';
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
        color: Theme.of(context).colorScheme.primaryContainer,
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
                      // Listen for changes in the active [AppMainModule].
                      // This will rebuild the [ModuleBar] when the active module changes.
                      ValueListenableBuilder<AppMainModule?>(
                        valueListenable: activeMainModuleNotifier,
                        builder: (context, activeAppMainModule, child) {
                          return Column(
                            children: [
                              // [HomePage] button.
                              MainModuleButton(
                                mainModule: 'home',
                                onTap: () => appRouter.go('/home'),
                                selected:
                                    activeAppMainModule?.idTitle == 'home',
                              ),

                              // Main module buttons for which the [AppUser] has access to.
                              ...?Modules.permittedMainModules?.map(
                                (appMainModule) => MainModuleButton(
                                  mainModule: appMainModule.idTitle,
                                  onTap: () =>
                                      appRouter.go('/${appMainModule.idTitle}'),
                                  selected:
                                      activeAppMainModule == appMainModule,
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
