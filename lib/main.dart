// main.dart
//

// TODO: Implement basic submodulebar structure. Open module home page first.
// TODO: Implement basic roles and module permissions feature.
// TODO: Implement feedback feature.
// TODO: Add custom icons for the modules. Add in assets/modules/<module>/images/moduleIcon.png.
// -----
// TODO: Feedback widget!
// TODO: home_widget for mobile widgets?!
// TODO: Widgets to keep in mind: CircleAvatar, SnackBar, SelectableText

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_playground/screens/main_screen.dart';
import 'package:flutter_playground/screens/splash_screen.dart';
import 'package:flutter_playground/app/misc/logic/init_app_settings.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';
import 'package:flutter_playground/app/app_router/app_router.dart';
import 'package:flutter_playground/app/app_notifiers/user_device_notifier.dart';

/// The main function that starts the Flutter app.
void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Needed for SystemChrome.
  // Set the system UI overlay style for the app.
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  runApp(const MainApp());
}

/// The root widget of the app.
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

/// State for [MainApp].
///
/// A [SplashScreen] is shown while the app is initializing.
/// After that, the [MainScreen] provided by the [appRouter] is shown.
class _MainAppState extends State<MainApp> {
  bool _isAppInitialized = false; // Track if app initialization is complete.
  bool _isMobilePrevious = false;

  @override
  void initState() {
    super.initState();
    // Initialize the app settings.
    _initAppSettings();
    // Listen for app theme changes to rebuild the app when it changes.
    appThemeNotifier.addListener(_refreshUi);
  }

  @override
  void dispose() {
    appThemeNotifier.removeListener(_refreshUi);
    super.dispose();
  }

  /// Refresh the UI.
  void _refreshUi() {
    setState(() {});
  }

  /// Initializes the app settings from local cache.
  Future<void> _initAppSettings() async {
    await initAppSettings();
    // Initialization is complete. Splash screen can now be hidden.
    setState(() {
      _isAppInitialized = true;
    });
  }

  /// The [MainApp] using the app theme and displaying a screen provided by the [appRouter].
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.appTheme,
      routerConfig: appRouter,
      builder: (context, child) {
        // Check if the device type has changed since the last build.
        // This is necessary to update the [UserDeviceNotifier] if the window size changes.
        final bool isMobile = UserDeviceNotifier.isMobile;
        if (_isMobilePrevious != isMobile) {
          if (MediaQuery.of(context).size.width < 600) {
            _isMobilePrevious = true;
            UserDeviceNotifier.setMobile(true);
          } else {
            _isMobilePrevious = false;
            UserDeviceNotifier.setMobile(false);
          }
        }

        // If the app is not initialized, show the [SplashScreen].
        if (!_isAppInitialized) {
          return SplashScreen();
        }

        // Show [SplashScreen] if window is too small.
        // Otherwise, show [MainScreen] provided by the [appRouter].
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 400 || constraints.maxHeight < 300) {
              return SplashScreen(isTooSmall: true);
            }
            // If the app is initialized, show whatever the [appRouter] provides.
            return child!;
          },
        );
      },
    );
  }
}
