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

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'app_permissions.dart';
import 'loading_overlay.dart';
import 'package:flutter_playground/localization/localization.dart';
import 'package:flutter_playground/main.dart';
import 'package:flutter_playground/module_pages/home_page.dart';
import 'package:flutter_playground/module_pages/login_page.dart';
import 'package:flutter_playground/module_pages/unauthorized_page.dart';
import 'package:flutter_playground/module_pages/about_page.dart';
import 'package:flutter_playground/module_dashboard/module_dashboard.dart';
import 'package:flutter_playground/module_firebase/module_firebase.dart';
import 'package:flutter_playground/module_sql_database/module_sql_database.dart';

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
          path: "unauthorized",
          pageBuilder: (context, state) => _pageTransition(
            child: MainScreen(module: 'UnauthorizedPage'),
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
      path: "/firebase",
      pageBuilder: (context, state) => _pageTransition(
        child: MainScreen(module: 'FirebaseModule'),
        state: state,
      ),
      redirect: (context, state) {
        return _checkUserPermission('module_firebase');
      },
    ),
    GoRoute(
      path: "/sql-database",
      pageBuilder: (context, state) => _pageTransition(
        child: MainScreen(module: 'SqlDatabaseModule'),
        state: state,
      ),
      redirect: (context, state) {
        return _checkUserPermission('module_sql_database');
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
      case 'UnauthorizedPage':
        return UnauthorizedPage();
      case 'AboutPage':
        return AboutPage();
      case 'DashboardModule':
        return DashboardModule();
      case 'FirebaseModule':
        return FirebaseModule();
      case 'SqlDatabaseModule':
        return SqlDatabaseModule();
      // NOTE: Add more modules here as needed.
      default:
        return HomePage();
    }
  }
}

/// Provides access to routing information.
///
/// Static Methods:
/// - [of]: Returns a Licensing instance.
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
        return Localization.getText('dashboardModule.title');
      case 'firebase':
        return Localization.getText('firebaseModule.title');
      case 'sql-database':
        return Localization.getText('sqlDatabaseModule.title');
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
    return '/unauthorized';
  }
  return null; // All checks passed, no redirect needed.
}
