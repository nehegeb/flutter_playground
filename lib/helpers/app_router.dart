/// app_router.dart
///
/// This file defines the application's routing logic using the go_router package.
///
/// Features:
/// - Centralizes all route definitions for modular navigation and deep linking.
/// - Uses a global [LoadingOverlay.navigatorKey] for placing the [LoadingOverlay].
/// - Provides a [pageTransition] helper for consistent fade transitions between all routes.
/// - Supports modular navigation for the module-area of the app.
/// - Designed for robust, declarative navigation across web and desktop, with URL-driven state.
///
/// Usage:
/// Import and use [appRouter] as the routerDelegate and routeInformationParser in your MaterialApp.router.
library app_router;

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'app_permissions.dart';
import 'loading_overlay.dart';
import 'package:flutter_playground/main.dart';

/// The main router for the application, using GoRouter for declarative routing.
final GoRouter appRouter = GoRouter(
  navigatorKey: LoadingOverlay.navigatorKey,
  refreshListenable: currentUserNotifier, // Listen to changes to the user.
  initialLocation: "/dashboard", // Set the initial route to the dashboard.
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      pageBuilder: (context, state) => pageTransition(
        child: MainScreen(module: ''), // No value blanks the module area.
        state: state,
      ),
      routes: [
        GoRoute(
          path: "login",
          pageBuilder: (context, state) => pageTransition(
            child: MainScreen(module: 'LoginPage'),
            state: state,
          ),
        ),
        GoRoute(
          path: "unauthorized",
          pageBuilder: (context, state) => pageTransition(
            child: MainScreen(module: 'UnauthorizedPage'),
            state: state,
          ),
        ),
      ],
    ),
    GoRoute(
      path: "/dashboard",
      pageBuilder: (context, state) => pageTransition(
        child: MainScreen(module: 'DashboardModule'),
        state: state,
      ),
      redirect: (context, state) {
        return _checkUserPermission('module_dashboard');
        /*
        final user = currentUserNotifier.value;
        if (user == null) return '/login';
        if (!user.permissions.contains('module_dashboard')) {
          return '/unauthorized';
        }
        return null;
        */
      },
    ),
    GoRoute(
      path: "/firebase",
      pageBuilder: (context, state) => pageTransition(
        child: MainScreen(module: 'FirebaseModule'),
        state: state,
      ),
      redirect: (context, state) {
        return _checkUserPermission('module_firebase');
        /*
        final user = currentUserNotifier.value;
        if (user == null) return '/login';
        if (!user.permissions.contains('module_firebase')) {
          return '/unauthorized';
        }
        return null;
        */
      },
    ),
    GoRoute(
      path: "/sql-database",
      pageBuilder: (context, state) => pageTransition(
        child: MainScreen(module: 'SqlDatabaseModule'),
        state: state,
      ),
      redirect: (context, state) {
        return _checkUserPermission('module_sql_database');
        /*
        final user = currentUserNotifier.value;
        if (user == null) return '/login';
        if (!user.permissions.contains('module_sql_database')) {
          return '/unauthorized';
        }
        return null;
        */
      },
    ),
  ],
);

/// Helper function for fade transition.
CustomTransitionPage<T> pageTransition<T>({
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
