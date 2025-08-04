// module_bar.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/main_module_bar/main_module_bar.dart';
import 'package:flutter_playground/app/main_module_bar/widgets/module_button.dart';

/// A widget module bar of [MainModuleBar] itself.
class ModuleBar extends StatelessWidget {
  final bool isWide;
  final String currentModule;
  final dynamic user;

  static const double barWidthWide = 250;
  static const double barWidthNarrow = 65;

  const ModuleBar({
    super.key,
    required this.isWide,
    required this.currentModule,
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
                      // Home Page.
                      ModuleButton(
                        icon: Icons.home,
                        label: Localization.getText('pages.home.title'),
                        onTap: () => context.go('/home'),
                        selected: currentModule == 'HomePage',
                      ),
                      // Dashboard Module.
                      if (user != null &&
                              user.permissions.contains('module_dashboard') ||
                          user?.role == 'admin')
                        ModuleButton(
                          icon: Icons.dashboard,
                          label: Localization.getText(
                            'modules.dashboard.title',
                          ),
                          onTap: () => context.go('/dashboard'),
                          selected: currentModule == 'DashboardModule',
                        ),
                      // Template Module.
                      if (user != null &&
                              user.permissions.contains('module_template') ||
                          user?.role == 'admin')
                        ModuleButton(
                          icon: Icons.cloud,
                          label: Localization.getText('modules.template.title'),
                          onTap: () => context.go('/template'),
                          selected: currentModule == 'TemplateModule',
                        ),
                      // NOTE: Add more modules here as needed.
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
