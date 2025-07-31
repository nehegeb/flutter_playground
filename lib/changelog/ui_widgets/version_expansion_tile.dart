// version_expansion_tile.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/changelog/ui_widgets/changenote_info.dart';
import 'package:flutter_playground/misc/logic_widgets/helper_methods.dart';

/// An expansion tile for a changelog entry with version, title, and date.
class VersionExpansionTile extends StatelessWidget {
  const VersionExpansionTile({
    super.key,
    required this.version,
    required this.versionData,
  });
  final String version;
  final Map<String, dynamic> versionData;

  @override
  Widget build(BuildContext context) {
    final String summary = versionData['summary'] ?? '';
    final String date = versionData['date'] ?? '';
    final String dateReadable = Helpers.dateToReadableText(date);

    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            // Version number
            Text(version, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 12),
            // Summary
            Expanded(
              child: Text(
                summary,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            // Date
            Text(
              dateReadable,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
      children: [
        ...versionData['changenotes'].entries.map((entry) {
          final Map<String, dynamic> data = entry.value;
          // Generate a ChangenoteInfo for each changenote entry.
          return ChangenoteInfo(noteData: data);
        }),
      ],
    );
  }
}
