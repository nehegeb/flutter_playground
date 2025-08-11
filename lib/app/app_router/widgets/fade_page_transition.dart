// fade_page_transition.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/app/app_router/logic/init_page.dart';

/// Helper function for fade transition.
CustomTransitionPage<T> fadePageTransition<T>({
  required Widget child,
  required GoRouterState state,
  String? mainModule,
  String? subModule,
}) {
  // Initialize the page where the [appRouter] navigates to.
  // This is necessary for the [ModuleBar] to highlight the active module buttons.
  initPage(mainModule: mainModule, subModule: subModule);

  // Return the fade transition page.
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
