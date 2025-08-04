// flag_menu_item.dart
//

import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';

/// A widget for the [LanguageMenu] that displays a country flag and a label.
class FlagMenuItem extends StatelessWidget {
  final String countryCode;
  final String label;

  const FlagMenuItem({
    required this.countryCode,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CountryFlag.fromCountryCode(
          countryCode,
          shape: RoundedRectangle(4),
          width: 30,
          height: 20,
        ),
        const SizedBox(width: 8),
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
