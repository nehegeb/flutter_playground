/// loading_overlay.dart
///
/// Provides a reusable, global loading overlay for Flutter apps.
///
/// Features:
/// - Blocks all user interaction with a transparent barrier overlay.
/// - Displays a centered box with a circular progress indicator and customizable message.
/// - Can be shown or hidden from anywhere in the app with a single call.
///
/// Usage:
///   1. Set [LoadingOverlay.navigatorKey] as your app's navigatorKey:
///        MaterialApp(
///          navigatorKey: LoadingOverlay.navigatorKey,
///          ...
///        )
///   2. Show overlay:   LoadingOverlay.initiate('Please wait...');
///      Hide overlay:   LoadingOverlay.dismiss();
///
/// The overlay is automatically removed when [dismiss] is called.
library loading_overlay;

import 'package:flutter/material.dart';

/// A global loading overlay that blocks user interaction and displays
/// a transparent box with a progress indicator and a customizable message.
class LoadingOverlay {
  static final LoadingOverlay _instance = LoadingOverlay._internal();
  factory LoadingOverlay() => _instance;
  LoadingOverlay._internal();

  /// The global navigator key to be set on your MaterialApp.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  OverlayEntry? _overlayEntry;

  /// Shows the loading overlay with the given [message].
  ///
  /// Call this from anywhere.
  static void initiate(String message) {
    _instance._show(message);
  }

  /// Removes the loading overlay if it is showing.
  static void dismiss() {
    _instance._hide();
  }

  void _show(String message) {
    if (_overlayEntry != null) return; // Prevent multiple overlays.
    _overlayEntry = OverlayEntry(
      builder: (context) => _LoadingOverlayWidget(message: message),
    );
    final overlay = navigatorKey.currentState?.overlay;
    if (overlay != null) {
      overlay.insert(_overlayEntry!);
    }
  }

  void _hide() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (_overlayEntry != null && _overlayEntry!.mounted) {
      _overlayEntry!.remove();
    }
    _overlayEntry = null;
  }
}

/// The widget displayed as the loading overlay.
class _LoadingOverlayWidget extends StatelessWidget {
  final String message;
  const _LoadingOverlayWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Block all interaction with a transparent barrier.
        ModalBarrier(color: Colors.black.withAlpha(77), dismissible: false),
        // Centered loading box.
        Center(
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(242),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 16),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 24),
                Text(
                  message,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
