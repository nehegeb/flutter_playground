// main_screen.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/main_app_bar/main_app_bar.dart';
import 'package:flutter_playground/app/main_module_bar/main_module_bar.dart';

/// The main screen of the app.
class MainScreen extends StatefulWidget {
  final String module;
  const MainScreen({super.key, required this.module});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

/// State for [MainScreen].
class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    appLanguageNotifier.addListener(_refreshUi);
  }

  @override
  void dispose() {
    appLanguageNotifier.removeListener(_refreshUi);
    super.dispose();
  }

  /// Refresh the UI.
  void _refreshUi() {
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
