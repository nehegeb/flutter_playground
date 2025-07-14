// main_module_bar.dart
//
// Provides a vertical, draggable module bar for navigation between app modules.
//
// Features:
// - Displays a bar on the left side of the screen with buttons for each module.
// - Highlights the selected module.
// - Allows resizing the bar width by dragging the right edge.
// - Shows the selected module's content in the main area.
//
// Usage:
//   Place [MainModuleBar] as a top-level widget in your app's layout.
//   The bar will handle module selection and display the corresponding module widget.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/helpers/app_router.dart';
import 'package:flutter_playground/helpers/app_permissions.dart';
import 'package:flutter_playground/localization/localization.dart';
import 'helpers/global_notifiers.dart';

/// Notifier for the currently selected app language.
final ValueNotifier<List<Map<String, dynamic>>> currentModuleBarNotifier =
    ValueNotifier<List<Map<String, dynamic>>>([
      {'isBarHidden': true, 'isBarWide': true},
    ]);

/// A vertical module bar positioned on the left side of the screen.
class MainModuleBar extends StatefulWidget {
  final String module;
  const MainModuleBar({super.key, required this.module});

  @override
  State<MainModuleBar> createState() => _MainModuleBarState();
}

/// State for [MainModuleBar].
class _MainModuleBarState extends State<MainModuleBar> {
  // Listen to the notifier for isBarWide.
  @override
  void initState() {
    super.initState();
    currentModuleBarNotifier.addListener(_onNotifierChanged);
  }

  @override
  void dispose() {
    currentModuleBarNotifier.removeListener(_onNotifierChanged);
    super.dispose();
  }

  void _onNotifierChanged() {
    setState(() {}); // Rebuild when notifier changes.
  }

  // The [MainModuleBar] itself, which contains buttons for each module.
  @override
  Widget build(BuildContext context) {
    final String currentModule = widget.module;
    final user = currentUserNotifier.value;
    final isMobileDevice = GlobalNotifiers.isMobile();

    // Get isBarWide from the notifier (default to true if not set).
    final isBarWide = currentModuleBarNotifier.value.isNotEmpty
        ? (currentModuleBarNotifier.value.first['isBarWide'] as bool? ?? true)
        : true;

    // Get isBarHidden from the notifier (default to true if not set).
    final isBarHidden = currentModuleBarNotifier.value.isNotEmpty
        ? (currentModuleBarNotifier.value.first['isBarHidden'] as bool? ?? true)
        : true;

    return Container(
      child: isMobileDevice
          ? Stack(
              children: [
                // For mobile devices, fill the whole screen with the module area...
                Center(child: ModuleBarNavigation(module: currentModule)),
                // ... and display the module bar as a floating side bar to the left.
                isBarHidden
                    // Hide the module bar if isBarHidden is true.
                    ? SizedBox.shrink()
                    // Otherwise, display the floating module bar.
                    : _ModuleBarFloating(
                        isWide:
                            false, // Always use narrow bar on mobile devices.
                        currentModule: currentModule,
                        user: user,
                      ),
              ],
            )
          : Row(
              children: [
                // For wide screens, display the module bar on the left side...
                _ModuleBar(
                  isWide: isBarWide,
                  currentModule: currentModule,
                  user: user,
                ),
                // ... and to its right the module area that fills the remaining space.
                Expanded(
                  child: Center(
                    child: ModuleBarNavigation(module: currentModule),
                  ),
                ),
              ],
            ),
    );
  }
}

/// A widget module bar of [MainModuleBar] itself.
class _ModuleBar extends StatelessWidget {
  final bool isWide;
  final String currentModule;
  final dynamic user;

  static const double barWidthWide = 250;
  static const double barWidthNarrow = 65;

  const _ModuleBar({
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
                      _ModuleBarButton(
                        icon: Icons.home,
                        label: Localization.getText('homePage.title'),
                        onTap: () => context.go('/home'),
                        selected: currentModule == 'HomePage',
                      ),
                      // Dashboard Module.
                      if (user != null &&
                              user.permissions.contains('module_dashboard') ||
                          user?.role == 'admin')
                        _ModuleBarButton(
                          icon: Icons.dashboard,
                          label: Localization.getText('dashboardModule.title'),
                          onTap: () => context.go('/dashboard'),
                          selected: currentModule == 'DashboardModule',
                        ),
                      // Firebase Module.
                      if (user != null &&
                              user.permissions.contains('module_firebase') ||
                          user?.role == 'admin')
                        _ModuleBarButton(
                          icon: Icons.cloud,
                          label: Localization.getText('firebaseModule.title'),
                          onTap: () => context.go('/firebase'),
                          selected: currentModule == 'FirebaseModule',
                        ),
                      // SQL Database Module.
                      if (user != null &&
                              user.permissions.contains(
                                'module_sql_database',
                              ) ||
                          user?.role == 'admin')
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
              );
            },
          ),
        ),
      ),
    );
  }
}

/// A widget that uses the [_ModuleBar] in a floating side bar.
class _ModuleBarFloating extends StatelessWidget {
  final bool isWide;
  final String currentModule;
  final dynamic user;

  const _ModuleBarFloating({
    required this.isWide,
    required this.currentModule,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isWide ? _ModuleBar.barWidthWide : _ModuleBar.barWidthNarrow,
      child: _ModuleBar(
        isWide: isWide,
        currentModule: currentModule,
        user: user,
      ),
    );
  }
}

/// A widget for the buttons in the [MainModuleBar].
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
