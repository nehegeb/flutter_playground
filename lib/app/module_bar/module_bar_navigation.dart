// module_bar_navigation.dart
//

import 'package:flutter/material.dart';

// Main pages imports.
import 'package:flutter_playground/pages/home/home.dart';
import 'package:flutter_playground/pages/login/login.dart';
import 'package:flutter_playground/pages/about/about.dart';
import 'package:flutter_playground/pages/settings/settings.dart';
import 'package:flutter_playground/pages/page_not_found/page_not_found.dart';

// Template module imports.
import 'package:flutter_playground/modules/template/pages/home/home.dart';
import 'package:flutter_playground/modules/template/pages/about/about.dart';
import 'package:flutter_playground/modules/template/modules/template/pages/home/home.dart';

// Settings module imports.
import 'package:flutter_playground/modules/settings/pages/home/home.dart';
import 'package:flutter_playground/modules/settings/pages/about/about.dart';

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
      case 'AboutPage':
        return AboutPage();
      case 'SettingsPage':
        return SettingsPage();
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
