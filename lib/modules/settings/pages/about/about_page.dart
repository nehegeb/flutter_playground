// about_page.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_helper/widgets/error_no_view_permission.dart';
import 'package:flutter_playground/app/permissions/permissions.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/changelog/changelog.dart';
import 'package:flutter_playground/app/changelog/widgets/changelog_expansion_tile.dart';

/// The about page of the settings main module.
class SettingsAboutPage extends StatefulWidget {
  const SettingsAboutPage({super.key});

  @override
  State<SettingsAboutPage> createState() => _SettingsAboutPageState();
}

class _SettingsAboutPageState extends State<SettingsAboutPage> {
  static const String mainModule = 'settings';

  @override
  void initState() {
    super.initState();
    _initData();
  }

  // Load data for the about page.
  Future<void> _initData() async {
    await Changelog.initDbChangelogData(module: mainModule);
  }

  @override
  Widget build(BuildContext context) {
    // If the [AppUser] has no '.view' permission for this page,
    // show them an error message instead.
    if (!Permissions.check(permission: Permissions.settings.view)) {
      return ErrorNoViewPermission();
    }

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
                Localization.getText('modules.main.pages.about.title'),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),

              // Changelog section.
              FutureBuilder<void>(
                future: Changelog.initDbChangelogData(module: mainModule),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ChangelogExpansionTile(module: mainModule);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
