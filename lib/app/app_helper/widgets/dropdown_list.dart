// dropdown_list.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// A customizable dropdown list widget.
///
/// It can display a list of items and allow the user to select one.
/// The list can be a list of strings or other objects like [AppUser].
/// If [filterEnabled] is true, a filter box will be displayed above the list.
///
/// [onChanged] returns the selected list entry upon selection.
class DropdownList<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) itemLabel;
  final void Function(T)? onChanged;
  final T? initialValue;
  final bool filterEnabled;

  const DropdownList({
    super.key,
    required this.items,
    required this.itemLabel,
    this.onChanged,
    this.initialValue,
    this.filterEnabled = true,
  });

  @override
  State<DropdownList<T>> createState() => _DropdownListState<T>();
}

class _DropdownListState<T> extends State<DropdownList<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  late T? _selectedItem;
  late List<T> _filteredItems;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialValue;
    _filteredItems = widget.items;
  }

  void _openDropdown() {
    _searchController.clear();
    _filteredItems = widget.items;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {});
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // The dropdown list overlay itself.
  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final maxEntryAmount = 5;
    final extraWidth = 48.0;

    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Full-screen transparent GestureDetector to catch clicks outside.
            // This is necessary to collapse the [DropdownList] when clicking next to it.
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeDropdown,
                behavior: HitTestBehavior.translucent,
                child: Container(), // transparent
              ),
            ),

            // The dropdown list overlay itself.
            Positioned(
              width: size.width + extraWidth,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(-(extraWidth / 2), size.height + 2),
                child: Material(
                  elevation: 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Filter field pinned at the top, if enabled.
                      if (widget.filterEnabled)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          child: TextField(
                            controller: _searchController,
                            focusNode: _searchFocusNode,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: Localization.getText(
                                'appHelper.dropdownList.filter',
                              ),
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _filteredItems = widget.items
                                    .where(
                                      (item) => widget
                                          .itemLabel(item)
                                          .toLowerCase()
                                          .contains(value.toLowerCase()),
                                    )
                                    .toList();
                              });
                              _overlayEntry?.markNeedsBuild();
                            },
                          ),
                        ),

                      // The entries, scrollable.
                      ConstrainedBox(
                        // Only show a maximum amount of entries at once.
                        constraints: BoxConstraints(
                          maxHeight: maxEntryAmount * 48.0,
                        ),
                        child: _filteredItems.isEmpty
                            ? ListTile(
                                title: Text(
                                  Localization.getText(
                                    'appHelper.dropdownList.noResults',
                                  ),
                                ),
                              )
                            : ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                children: _filteredItems.map((item) {
                                  return ListTile(
                                    title: Text(widget.itemLabel(item)),
                                    onTap: () {
                                      setState(() {
                                        _selectedItem = item;
                                      });
                                      widget.onChanged?.call(item);
                                      _closeDropdown();
                                    },
                                  );
                                }).toList(),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _closeDropdown();
    super.dispose();
  }

  // The actual [DropdownList] widget.
  @override
  Widget build(BuildContext context) {
    // Measure the width of the selected text.
    final text = _selectedItem != null
        ? widget.itemLabel(_selectedItem!)
        : Localization.getText('appHelper.dropdownList.select');
    final textStyle = TextStyle(
      color: _selectedItem != null ? null : Colors.grey.shade600,
    );
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    // Calculate a reasonable width for the [DropdownList].
    final calculatedWidth = textPainter.width + 48;
    const minWidth = 100.0;
    final dropdownWidth = calculatedWidth < minWidth
        ? minWidth
        : calculatedWidth;

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          if (_overlayEntry == null) {
            _openDropdown();
            Future.delayed(const Duration(milliseconds: 100), () {
              _searchFocusNode.requestFocus();
            });
          } else {
            _closeDropdown();
          }
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            width: dropdownWidth,
            padding: const EdgeInsets.only(
              left: 0,
              top: 4,
              right: 0,
              bottom: 4,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: textStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
