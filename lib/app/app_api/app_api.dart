// app_api.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_router/app_router.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';
import 'package:flutter_playground/app/app_api/logic/api_service.dart';
import 'package:flutter_playground/app/app_api/logic/api_exception.dart';

/// Utility class for API management.
/// Provides static methods for API requests.
///
/// Static Methods:
/// - [get]: Make a GET request to the given [url].
class AppApi {
  /// Makes a GET request to the given [url].
  Future<dynamic> get(BuildContext context, String url) async {
    dynamic data;
    try {
      data = await ApiService.get(url);
    } on ApiException catch (e) {
      if (e.statusCode == 400) {
        appRouter.go('/400-bad-request');
      } else if (e.statusCode == 401) {
        appRouter.go('/401-unauthorized');
      } else if (e.statusCode == 403) {
        appRouter.go('/403-forbidden');
      } else if (e.statusCode == 404) {
        appRouter.go('/404-not-found');
      } else if (e.statusCode == 500) {
        appRouter.go('/500-internal-server-error');
      } else if (e.statusCode == 502) {
        appRouter.go('/502-bad-gateway');
      } else if (e.statusCode == 503) {
        appRouter.go('/503-service-unavailable');
      } else if (e.statusCode == 504) {
        appRouter.go('/504-gateway-timeout');
      } else {
        // Show the error message in the [AppPopup].
        if (context.mounted) {
          AppPopup.errorMessage(context: context, message: e.message);
        } else {
          throw Exception('AppApi: ${e.message}');
        }
      }
    }
    return data;
  }
}
