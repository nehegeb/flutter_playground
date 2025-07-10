/// main_module_bar.dart
///
/// Provides a vertical, draggable module bar for navigation between app modules.
///
/// Features:
/// - Displays a bar on the left side of the screen with buttons for each module.
/// - Highlights the selected module.
/// - Allows resizing the bar width by dragging the right edge.
/// - Shows the selected module's content in the main area.
///
/// Usage:
///   Place [ModuleBar] as a top-level widget in your app's layout.
///   The bar will handle module selection and display the corresponding module widget.
library main_module_bar;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/helpers/app_permissions.dart';
import 'package:flutter_playground/localization/localization.dart';
import 'package:flutter_playground/module_pages/login_page.dart';
import 'package:flutter_playground/module_pages/unauthorized_page.dart';
import 'package:flutter_playground/module_dashboard/module_dashboard.dart';
import 'package:flutter_playground/module_firebase/module_firebase.dart';
import 'package:flutter_playground/module_sql_database/module_sql_database.dart';

/// A vertical module bar positioned on the left side of the screen.
class ModuleBar extends StatefulWidget {
  final String module;
  const ModuleBar({super.key, required this.module});

  @override
  State<ModuleBar> createState() => _ModuleBarState();
}

class _ModuleBarState extends State<ModuleBar> {
  // The initial width of the draggable module bar.
  double _moduleBarWidth = 250;

  @override
  Widget build(BuildContext context) {
    // Get the current module from the widget parameter.
    final String currentModule = widget.module;
    // Get the current user from the app permissions.
    final user = currentUserNotifier.value;

    // Define min and max width constraints of the module bar.
    const double minWidth = 64;
    final double maxWidth = MediaQuery.of(context).size.width / 3;
    // Use the state variable and clamp it.
    double moduleBarWidth = _moduleBarWidth.clamp(minWidth, maxWidth);

    return Row(
      children: [
        // The module bar itself, which contains buttons for each module.
        SizedBox(
          width: moduleBarWidth,
          child: Stack(
            children: [
              Container(
                color: Theme.of(context).colorScheme.surface,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Only render module buttons button if user has permission.
                      // Dashboard module.
                      if (user != null &&
                          user.permissions.contains('module_dashboard'))
                        _ModuleBarButton(
                          icon: Icons.dashboard,
                          label: Localization.getText('dashboardModule.title'),
                          onTap: () => context.go('/dashboard'),
                          selected: currentModule == 'DashboardModule',
                        ),
                      // Firebase module.
                      if (user != null &&
                          user.permissions.contains('module_firebase'))
                        _ModuleBarButton(
                          icon: Icons.cloud,
                          label: Localization.getText('firebaseModule.title'),
                          onTap: () => context.go('/firebase'),
                          selected: currentModule == 'FirebaseModule',
                        ),
                      // SQL Database module.
                      if (user != null &&
                          user.permissions.contains('module_sql_database'))
                        _ModuleBarButton(
                          icon: Icons.storage,
                          label: Localization.getText(
                            'sqlDatabaseModule.title',
                          ),
                          onTap: () => context.go('/sql-database'),
                          selected: currentModule == 'SqlDatabaseModule',
                        ),
                    ],
                  ),
                ),
              ),
              // Add a draggable handle at the right edge.
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        _moduleBarWidth += details.delta.dx;
                        _moduleBarWidth = _moduleBarWidth.clamp(
                          minWidth,
                          maxWidth,
                        );
                      });
                    },
                    child: Container(
                      width: 8,
                      color: Colors.transparent,
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 3,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // The module content area that expands to fill the remaining space.
        Expanded(
          child: Center(
            // The modules are defined in 'app_router.dart'.
            child: (() {
              switch (currentModule) {
                case 'LoginPage':
                  return LoginPage();
                case 'UnauthorizedPage':
                  return UnauthorizedPage();
                case 'DashboardModule':
                  return DashboardModule();
                case 'FirebaseModule':
                  return FirebaseModule();
                case 'SqlDatabaseModule':
                  return SqlDatabaseModule();
                default:
                  return Container();
              }
            })(),
          ),
        ),
      ],
    );
  }
}

class _ModuleBarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  const _ModuleBarButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
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
