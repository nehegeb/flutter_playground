/// main.dart
///
/// Entry point and main app widget for the app.
/// Handles localization loading, theme, and the [MainAppBar].
library main;

// TODO: Implement dark theme support and add it to the AppBar.
// TODO: Refactor all files to remove library comments at the top.
// TODO: Implement persistent storage for notifiers using shared_preferences.

import 'package:flutter/material.dart';
import 'helpers/app_theme.dart';
import 'helpers/app_router.dart';
import 'localization/localization.dart';
import 'main_app_bar.dart';
import 'main_module_bar.dart';

/// The main function that starts the Flutter app.
void main() {
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
        // Otherwise, return the main content.
        return child!;
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
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the app theme's progress indicator color.
    final Color indicatorColor =
        appTheme.progressIndicatorTheme.color ?? Colors.teal;

    // Show a centered loading indicator.
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
          ),
        ),
      ),
    );
  }
}
