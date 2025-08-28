// module_bar_navigation.dart
//

import 'package:flutter/material.dart';

// Main pages imports.
import 'package:flutter_playground/pages/home/home_page.dart';
import 'package:flutter_playground/pages/login/login_page.dart';
import 'package:flutter_playground/pages/register/register_page.dart';
import 'package:flutter_playground/pages/about/about_page.dart';
import 'package:flutter_playground/pages/permissions/permissions_page.dart';
import 'package:flutter_playground/pages/page_not_found/page_not_found_page.dart';

// Template main module pages imports.
import 'package:flutter_playground/modules/template/pages/home/home_page.dart';
import 'package:flutter_playground/modules/template/pages/about/about_page.dart';
import 'package:flutter_playground/modules/template/modules/template/pages/home/home_page.dart';

// Settings main module pages imports.
import 'package:flutter_playground/modules/settings/pages/home/home_page.dart';
import 'package:flutter_playground/modules/settings/pages/about/about_page.dart';

// Note: The permissions page for all main modules is always the same [PermissionsPage].
// So for the basic module permissions, no special permissions page has to be added here.
// It automatically always only displays the data necessary for the corresponding main module.

/// A widget to display the content for the selected module.
class ModuleBarNavigation extends StatelessWidget {
  final String module;
  const ModuleBarNavigation({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    switch (module) {
      // Main pages.
      case 'HomePage':
        return HomePage();
      case 'LoginPage':
        return LoginPage();
      case 'RegisterPage':
        return RegisterPage();
      case 'AboutPage':
        return AboutPage();
      case 'PermissionsPage':
        return PermissionsPage();
      case 'PageNotFoundPage':
        return PageNotFoundPage();

      // Template module pages.
      case 'TemplateHomePage':
        return TemplateHomePage();
      case 'TemplateAboutPage':
        return TemplateAboutPage();
      // Template sub module pages.
      case 'TemplateTemplateHomePage':
        return TemplateTemplateHomePage();

      // Settings module pages.
      case 'SettingsHomePage':
        return SettingsHomePage();
      case 'SettingsAboutPage':
        return SettingsAboutPage();

      // NOTE: Add more pages here as needed.
      default:
        return HomePage();
    }
  }
}
