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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon centered at the front.
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(_iconForType(type), size: 20)],
          ),
          const SizedBox(width: 16),

          // Texts: title above, description below.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Changenote title.
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 2),

                // Changenote description.
                Text(description, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
