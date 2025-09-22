// template_page.dart
//
// | === THIS BLOCK CAN BE DELETED AFTER COPYING THIS TEMPLATE FILE ===
// |
// | This is a template page for creating new pages for any main module.
// | NOTE: There's a separate template for sub module pages:
// |       lib/modules/template/modules/template/pages/template/template_page.dart
// |
// | Features:
// | - Permission check to see if the user has '.view' permission for this page.
// | - Scrollable content area with default padding.
// | - Localized page title text, centered at the top.
// |
// | Setup:
// | 1. Copy this template file, including its folder, to the desired main module's pages directory.
// | 2. Rename the copied file and its folder to match the new page name.
// |    - Use 'snake_case' for folder and file names, e.g. 'home' and 'home_page.dart'.
// |    - Add '_page' suffix to the file name, but not to the folder name.
// | 3. Within the copied file, update the following:
// |    - The first line with the correct file name.
// |    - Class name, like '<MainModuleName><PageName>Page'.
// |      NOTE: This class name needs to be unique across the entire app to avoid conflicts!
// |    - Class constructor (one line below) to match the class name.
// |    - Static string with the 'idTitle' of the [mainModule].
// |    - Permission check, if needed. Default is to check for the main module's '.view' permission.
// |    - Localization key for the title text, like 'modules.<MainModuleName>.pages.<PageName>.title'.
// | 4. Add the localization key and its translations to the localization files.
// | 5. Add the new page to the [ModuleBarNavigation] and the [appRouter].
// |
// | For further details, see the README file in lib/modules/template/.
// |
// | === THIS BLOCK CAN BE DELETED AFTER COPYING THIS TEMPLATE FILE ===

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_helper/widgets/error_no_view_permission.dart';
import 'package:flutter_playground/app/permissions/permissions.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// The template page of the template main module.
class TemplateTemplatePage extends StatelessWidget {
  const TemplateTemplatePage({super.key});
  static const String mainModule = 'template';

  @override
  Widget build(BuildContext context) {
    // If the [AppUser] has no '.view' permission for this page, show them an error message instead.
    if (!Permissions.check(permission: Permissions.template.view)) {
      return ErrorNoViewPermission();
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              Localization.getText('modules.$mainModule.pages.template.title'),
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
