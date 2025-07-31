// about.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/localization/localization.dart';
import 'package:flutter_playground/changelog/changelog.dart';
import 'package:flutter_playground/changelog/ui_widgets/changelog_expansion_tile.dart';
import 'package:flutter_playground/licensing/licensing.dart';
import 'package:flutter_playground/licensing/ui_widgets/license_expansion_tile.dart';

/// The about page.
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

  /// Load localization JSON files and set the initial language for the whole app.
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
