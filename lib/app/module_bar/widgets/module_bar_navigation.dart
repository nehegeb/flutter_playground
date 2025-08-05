// module_bar_navigation.dart
//

import 'package:flutter/material.dart';

// Main pages imports.
import 'package:flutter_playground/pages/home/home.dart';
import 'package:flutter_playground/pages/login/login.dart';
import 'package:flutter_playground/pages/page_not_found/page_not_found.dart';
import 'package:flutter_playground/pages/about/about.dart';

// Template module imports.
import 'package:flutter_playground/modules/template/main.dart';
import 'package:flutter_playground/modules/template/pages/home/home.dart';
import 'package:flutter_playground/modules/template/pages/about/about.dart';

// Dashboard module imports.
import 'package:flutter_playground/modules/dashboard/main.dart';
import 'package:flutter_playground/modules/dashboard/pages/home/home.dart';
import 'package:flutter_playground/modules/dashboard/pages/about/about.dart';

/// A widget to display the content for the selected module.
class ModuleBarNavigation extends StatelessWidget {
  final String module;
  const ModuleBarNavigation({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    switch (module) {
      case 'HomePage':
        return HomePage();
      case 'LoginPage':
        return LoginPage();
      case 'PageNotFoundPage':
        return PageNotFoundPage();
      case 'AboutPage':
        return AboutPage();
      case 'DashboardModule':
        return DashboardModule();
      case 'DashboardHomePage':
        return DashboardHomePage();
      case 'DashboardAboutPage':
        return DashboardAboutPage();
      case 'TemplateModule':
        return TemplateModule();
      case 'TemplateHomePage':
        return TemplateHomePage();
      case 'TemplateAboutPage':
        return TemplateAboutPage();
      // NOTE: Add more pages here as needed.
      default:
        return HomePage();
    }
  }
}
