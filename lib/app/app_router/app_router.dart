// app_router.dart
//
// This file defines the application's routing logic using the go_router package.
//
// Features:
// - Centralizes all route definitions for modular navigation and deep linking.
// - Designed for robust, declarative navigation across web and desktop, with URL-driven state.
// - Implements the HTML errors 401 (redirects to [LoginPage]), 403 and 404.
// - Also implements HTML errors 400, 500, 502, 503 and 504 via [appRouterErrorBuilder].

import 'package:go_router/go_router.dart';
import 'package:flutter_playground/screens/main_screen.dart';
import 'package:flutter_playground/app/permissions/permissions.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/app_router/app_router_error_builder.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';
import 'package:flutter_playground/app/app_router/widgets/fade_page_transition.dart';

export 'package:go_router/go_router.dart';

/// The main router for the application, using GoRouter for declarative routing.
final GoRouter appRouter = GoRouter(
  // Listen to changes to the user for permission management.
  refreshListenable: appUserNotifier,
  // Set the initial route to the [HomePage].
  initialLocation: "/home",
  // Manage all HTML error pages.
  errorBuilder: appRouterErrorBuilder,
  routes: <RouteBase>[
    // The home page needs to be on the first layer of the stack.
    GoRoute(
      path: "/home",
      pageBuilder: (context, state) => fadePageTransition(
        child: MainScreen(routedPage: 'HomePage'),
        state: state,
        mainModule: 'main',
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
            mainModule: 'main',
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
        // HTML error pages.
        GoRoute(
          path: "400-bad-request",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'ErrorBadRequestPage'),
            state: state,
          ),
        ),
        GoRoute(
          path: "401-unauthorized",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'ErrorUnauthorizedPage'),
            state: state,
          ),
        ),
        GoRoute(
          path: "403-forbidden",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'ErrorForbiddenPage'),
            state: state,
          ),
        ),
        GoRoute(
          path: "404-not-found",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'ErrorNotFoundPage'),
            state: state,
          ),
        ),
        GoRoute(
          path: "500-internal-server-error",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'ErrorInternalServerErrorPage'),
            state: state,
          ),
        ),
        GoRoute(
          path: "502-bad-gateway",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'ErrorBadGatewayPage'),
            state: state,
          ),
        ),
        GoRoute(
          path: "503-service-unavailable",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'ErrorServiceUnavailablePage'),
            state: state,
          ),
        ),
        GoRoute(
          path: "504-gateway-timeout",
          pageBuilder: (context, state) => fadePageTransition(
            child: MainScreen(routedPage: 'ErrorGatewayTimeoutPage'),
            state: state,
          ),
        ),
      ],
    ),

    // DEV: Add more page routes as needed.

    // Template module.
    GoRoute(
      path: "/template",
      pageBuilder: (context, state) => fadePageTransition(
        child: MainScreen(routedPage: 'TemplateHomePage'),
        state: state,
        mainModule: 'template',
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
  ],
);
