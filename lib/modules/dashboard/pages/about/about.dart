// about.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/localization/localization.dart';
import 'package:flutter_playground/changelog/changelog.dart';
import 'package:flutter_playground/changelog/ui_widgets/changelog_expansion_tile.dart';

/// The about page of the dashboard module.
class DashboardAboutPage extends StatefulWidget {
  const DashboardAboutPage({super.key});

  @override
  State<DashboardAboutPage> createState() => _DashboardAboutPageState();
}

class _DashboardAboutPageState extends State<DashboardAboutPage> {
  static const String module = 'dashboard';

  @override
  void initState() {
    super.initState();
    _initData();
  }

  // Load data for the about page.
  Future<void> _initData() async {
    await Changelog.initChangelogData(module: module);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Title of the about page.
              Text(
                Localization.getText('modules.$module.pages.about.title'),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),

              // Changelog section.
              ChangelogExpansionTile(module: module),
            ],
          ),
        ),
      ),
    );
  }
}
