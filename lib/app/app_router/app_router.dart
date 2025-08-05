// app_router.dart
//
// This file defines the application's routing logic using the go_router package.
//
// Features:
// - Centralizes all route definitions for modular navigation and deep linking.
// - Uses a global [LoadingOverlay.navigatorKey] for placing the [LoadingOverlay].
// - Designed for robust, declarative navigation across web and desktop, with URL-driven state.

import 'package:go_router/go_router.dart';
import 'package:flutter_playground/screens/main_screen.dart';
import 'package:flutter_playground/app/app_user/app_user.dart';
import 'package:flutter_playground/app/misc/widgets/loading_overlay.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';
import 'package:flutter_playground/app/app_router/widgets/fade_page_transition.dart';

/// The main router for the application, using GoRouter for declarative routing.
final GoRouter appRouter = GoRouter(
  navigatorKey: LoadingOverlay.navigatorKey,
  refreshListenable: appUserNotifier, // Listen to changes to the user.
  initialLocation: "/home", // Set the initial route to the [HomePage].
  routes: <RouteBase>[
    // The home page needs to be on the first layer of the stack.
    GoRoute(
      path: "/home",
      pageBuilder: (context, state) => fadePageTransition(
        child: MainScreen(routedPage: 'HomePage'),
        state: state,
      ),
    ),

    // Main pages of the app.
    GoRoute(
      path: "/",
      pageBuilder: (context, state) => fadePageTransition(
        child: MainScreen(
          routedPage: '',
        ), // No value opens [HomePage] as fallback.
        state: state,
      ),
      routes: [
        GoRoute(
          path: "login",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'LoginPage'),
            state: state,
          ),
        ),
        GoRoute(
          path: "page-not-found",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'PageNotFoundPage'),
            state: state,
          ),
        ),
        GoRoute(
          path: "about",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'AboutPage'),
            state: state,
          ),
        ),
      ],
    ),

    // Dashboard module.
    GoRoute(
      path: "/dashboard",
      pageBuilder: (context, state) => fadePageTransition(
        child: MainScreen(routedPage: 'DashboardHomePage'),
        state: state,
      ),
      redirect: (context, state) {
        return AppRouterUtils.checkUserPermission('module_dashboard');
      },
      routes: [
        GoRoute(
          path: "about",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'DashboardAboutPage'),
            state: state,
          ),
        ),
      ],
    ),

    // Template module.
    GoRoute(
      path: "/template",
      pageBuilder: (context, state) => fadePageTransition(
        child: MainScreen(routedPage: 'TemplateHomePage'),
        state: state,
      ),
      redirect: (context, state) {
        return AppRouterUtils.checkUserPermission('module_template');
      },
      routes: [
        GoRoute(
          path: "about",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'TemplateAboutPage'),
            state: state,
          ),
        ),
      ],
    ),

    // NOTE: Add more pages here as needed.
  ],
);
