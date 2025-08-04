// app_router.dart
//
// This file defines the application's routing logic using the go_router package.
//
// Features:
// - Centralizes all route definitions for modular navigation and deep linking.
// - Uses a global [LoadingOverlay.navigatorKey] for placing the [LoadingOverlay].
// - Provides a [_pageTransition] helper for consistent fade transitions between all routes.
// - Supports modular navigation for the module-area of the app.
// - Designed for robust, declarative navigation across web and desktop, with URL-driven state.
//
// Usage:
// Import and use [appRouter] as the routerDelegate and routeInformationParser in your MaterialApp.router.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/screens/main_screen.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/app_permissions.dart';
import 'package:flutter_playground/app/misc/ui_widgets/loading_overlay.dart';

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

/// The main router for the application, using GoRouter for declarative routing.
final GoRouter appRouter = GoRouter(
  navigatorKey: LoadingOverlay.navigatorKey,
  refreshListenable: currentUserNotifier, // Listen to changes to the user.
  initialLocation: "/home", // Set the initial route to the dashboard.
  routes: <RouteBase>[
    // Main pages of the app.
    GoRoute(
      path: "/",
      pageBuilder: (context, state) => _pageTransition(
        child: MainScreen(module: ''), // No value opens the fallback: HomePage.
        state: state,
      ),
      routes: [
        GoRoute(
          path: "login",
          pageBuilder: (context, state) => _pageTransition(
            child: MainScreen(module: 'LoginPage'),
            state: state,
          ),
        ),
        GoRoute(
          path: "page-not-found",
          pageBuilder: (context, state) => _pageTransition(
            child: MainScreen(module: 'PageNotFoundPage'),
            state: state,
          ),
        ),
        GoRoute(
          path: "about",
          pageBuilder: (context, state) => _pageTransition(
            child: MainScreen(module: 'AboutPage'),
            state: state,
          ),
        ),
      ],
    ),

    // The home page needs to be on the first layer of the stack.
    GoRoute(
      path: "/home",
      pageBuilder: (context, state) => _pageTransition(
        child: MainScreen(module: 'HomePage'),
        state: state,
      ),
    ),

    // Modules.
    GoRoute(
      path: "/dashboard",
      pageBuilder: (context, state) => _pageTransition(
        child: MainScreen(module: 'DashboardModule'),
        state: state,
      ),
      redirect: (context, state) {
        return _checkUserPermission('module_dashboard');
      },
    ),
    GoRoute(
      path: "/template",
      pageBuilder: (context, state) => _pageTransition(
        child: MainScreen(module: 'TemplateModule'),
        state: state,
      ),
      redirect: (context, state) {
        return _checkUserPermission('module_template');
      },
    ),
    // NOTE: Add more modules here as needed.
  ],
);

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
      case 'TemplateModule':
        return TemplateModule();
      // NOTE: Add more modules here as needed.
      default:
        return HomePage();
    }
  }
}

/// Provides access to routing information.
///
/// Static Methods:
/// - [getModuleTitle]: Returns the title of the current module based on the url.
class AppRouter {
  /// Returns the title of the current module based on the url.
  static String getModuleTitle(context) {
    // Get the current route information.
    final location = GoRouter.of(
      context,
    ).routeInformationProvider.value.uri.toString();
    final uri = Uri.parse(location);
    final segments = uri.pathSegments;
    final module = segments.isNotEmpty ? segments.first : '';

    // Return the localized title based on the module.
    // NOTE: Only modules should be added here, not pages!
    switch (module) {
      case 'dashboard':
        return Localization.getText('modules.dashboard.title');
      case 'template':
        return Localization.getText('modules.template.title');
      // NOTE: Add more modules here as needed.
      default:
        return '';
    }
  }
}

/// Helper function for fade transition.
CustomTransitionPage<T> _pageTransition<T>({
  required Widget child,
  required GoRouterState state,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

/// Checks if the user has the required permission for a module.
/// Admins have all permissions, so they can access any module.
/// Returns the redirect path if permission is denied, or null if allowed.
String? _checkUserPermission(String permissionName) {
  if (permissionName.isEmpty) return null; // No permission check needed.
  final user = currentUserNotifier.value; // Get the current user.
  if (user == null) return '/login'; // User is not logged in.
  if (user.role == 'admin') return null; // Admins have all permissions.
  // Check if the user has the required permission.
  if (!user.permissions.contains(permissionName)) {
    return '/page-not-found'; // Redirect to page not found if permission is denied.
  }
  return null; // All checks passed, no redirect needed.
}
