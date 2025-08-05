// about.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/changelog/changelog.dart';
import 'package:flutter_playground/app/changelog/widgets/changelog_expansion_tile.dart';

/// The about page of the template module.
class TemplateAboutPage extends StatefulWidget {
  const TemplateAboutPage({super.key});

  @override
  State<TemplateAboutPage> createState() => _TemplateAboutPageState();
}

class _TemplateAboutPageState extends State<TemplateAboutPage> {
  static const String module = 'template';

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

              // Changelog section.
              FutureBuilder<void>(
                future: Changelog.initChangelogData(module: module),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ChangelogExpansionTile(module: module);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
