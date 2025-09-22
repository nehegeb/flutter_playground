// app_router_error_builder.dart
//

import 'package:go_router/go_router.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_playground/screens/main_screen.dart';

/// The error page builder for the [appRouter].
Widget appRouterErrorBuilder(BuildContext context, GoRouterState state) {
  final error = state.error;
  final url = state.uri.toString();

  // Map specific error URLs to corresponding error pages.
  if (url.contains('400')) {
    return MainScreen(
      routedPage: 'ErrorBadRequestPage',
      errorMessage: error?.toString(),
    );
  } else if (url.contains('401')) {
    return MainScreen(
      routedPage: 'ErrorUnauthorizedPage',
      errorMessage: error?.toString(),
    );
  } else if (url.contains('403')) {
    return MainScreen(
      routedPage: 'ErrorForbiddenPage',
      errorMessage: error?.toString(),
    );
  } else if (url.contains('404')) {
    return MainScreen(
      routedPage: 'ErrorNotFoundPage',
      errorMessage: error?.toString(),
    );
  } else if (url.contains('500')) {
    return MainScreen(
      routedPage: 'ErrorInternalServerErrorPage',
      errorMessage: error?.toString(),
    );
  } else if (url.contains('502')) {
    return MainScreen(
      routedPage: 'ErrorBadGatewayPage',
      errorMessage: error?.toString(),
    );
  } else if (url.contains('503')) {
    return MainScreen(
      routedPage: 'ErrorServiceUnavailablePage',
      errorMessage: error?.toString(),
    );
  } else if (url.contains('504')) {
    return MainScreen(
      routedPage: 'ErrorGatewayTimeoutPage',
      errorMessage: error?.toString(),
    );
  }

  // Fallback to the '404 - Not Found' page.
  return MainScreen(
    routedPage: 'ErrorNotFoundPage',
    errorMessage: error?.toString(),
  );
}
