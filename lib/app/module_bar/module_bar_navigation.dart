// module_bar_navigation.dart
//

import 'package:flutter/material.dart';

// Main pages imports.
import 'package:flutter_playground/pages/home/home.dart';
import 'package:flutter_playground/pages/login/login.dart';
import 'package:flutter_playground/pages/register/register.dart';
import 'package:flutter_playground/pages/about/about.dart';
import 'package:flutter_playground/pages/permissions/permissions.dart';
import 'package:flutter_playground/pages/page_not_found/page_not_found.dart';

// Template main module pages imports.
import 'package:flutter_playground/modules/template/pages/home/home.dart';
import 'package:flutter_playground/modules/template/pages/about/about.dart';
import 'package:flutter_playground/modules/template/modules/template/pages/home/home.dart';

// Settings main module pages imports.
import 'package:flutter_playground/modules/settings/pages/home/home.dart';
import 'package:flutter_playground/modules/settings/pages/about/about.dart';

// Note: The settings page for all main modules is always the same [SettingsPage].
// So for the basic module settings, no special settings page has to be added here.
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
