import 'package:flutter/material.dart';

class MultiSelectItem {
  final String id;
  final String label;
  bool isSelected;
  bool isEnabled;

  MultiSelectItem({
    required this.id,
    required this.label,
    this.isSelected = false,
    this.isEnabled = true,
  });
}

class MultiSelectCheckbox extends StatefulWidget {
  final List<MultiSelectItem> items;
  final Function(List<String>) onSelectionChanged;
  final String? title;
  final bool showSelectAll;
  final Color? checkboxColor;
  final Color? selectedTextColor;
  final TextStyle? itemTextStyle;
  final EdgeInsetsGeometry contentPadding;
  final bool showDivider;

  const MultiSelectCheckbox({
    super.key,
    required this.items,
    required this.onSelectionChanged,
    this.title,
    this.showSelectAll = true,
    this.checkboxColor,
    this.selectedTextColor,
    this.itemTextStyle,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.showDivider = true,
  });

  @override
  State<MultiSelectCheckbox> createState() => _MultiSelectCheckboxState();
}

class _MultiSelectCheckboxState extends State<MultiSelectCheckbox> {
  @override
  void initState() {
    super.initState();
  }

  void _onItemSelected(bool? isSelected, int index) {
    if (isSelected == null) return;

    setState(() {
      widget.items[index].isSelected = isSelected;
    });

    _notifySelectionChanged();
  }

  void _notifySelectionChanged() {
    final selectedIds = widget.items
        .where((item) => item.isSelected)
        .map((item) => item.id)
        .toList();
    widget.onSelectionChanged(selectedIds);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) ...[
          Padding(
            padding: widget.contentPadding,
            child: Text(
              widget.title!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.items.length,
          separatorBuilder: (context, index) => const SizedBox(),
          itemBuilder: (context, index) {
            final item = widget.items[index];
            return CheckboxListTile(
              enabled: item.isEnabled,
              value: item.isSelected,
              onChanged: (value) => _onItemSelected(value, index),
              title: Text(
                item.label,
                style: widget.itemTextStyle ??
                    Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: item.isSelected
                              ? widget.selectedTextColor
                              : Theme.of(context).textTheme.bodyMedium?.color,
                        ),
              ),
              activeColor: widget.checkboxColor,
              contentPadding: widget.contentPadding,
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        ),
      ],
    );
  }
}
