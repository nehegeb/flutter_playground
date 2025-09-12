// module_bar_navigation.dart
//

import 'package:flutter/material.dart';

// Main pages imports.
import 'package:flutter_playground/modules/main/pages/home/home_page.dart';
import 'package:flutter_playground/modules/main/pages/about/about_page.dart';
import 'package:flutter_playground/modules/main/pages/login/login_page.dart';
import 'package:flutter_playground/modules/main/pages/register/register_page.dart';
import 'package:flutter_playground/modules/main/pages/error_bad_request/error_bad_request_page.dart';
import 'package:flutter_playground/modules/main/pages/error_unauthorized/error_unauthorized_page.dart';
import 'package:flutter_playground/modules/main/pages/error_forbidden/error_forbidden_page.dart';
import 'package:flutter_playground/modules/main/pages/error_not_found/error_not_found_page.dart';
import 'package:flutter_playground/modules/main/pages/error_internal_server_error/error_internal_server_error_page.dart';
import 'package:flutter_playground/modules/main/pages/error_bad_gateway/error_bad_gateway_page.dart';
import 'package:flutter_playground/modules/main/pages/error_service_unavailable/error_service_unavailable_page.dart';
import 'package:flutter_playground/modules/main/pages/error_gateway_timeout/error_gateway_timeout_page.dart';

// Global settings pages imports.
import 'package:flutter_playground/modules/settings/pages/permissions/permissions_page.dart';

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
  final String? errorMessage;

  const ModuleBarNavigation({
    super.key,
    required this.module,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    switch (module) {
      // Main pages.
      case 'HomePage':
        return HomePage();
      case 'AboutPage':
        return AboutPage();
      case 'LoginPage':
        return LoginPage();
      case 'RegisterPage':
        return RegisterPage();
      // Error pages.
      case 'ErrorBadRequestPage':
        return ErrorBadRequestPage(errorMessage: errorMessage);
      case 'ErrorUnauthorizedPage':
        return ErrorUnauthorizedPage(errorMessage: errorMessage);
      case 'ErrorForbiddenPage':
        return ErrorForbiddenPage(errorMessage: errorMessage);
      case 'ErrorNotFoundPage':
        return ErrorNotFoundPage(errorMessage: errorMessage);
      case 'ErrorInternalServerErrorPage':
        return ErrorInternalServerErrorPage(errorMessage: errorMessage);
      case 'ErrorBadGatewayPage':
        return ErrorBadGatewayPage(errorMessage: errorMessage);
      case 'ErrorServiceUnavailablePage':
        return ErrorServiceUnavailablePage(errorMessage: errorMessage);
      case 'ErrorGatewayTimeoutPage':
        return ErrorGatewayTimeoutPage(errorMessage: errorMessage);

      // Global settings pages.
      case 'PermissionsPage':
        return PermissionsPage();

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

      // NOTE: Add more pages as needed.
      default:
        return HomePage();
    }
  }
}
