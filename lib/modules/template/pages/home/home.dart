// home.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/localization/localization.dart';

/// The home page of the template module.
class TemplateHomePage extends StatelessWidget {
  const TemplateHomePage({super.key});
  static const String module = 'template';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Scrollable main content column stretched across the screen.
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title of the home page.
                  Text(
                    Localization.getText('modules.$module.title'),
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),

        // 'About' button at bottom right.
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            mini: true,
            tooltip: Localization.getText('modules.$module.pages.about.title'),
            onPressed: () {
              context.go('/$module/about');
            },
            child: const Icon(Icons.info_outline, size: 20),
          ),
        ),
      ],
    );
  }
}
