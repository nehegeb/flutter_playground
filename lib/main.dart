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
  bool _initialized = false; // Track if initialization is complete.
  String _currentLanguage =
      Localization.getCurrentLanguage; // Current app language.

  @override
  void initState() {
    super.initState();
    // Get the language the user uses and initialize localization.
    final initialLanguage = Localization.getUserLanguage();
    _currentLanguage = initialLanguage;
    _initLocalization();
  }

  /// Loads localization files and sets the initial language.
  Future<void> _initLocalization() async {
    await Localization.setCurrentLanguage(_currentLanguage, force: true);
    setState(() {
      _initialized = true;
    });
  }

  /// Called when the user selects a new language from the app bar.
  /// Updates the app's current language and triggers a rebuild.
  void _onLanguageChanged(String selectedLanguage) {
    setState(() {
      _currentLanguage = selectedLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define a seed color for the theme of the app.
    Color seedColor = Colors.purple;
    // Show a white screen with a loading indicator until initialization is complete.
    if (!_initialized) {
      return SplashScreen(seedColor: seedColor);
    }
    // Main app with theme and home screen.
    return MaterialApp(
      // Set the navigator key for the loading overlay.
      // This allows the loading overlay to be shown from anywhere in the app.
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
      ),
      home: MainScreen(onLanguageChanged: _onLanguageChanged),
    );
  }
}

/// The main home screen of the app.
class MainScreen extends StatelessWidget {
  final void Function(String language) onLanguageChanged;
  const MainScreen({super.key, required this.onLanguageChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The upper app bar.
      appBar: MainAppBar(
        title: Localization.getText('appName'),
        onLanguageChanged: onLanguageChanged,
      ),
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
