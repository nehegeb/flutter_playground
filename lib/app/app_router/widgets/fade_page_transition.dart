// fade_page_transition.dart
//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Helper function for fade transition.
CustomTransitionPage<T> fadePageTransition<T>({
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
