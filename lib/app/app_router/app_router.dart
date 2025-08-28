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
import 'package:flutter_playground/app/permissions/permissions.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/misc/widgets/loading_overlay.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';
import 'package:flutter_playground/app/app_router/widgets/fade_page_transition.dart';

/// The main router for the application, using GoRouter for declarative routing.
final GoRouter appRouter = GoRouter(
  navigatorKey: LoadingOverlay.navigatorKey,
  refreshListenable:
      appUserNotifier, // Listen to changes to the user for permission management.
  initialLocation: "/home", // Set the initial route to the [HomePage].
  errorBuilder: (context, state) => MainScreen(routedPage: 'PageNotFoundPage'),
  routes: <RouteBase>[
    // The home page needs to be on the first layer of the stack.
    GoRoute(
      path: "/home",
      pageBuilder: (context, state) => fadePageTransition(
        child: MainScreen(routedPage: 'HomePage'),
        state: state,
        mainModule: 'home',
        subModule: 'home',
      ),
    ),

    // Main pages of the app.
    // These are all open for public. No permission checks required.
    GoRoute(
      path: "/",
      pageBuilder: (context, state) => fadePageTransition(
        // No value for 'routedPage' opens [HomePage] as fallback.
        child: MainScreen(routedPage: ''),
        state: state,
      ),
      routes: [
        GoRoute(
          path: "about",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'AboutPage'),
            state: state,
            mainModule: 'home',
            subModule: 'about',
          ),
        ),
        GoRoute(
          path: "login",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'LoginPage'),
            state: state,
          ),
        ),
        GoRoute(
          path: "register",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'RegisterPage'),
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
      ],
    ),

    // Template module.
    GoRoute(
      path: "/template",
      pageBuilder: (context, state) => fadePageTransition(
        child: MainScreen(routedPage: 'TemplateHomePage'),
        state: state,
        mainModule: 'template',
        subModule: 'home',
      ),
      redirect: (context, state) {
        return AppRouterUtils.checkUserPermission(
          Permissions.template.access,
          context,
        );
      },
      routes: [
        GoRoute(
          path: "about",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'TemplateAboutPage'),
            state: state,
            mainModule: 'template',
            subModule: 'about',
          ),
          redirect: (context, state) {
            return AppRouterUtils.checkUserPermission(
              Permissions.template.access,
              context,
            );
          },
        ),
        GoRoute(
          path: "template",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'TemplateTemplateHomePage'),
            state: state,
            mainModule: 'template',
            subModule: 'template',
          ),
          redirect: (context, state) {
            return AppRouterUtils.checkUserPermission(
              Permissions.template.template.access,
              context,
            );
          },
        ),
        GoRoute(
          path: "permissions",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'PermissionsPage'),
            state: state,
            mainModule: 'template',
            subModule: 'permissions',
          ),
          redirect: (context, state) {
            return AppRouterUtils.checkUserPermission(
              Permissions.template.permissions.access,
              context,
            );
          },
        ),
      ],
    ),

    // Settings module.
    GoRoute(
      path: "/settings",
      pageBuilder: (context, state) => fadePageTransition(
        child: MainScreen(routedPage: 'SettingsHomePage'),
        state: state,
        mainModule: 'settings',
        subModule: 'home',
      ),
      redirect: (context, state) {
        return AppRouterUtils.checkUserPermission(
          Permissions.settings.access,
          context,
        );
      },
      routes: [
        GoRoute(
          path: "about",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'SettingsAboutPage'),
            state: state,
            mainModule: 'settings',
            subModule: 'about',
          ),
          redirect: (context, state) {
            return AppRouterUtils.checkUserPermission(
              Permissions.settings.access,
              context,
            );
          },
        ),
        GoRoute(
          path: "permissions",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'PermissionsPage'),
            state: state,
            mainModule: 'settings',
            subModule: 'permissions',
          ),
          redirect: (context, state) {
            return AppRouterUtils.checkUserPermission(
              Permissions.settings.permissions.access,
              context,
            );
          },
        ),
      ],
    ),

    // NOTE: Add more pages as needed. Preferably before the 'settings' main module.
  ],
);
