/// main.dart
///
/// Entry point and main app widget for the app.
/// Handles localization loading, theme, and the [MainAppBar].
library main;

import 'package:flutter/material.dart';
import 'localization/localization.dart';
import 'helpers/loading_overlay.dart';
import 'app_bar.dart';
import 'module_bar.dart';

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
/// Loads localization files on startup, manages the current language,
/// and rebuilds the app when the language changes.
class _MainAppState extends State<MainApp> {
  bool _isAppInitialized = false; // Track if app initialization is complete.

  @override
  void initState() {
    super.initState();
    // Get the language the user uses and initialize localization.
    _initLocalization();
    // Listen to language changes and rebuild UI when changed.
    currentLanguageNotifier.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    currentLanguageNotifier.removeListener(_onLanguageChanged);
    super.dispose();
  }

  /// Load localization JSON files and set the initial language for the whole app.
  Future<void> _initLocalization() async {
    final initialLanguage = Localization.getUserLanguage();
    await Localization.setCurrentLanguage(initialLanguage, force: true);
    setState(() {
      _isAppInitialized = true;
    });
  }

  /// Called when the language notifier changes.
  void _onLanguageChanged() {
    // Rebuild whole app to update all localization.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Define a seed color for the theme of the app.
    Color seedColor = Colors.teal;
    // Show a white screen with a loading indicator until initialization is complete.
    if (!_isAppInitialized) {
      // The [SplashScreen] doesn't have a theme, therefore the seedColor is passed.
      return SplashScreen(seedColor: seedColor);
    }
    // Main app with theme and home screen.
    return MaterialApp(
      // Set the navigator key for the [LoadingOverlay].
      // This allows the [LoadingOverlay] to be shown from anywhere in the app.
      navigatorKey: LoadingOverlay.navigatorKey,
      // The theme of the app.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Color.alphaBlend(
            Colors.black26,
            ColorScheme.fromSeed(seedColor: seedColor).primary,
          ),
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, color: Colors.black87),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(color: seedColor),
      ),
      home: MainScreen(),
    );
  }
}

/// The main home screen of the app.
class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  // NOTE: The MainScreen cannot be 'const' in order to update localization.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The upper app bar.
      appBar: MainAppBar(title: Localization.getText('appName')),
      // The lower body with a module bar and the module content area.
      body: ModuleBar(),
    );
  }
}

/// A splash screen shown during app initialization.
class SplashScreen extends StatelessWidget {
  final Color seedColor;
  const SplashScreen({super.key, required this.seedColor});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(seedColor),
          ),
        ),
      ),
    );
  }
}
