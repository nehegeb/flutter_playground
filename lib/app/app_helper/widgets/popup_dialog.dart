// popup_dialog.dart
//
import 'package:flutter/material.dart';

/// A customizable popup dialog widget.
/// It displays the [child] widget in a dialog across the entire screen.
class PopupDialog extends StatelessWidget {
  final Widget child;

  const PopupDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Semi-transparent background.
        GestureDetector(
          onTap: () {}, // Prevents click-through.
          child: Container(
            color: Colors.black54,
            width: double.infinity,
            height: double.infinity,
          ),
        ),

        // [EditDialog] content.
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Material(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              elevation: 8,
              child: Container(
                padding: const EdgeInsets.all(24.0),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
