// main_module_bar.dart
//
// Provides a vertical module bar for navigation between modules.
//
// Features:
// - Displays a bar on the left side of the screen with buttons for each module.
// - Highlights the selected module.
// - Shows the selected module's content in the main area.

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_router/app_router.dart';
import 'package:flutter_playground/app/app_user/app_user.dart';
import 'package:flutter_playground/app/app_notifiers/user_device_notifier.dart';
import 'package:flutter_playground/app/main_module_bar/main_module_bar_utils.dart';
import 'package:flutter_playground/app/main_module_bar/widgets/module_bar.dart';
import 'package:flutter_playground/app/main_module_bar/widgets/module_bar_floating.dart';

/// Notifier for the [MainModuleBar].
///
/// Properties of the notifier list:
/// - isBarHidden: Whether the [MainModuleBar] is hidden or visible, as a boolean.
/// - isBarWide: Whether the [MainModuleBar] is wide or narrow, as a boolean.
final ValueNotifier<List<Map<String, dynamic>>> currentModuleBarNotifier =
    ValueNotifier<List<Map<String, dynamic>>>([
      {'isBarWide': true, 'isBarHidden': true},
    ]);

/// A vertical module bar positioned on the left side of the screen.
/// It contains buttons for each module.
/// Then it displays the selected module's content in the main area to its right.
///
/// The [MainModuleBar] is responsive and adapts to mobile and wide screen layouts.
/// For wide screens, it can be toggled between wide and narrow states.
/// On mobile devices, it can be hidden or shown based, always displaying the wide state.
class MainModuleBar extends StatefulWidget {
  final String module;
  const MainModuleBar({super.key, required this.module});

  @override
  State<MainModuleBar> createState() => _MainModuleBarState();
}

/// State for [MainModuleBar].
class _MainModuleBarState extends State<MainModuleBar> {
  @override
  void initState() {
    super.initState();
    currentModuleBarNotifier.addListener(_refreshUi);
  }

  @override
  void dispose() {
    currentModuleBarNotifier.removeListener(_refreshUi);
    super.dispose();
  }

  /// Refresh the UI.
  void _refreshUi() {
    setState(() {});
  }

  // The [MainModuleBar] itself, which contains buttons for each module.
  @override
  Widget build(BuildContext context) {
    final String currentModule = widget.module;
    final user = appUserNotifier.value;
    final bool isMobileDevice = UserDeviceNotifier.isMobile;

    // Get [MainModuleBar] settings.
    final isBarWide = MainModuleBarUtils.isWide;
    final isBarHidden = MainModuleBarUtils.isHidden;

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
                    : ModuleBarFloating(
                        isWide: true, // Always use wide bar on mobile devices.
                        currentModule: currentModule,
                        user: user,
                      ),
              ],
            )
          : Row(
              children: [
                // For wide screens, display the module bar on the left side...
                ModuleBar(
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
