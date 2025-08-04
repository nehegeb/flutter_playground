// splash_screen.dart
//

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_playground/app/app_theme/app_theme.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// A splash screen shown during app initialization.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, this.isTooSmall = false});
  final bool isTooSmall;

  @override
  Widget build(BuildContext context) {
    // TODO: Make this use the devices brightness, maybe.

    // Use the app theme's progress indicator color.
    final Color indicatorColor =
        AppTheme.appTheme.progressIndicatorTheme.color ?? Colors.black;

    // Show a centered loading indicator.
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double logoHeight = 120;
              final bool hideLogo =
                  constraints.maxHeight < (logoHeight + 50) ||
                  constraints.maxWidth < 200;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!hideLogo)
                    Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/app/images/appLogo.png',
                        height: logoHeight,
                      ),
                    ),
                  if (!hideLogo) const SizedBox(height: 20),
                  // Adjust the loading indicator based on the platform (iOs vs Android/rest).
                  isTooSmall
                      ? Text(
                          Localization.getText('errors.windowTooSmall'),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.red),
                        )
                      : (kIsWeb // Check if running on web.
                            // Web throws errors when using Platform.isIOS without checking kIsWeb before.
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  indicatorColor,
                                ),
                              )
                            : (Platform.isIOS
                                  // If it's iOS, use Cupertino.
                                  ? const CupertinoActivityIndicator()
                                  // Otherwise, use Material.
                                  : CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        indicatorColor,
                                      ),
                                    ))),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
