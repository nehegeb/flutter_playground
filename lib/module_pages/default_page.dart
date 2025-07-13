/// default_page.dart
///
library default_page;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_playground/localization/localization.dart';

/// The unauthorized page.
class DefaultPage extends StatelessWidget {
  const DefaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // About button at bottom right
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            mini: true,
            tooltip: Localization.getText('aboutPage.title'),
            onPressed: () {
              context.go('/about');
            },
            child: const Icon(Icons.info_outline, size: 20),
          ),
        ),
      ],
    );
  }
}
