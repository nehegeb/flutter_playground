// version_expansion_tile.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/changelog/ui_widgets/changenote_info.dart';
import 'package:flutter_playground/misc/logic_widgets/helper_methods.dart';
import 'package:flutter_playground/misc/ui_widgets/expansion_tile_compact.dart';

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

    return ExpansionTileCompact(
      title: SizedBox(
        child: Row(
          children: [
            // Version number.
            Text(version, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(width: 16),

            // Summary.
            Expanded(
              child: Text(
                summary,
                style: Theme.of(context).textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 16),

            // Date.
            Text(dateReadable),
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
