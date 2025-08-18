// main.dart
//

// TODO: Check for all occurences of a NOTIFIER and maybe replace them.
// TODO: Change localization using a JSON for the languages.
// TODO: Finish the Template README file.
// TODO: Insert notice on HomePage if no modules are permitted for the user.
//       Something like "You currently do not have access to any module. Ask an admin for access."
// TODO: Implement feedback feature.
// TODO: Refactor the AppBar and then close the user menu in set_is_mobile.dart.
// TODO: Web page errors 404 etc.
// TODO: (?) Implement a global error handler for the app.
// TODO: (?) Implement a profile page to change username, password and delete account.
// TODO: Finish the new-module README.
// TODO: Make the template module 'isHidden' in the end.
// TODO: Check all files and only 'show' the necessary import widgets.
// TODO: Make a search for all TODOs and DEBUGs and clean up the code.
// TODO: Add more supported licenses. Apache, GPL, ...
//       https://gist.github.com/nicolasdao/a7adda51f2f185e8d2700e1573d8a633
// TODO: (?) Add "Privacy Policy", "Terms of Service" and "Cookie Notice" for internet usage.
//       Cookie Banner: "This app stores your UI preferences (such as dark or light mode) in your browser to improve your experience. No personal or tracking data is collected."
// ----
// TODO: Add a "Markus Kramer" license notice in the about page.
// TODO: Add a page template in lib/modules/template/pages/.
// TODO: (?) "forgot password" and "change password" features?
// ----
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
import 'package:flutter_playground/app/app_notifiers/is_mobile_device_notifier/is_mobile_device_notifier.dart';

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
        // Check if the device type has changed. Updates while resizing.
        IsMobileDeviceNotifier.checkAndSet(context);

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
