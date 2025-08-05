// expansion_tile_compact.dart
//

import 'package:flutter/material.dart';

/// A more compact ExpansionTile that can be used when nested within another ExpansionTile.
class ExpansionTileCompact extends StatefulWidget {
  final Widget title;
  final List<Widget> children;
  final bool initiallyExpanded;
  final Color? highlightColor;
  final EdgeInsetsGeometry? tilePadding;
  final EdgeInsetsGeometry? childrenPadding;
  final Widget? leading;
  final Widget? trailing;
  final ValueChanged<bool>? onExpansionChanged;
  final double? titleHeight;

  const ExpansionTileCompact({
    super.key,
    required this.title,
    this.children = const <Widget>[],
    this.initiallyExpanded = false,
    this.highlightColor,
    this.tilePadding,
    this.childrenPadding,
    this.leading,
    this.trailing,
    this.onExpansionChanged,
    this.titleHeight,
  });

  @override
  State<ExpansionTileCompact> createState() => _ExpansionTileCompactState();
}

class _ExpansionTileCompactState extends State<ExpansionTileCompact> {
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final double titleHeight = widget.titleHeight ?? 30;

    // Use the highlight color if provided, otherwise use the theme's secondary color with alpha.
    final Color highlight =
        widget.highlightColor ??
        Theme.of(context).colorScheme.secondary.withAlpha(0);

    // Use minimal padding for a more compact look.
    final EdgeInsetsGeometry compactTilePadding =
        widget.tilePadding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 0);
    final EdgeInsetsGeometry compactChildrenPadding =
        widget.childrenPadding ?? EdgeInsets.fromLTRB(0, 0, 0, 4);

    return Container(
      decoration: BoxDecoration(
        color: _expanded ? highlight : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          listTileTheme: ListTileThemeData(
            minVerticalPadding: 0,
            minLeadingWidth: 0,
            dense: false, // Allow custom height.
            horizontalTitleGap: 8,
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        child: ExpansionTile(
          leading: widget.leading,
          trailing: widget.trailing,
          title: Container(
            height: titleHeight,
            alignment: Alignment.centerLeft,
            child: widget.title,
          ),
          initiallyExpanded: widget.initiallyExpanded,
          tilePadding: compactTilePadding,
          childrenPadding: compactChildrenPadding,
          shape: const Border(), // Remove all borders.
          onExpansionChanged: (expanded) {
            setState(() {
              _expanded = expanded;
            });
            if (widget.onExpansionChanged != null) {
              widget.onExpansionChanged!(expanded);
            }
          },
          children: widget.children,
        ),
      ),
    );
  }
}
