// home_page.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_helper/widgets/error_no_view_permission.dart';
import 'package:flutter_playground/app/permissions/permissions.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// The home page of the template sub module of the template main module.
class TemplateTemplateHomePage extends StatelessWidget {
  const TemplateTemplateHomePage({super.key});
  static const String mainModule = 'template';
  static const String subModule = 'template';

  @override
  Widget build(BuildContext context) {
    // If the [AppUser] has no '.view' permission for this page,
    // show them an error message instead.
    if (!Permissions.check(permission: Permissions.template.template.view)) {
      return ErrorNoViewPermission();
    }

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
                    Localization.getText(
                      'modules.$mainModule.modules.$subModule.title',
                    ),
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
