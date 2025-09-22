// version_expansion_tile.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/changelog/widgets/changenote_info.dart';
import 'package:flutter_playground/app/app_helper/app_helper.dart';
import 'package:flutter_playground/app/app_helper/widgets/expansion_tile_compact.dart';
import 'package:flutter_playground/app/app_notifiers/is_mobile_device_notifier/is_mobile_device_notifier.dart';

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
    final String dateReadable = AppHelper.dateToReadableText(date);

    return ValueListenableBuilder(
      valueListenable: isMobileDeviceNotifier,
      builder: (context, value, child) {
        final isMobile = value ? (value as bool? ?? false) : false;
        final double titleHeight = isMobile ? 64.0 : 30.0;
        return ExpansionTileCompact(
          tilePadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
          titleHeight: titleHeight,
          title: isMobile
              // If on mobile, show version and date in one row and the summary below.
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            version,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(dateReadable),
                      ],
                    ),
                    Text(
                      summary,
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              // If on wide screen, show version, summary, and date in one row.
              : Row(
                  children: [
                    Text(version, style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        summary,
                        style: Theme.of(context).textTheme.bodyLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(dateReadable),
                  ],
                ),
          children: [
            ...(versionData['changenotes'] as List<dynamic>).map((data) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap:
                    () {}, // This prevents collapsing when clicked on a child.
                child: ChangenoteInfo(noteData: data as Map<String, dynamic>),
              );
            }),
          ],
        );
      },
    );
  }
}
