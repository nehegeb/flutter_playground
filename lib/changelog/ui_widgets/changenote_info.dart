// changenote_info.dart
//

import 'package:flutter/material.dart';

/// A widget that displays a changenote with an icon, title, and description.
class ChangenoteInfo extends StatelessWidget {
  final Map<String, dynamic> noteData;

  const ChangenoteInfo({super.key, required this.noteData});

  IconData _iconForType(String type) {
    switch (type) {
      case 'added':
        return Icons.add;
      case 'bugfix':
        return Icons.bug_report;
      case 'removed':
        return Icons.remove;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String type = noteData['type'] ?? '';
    final String title = noteData['title'] ?? '';
    final String description = noteData['description'] ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon centered at the front.
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(_iconForType(type), size: 24)],
          ),
          const SizedBox(width: 20),

          // Texts: title above, description below.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title text with bold font weight.
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),

                // Description text with smaller font size.
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
