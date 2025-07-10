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
import 'loading_overlay.dart';
import 'package:flutter_playground/main.dart';

/// The main router for the application, using GoRouter for declarative routing.
final GoRouter appRouter = GoRouter(
  navigatorKey: LoadingOverlay.navigatorKey,
  initialLocation: "/dashboard", // Set the initial route to the dashboard.
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      pageBuilder: (context, state) => pageTransition(
        child: MainScreen(module: ''), // No value blanks the module area.
        state: state,
      ),
    ),
    GoRoute(
      path: "/dashboard",
      pageBuilder: (context, state) => pageTransition(
        child: MainScreen(module: 'DashboardModule'),
        state: state,
      ),
    ),
    GoRoute(
      path: "/firebase",
      pageBuilder: (context, state) => pageTransition(
        child: MainScreen(module: 'FirebaseModule'),
        state: state,
      ),
    ),
    GoRoute(
      path: "/sql-database",
      pageBuilder: (context, state) => pageTransition(
        child: MainScreen(module: 'SqlDatabaseModule'),
        state: state,
      ),
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
