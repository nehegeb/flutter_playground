// about.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/changelog/changelog.dart';
import 'package:flutter_playground/app/changelog/ui_widgets/changelog_expansion_tile.dart';
import 'package:flutter_playground/app/licensing/licensing.dart';
import 'package:flutter_playground/app/licensing/ui_widgets/license_expansion_tile.dart';

/// The about page of the app.
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  static const String module = 'main';

  @override
  void initState() {
    super.initState();
    _initData();
  }

  // Load data for the about page.
  Future<void> _initData() async {
    await Changelog.initChangelogData(module: module);
    await Licensing.initLicensingData();
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
                Localization.getText('pages.about.title'),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),

              // Changelog section.
              ChangelogExpansionTile(module: module),

              // Packages used in this app.
              const LicenseExpansionTile(),
            ],
          ),
        ),
      ),
    );
  }
}
