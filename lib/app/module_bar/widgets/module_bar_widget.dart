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
  final String mainModule;
  final dynamic user;

  static const double barWidthWide = 250;
  static const double barWidthNarrow = 65;

  const ModuleBarWidget({
    super.key,
    required this.isWide,
    required this.mainModule,
    required this.user,
  });

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
                      if (Modules.getModulesData() != null)
                        for (final entry in Modules.getModulesData()!.entries)
                          // Main Module Button.
                          MainModuleButton(
                            iconPath:
                                'assets/modules/${entry.key}/images/moduleLogo.png',
                            label: Localization.getText(
                              'modules.${entry.key}.title',
                            ),
                            onTap: () => context.go('/${entry.key}'),
                            selected: mainModule == entry.key,
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


                    // [
                    //   // Home Page.
                    //   MainModuleButton(
                    //     icon: Icons.home,
                    //     label: Localization.getText('pages.home.title'),
                    //     onTap: () => context.go('/home'),
                    //     selected: mainModule == 'HomePage',
                    //   ),
                    //   // Dashboard Module.
                    //   if (user != null &&
                    //           user.permissions.contains('module_dashboard') ||
                    //       user?.role == 'admin')
                    //     MainModuleButton(
                    //       icon: Icons.dashboard,
                    //       label: Localization.getText(
                    //         'modules.dashboard.title',
                    //       ),
                    //       onTap: () => context.go('/dashboard'),
                    //       selected: mainModule == 'DashboardModule',
                    //     ),
                    //   // Template Module.
                    //   if (user != null &&
                    //           user.permissions.contains('module_template') ||
                    //       user?.role == 'admin')
                    //     MainModuleButton(
                    //       icon: Icons.cloud,
                    //       label: Localization.getText('modules.template.title'),
                    //       onTap: () => context.go('/template'),
                    //       selected: mainModule == 'TemplateModule',
                    //     ),
                    //   // NOTE: Add more modules here as needed.
                    // ],
