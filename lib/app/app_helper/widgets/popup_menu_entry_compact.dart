// popup_menu_entry_compact.dart
//
// Provides a collection of custom UI widgets for the app.

import 'package:flutter/material.dart';

/// A compact popup menu entry that displays a value and a child widget.
class PopupMenuEntryCompact extends PopupMenuEntry<String> {
  final String value;
  final bool selected;
  final Widget child;

  const PopupMenuEntryCompact({
    super.key,
    required this.value,
    required this.selected,
    required this.child,
  });

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(String? value) => value == this.value;

  @override
  State<PopupMenuEntryCompact> createState() => _PopupMenuEntryCompactState();
}

class _PopupMenuEntryCompactState extends State<PopupMenuEntryCompact> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context, widget.value),
      child: Container(
        color: widget.selected
            ? Theme.of(context).primaryColor.withAlpha(12)
            : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: widget.child,
      ),
    );
  }
}
