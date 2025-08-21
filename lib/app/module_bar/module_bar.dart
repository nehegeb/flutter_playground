// module_bar.dart
//
// Provides a vertical module bar for navigation between modules.
//
// Features:
// - Displays a bar on the left side of the screen with buttons for each module.
// - Highlights the selected module.
// - Shows the selected module's content in the main area.

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/app_notifiers/is_mobile_device_notifier/is_mobile_device_notifier.dart';
import 'package:flutter_playground/app/module_bar/module_bar_utils.dart';
import 'package:flutter_playground/app/module_bar/widgets/module_bar_widget.dart';
import 'package:flutter_playground/app/module_bar/widgets/module_bar_floating.dart';
import 'package:flutter_playground/app/module_bar/module_bar_navigation.dart';

/// A vertical module bar positioned on the left side of the screen.
/// It contains buttons for each module.
/// Then it displays the selected module's content in the main area to its right.
///
/// The [ModuleBar] is responsive and adapts to mobile and wide screen layouts.
/// For wide screens, it can be toggled between wide and narrow states.
/// On mobile devices, it can be hidden or shown based, always displaying the wide state.
class ModuleBar extends StatefulWidget {
  final String routedPage;
  const ModuleBar({super.key, required this.routedPage});

  @override
  State<ModuleBar> createState() => _ModuleBarState();
}

/// State for [ModuleBar].
class _ModuleBarState extends State<ModuleBar> {
  @override
  void initState() {
    super.initState();
    moduleBarNotifier.addListener(_refreshUi);
  }

  @override
  void dispose() {
    moduleBarNotifier.removeListener(_refreshUi);
    super.dispose();
  }

  /// Refresh the UI.
  void _refreshUi() {
    setState(() {});
  }

  // The [ModuleBar] itself, which contains buttons for each module.
  @override
  Widget build(BuildContext context) {
    final String routedPage = widget.routedPage;
    final user = User.user;

    // Get [ModuleBar] settings.
    final isBarWide = ModuleBarUtils.isWide;
    final isBarHidden = ModuleBarUtils.isHidden;

    return ValueListenableBuilder<bool>(
      valueListenable: isMobileDeviceNotifier,
      builder: (context, isMobileDevice, _) {
        return Container(
          child: isMobileDevice
              ? Stack(
                  children: [
                    // For mobile devices, fill the whole screen with the module area...
                    GestureDetector(
                      // Hide [ModuleBar] when clicked beside it.
                      onTap: () => ModuleBarUtils.setHidden(),
                      child: Center(
                        child: ModuleBarNavigation(module: routedPage),
                      ),
                    ),
                    // ... and display the module bar as a floating side bar to the left.
                    isBarHidden
                        // Hide the module bar if isBarHidden is true.
                        ? SizedBox.shrink()
                        // Otherwise, display the floating module bar.
                        : ModuleBarFloating(
                            isWide:
                                true, // Always use wide bar on mobile devices.
                            mainModule: routedPage,
                            user: user,
                          ),
                  ],
                )
              : Row(
                  children: [
                    // For wide screens, display the module bar on the left side...
                    ModuleBarWidget(isWide: isBarWide, user: user),
                    // ... and to its right the module area that fills the remaining space.
                    Expanded(
                      child: Center(
                        child: ModuleBarNavigation(module: routedPage),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
