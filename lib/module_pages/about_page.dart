/// about_page.dart
///
library about_page;

import 'package:flutter/material.dart';
import 'package:flutter_playground/localization/localization.dart';

/// The about page.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                  PackageLicenseInfo(
                    packageName: 'aboutPage.packageGoRouterName',
                    packageLicense: 'aboutPage.packageGoRouterLicense',
                  ),
                  // url_launcher package.
                  PackageLicenseInfo(
                    packageName: 'aboutPage.packageUrlLauncherName',
                    packageLicense: 'aboutPage.packageUrlLauncherLicense',
                  ),
                  //pluto_grid package.
                  PackageLicenseInfo(
                    packageName: 'aboutPage.packagePlutoGridName',
                    packageLicense: 'aboutPage.packagePlutoGridLicense',
                  ),
                  // lorem_ipsum package.
                  PackageLicenseInfo(
                    packageName: 'aboutPage.packageLoremIpsumName',
                    packageLicense: 'aboutPage.packageLoremIpsumLicense',
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

/// Widget to display a package name and its license.
class PackageLicenseInfo extends StatelessWidget {
  final String packageName;
  final String packageLicense;

  const PackageLicenseInfo({
    super.key,
    required this.packageName,
    required this.packageLicense,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Localization.getText(packageName),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        RichText(
          text: Localization.getRichText(
            packageLicense,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
