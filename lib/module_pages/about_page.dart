/// about_page.dart
///
library about_page;

import 'package:flutter/material.dart';
import 'package:flutter_playground/localization/localization.dart';
import 'package:flutter_playground/licensing/licensing.dart';

/// The about page.
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
    Licensing.initLicensingData();
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
                Localization.getText('aboutPage.title'),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),

              // Packages used in this app.
              ExpansionTile(
                title: Text(Localization.getText('aboutPage.packagesUsed')),
                initiallyExpanded: false,
                children: [
                  // go_router package.
                  LicenseInfo(
                    packageName: 'go_router',
                    copyright: '2021 The go_router Authors',
                    license: 'BSD3',
                    packageUrl: 'https://pub.dev/packages/go_router',
                  ),
                  // url_launcher package.
                  LicenseInfo(
                    packageName: 'url_launcher',
                    copyright: '2013 The Flutter Authors',
                    license: 'BSD3',
                    packageUrl: 'https://pub.dev/packages/url_launcher',
                  ),
                  // pluto_grid package.
                  LicenseInfo(
                    packageName: 'pluto_grid',
                    copyright: '2020 Bosskmk',
                    license: 'MIT',
                    packageUrl: 'https://github.com/bosskmk/pluto_grid',
                  ),
                  // lorem_ipsum package.
                  LicenseInfo(
                    packageName: 'lorem_ipsum',
                    copyright: '2019-2025 lorem_ipsum contributors',
                    license: 'MIT',
                    packageUrl: 'https://pub.dev/packages/lorem_ipsum',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
