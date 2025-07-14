/// main.dart
///
/// Entry point and main app widget for the app.
/// Handles localization loading, theme, and the [MainAppBar].
library main;

// TODO: Implement dark theme support and add it to the AppBar.
// TODO: Refactor all files to remove library comments at the top.
// TODO: Implement persistent storage for notifiers using shared_preferences.
// TODO: Feedback widget!
// TODO: home_widget for mobile widgets?!
// TODO: Widgets to keep in mind: CircleAvatar, SnackBar, SelectableText

import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'helpers/app_theme.dart';
import 'helpers/app_router.dart';
import 'helpers/global_notifiers.dart';
import 'localization/localization.dart';
import 'main_app_bar.dart';
import 'main_module_bar.dart';

/// The main function that starts the Flutter app.
void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Needed for SystemChrome.
  // Set the system UI overlay style for the app.
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
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
/// Defines the app theme and handles initial app loading.
/// Loads localization files on startup and sets initial language.
class _MainAppState extends State<MainApp> {
  bool _isAppInitialized = false; // Track if app initialization is complete.

  @override
  void initState() {
    super.initState();
    // Check the device type and update the notifier.
    _checkDeviceType();
    // Get the language the user uses and initialize localization.
    _initLocalization();
  }

  /// Load localization JSON files and set the initial language for the whole app.
  Future<void> _initLocalization() async {
    final initialLanguage = Localization.getUserLanguage();
    await Localization.setCurrentLanguage(initialLanguage, force: true);
    setState(() {
      _isAppInitialized = true;
    });
  }

  /// Check the device type and update the current device notifier.
  void _checkDeviceType() {
    final isMobile = Platform.isIOS || Platform.isAndroid;
    // 600 is a common breakpoint for mobile devices.
    //final isMobile = MediaQuery.of(context).size.width < 600;
    GlobalNotifiers.setMobile(isMobile);
  }

  @override
  Widget build(BuildContext context) {
    // Main app with theme and home screen.
    return MaterialApp.router(
      theme: appTheme,
      routerConfig: appRouter,
      builder: (context, child) {
        // If the app is not initialized, show the splash screen.
        if (!_isAppInitialized) {
          return SplashScreen();
        }
        // Show SplashScreen if window is too small.
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 400 || constraints.maxHeight < 300) {
              return SplashScreen(isTooSmall: true);
            }
            return child!;
          },
        );
      },
    );
  }
}

/// The main home screen of the app.
class MainScreen extends StatefulWidget {
  final String module;
  const MainScreen({super.key, required this.module});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

/// State for [MainScreen].
///
/// Manages the current language and rebuilds the app when the language changes.
class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    currentLanguageNotifier.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    currentLanguageNotifier.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The upper app bar.
      appBar: MainAppBar(),
      // The lower part with a module bar and the module content area.
      body: MainModuleBar(module: widget.module),
    );
  }
}

/// A splash screen shown during app initialization.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, this.isTooSmall = false});
  final bool isTooSmall;

  @override
  Widget build(BuildContext context) {
    // Use the app theme's progress indicator color.
    final Color indicatorColor =
        appTheme.progressIndicatorTheme.color ?? Colors.black;

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
                        'lib/img/appLogo.png',
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
                      : (Platform.isIOS
                            ? const CupertinoActivityIndicator()
                            : CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  indicatorColor,
                                ),
                              )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
