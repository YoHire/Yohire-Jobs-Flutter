import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openbn/core/widgets/text_field.dart';
import 'package:openbn/core/widgets/theme_gap.dart';

class SearchSelectField<T> extends StatefulWidget {
  final Future<List<T>> Function(String) fetchData;
  final String Function(T) displayText;
  final String hint;
  final List<T> selectedData;
  final Icon prefixIcon;
  final void Function(List<T>) onSelectionChanged;

  const SearchSelectField({
    super.key,
    required this.fetchData,
    required this.displayText,
    required this.hint,
    required this.prefixIcon,
    required this.selectedData,
    required this.onSelectionChanged,
  });

  @override
  _SearchSelectFieldState<T> createState() => _SearchSelectFieldState<T>();
}

class _SearchSelectFieldState<T> extends State<SearchSelectField<T>> {
  final TextEditingController _controller = TextEditingController();
  List<T> _suggestions = [];

  bool _isLoading = false;

  void _onChanged(String value) async {
    if (value.isNotEmpty) {
      setState(() => _isLoading = true);

      final data = await widget.fetchData(value);

      setState(() {
        _suggestions = data;
        _isLoading = false;
      });
    } else {
      setState(() => _suggestions = []);
    }
  }

  void _addSelection(T item) {
    if (!widget.selectedData.contains(item)) {
      setState(() {
        widget.selectedData.add(item);
        _controller.clear();
        _suggestions = [];
        removeDuplicates(widget.selectedData);
      });
      widget.onSelectionChanged(widget.selectedData);
    }
  }

  void _removeSelection(T item) {
    setState(() {
      widget.selectedData.remove(item);
    });
    widget.onSelectionChanged(widget.selectedData);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          hint: widget.hint,
          controller: _controller,
          onChanged: _onChanged,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(width: 0.4)),
          prefixIcon: widget.prefixIcon,
          suffixIcon: _isLoading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CupertinoActivityIndicator(),
                )
              : const SizedBox(),
        ),

        const ThemeGap(0),

        // Suggestion List
        if (_suggestions.isNotEmpty)
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
            constraints: const BoxConstraints(maxHeight: 200),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final item = _suggestions[index];
                  return InkWell(
                    splashColor: Colors.white,
                    focusColor: Colors.white,
                    highlightColor: Colors.white,
                    hoverColor: Colors.white,
                    onTap: () => _addSelection(item),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.search,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.displayText(item),
                            style: textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

        const SizedBox(height: 10),

        // Selected Chips
        Wrap(
          spacing: 8.0,
          children: widget.selectedData.map((item) {
            return Chip(
              side: const BorderSide(width: 0.2),
              label: Text(
                widget.displayText(item),
                style: textTheme.labelMedium,
              ),
              deleteIcon: const Icon(Icons.close, size: 13),
              onDeleted: () => _removeSelection(item),
            );
          }).toList(),
        ),
      ],
    );
  }

  void removeDuplicates(List<dynamic> data) {
    final Set<String> uniqueIds = {};
    for (int i = data.length - 1; i >= 0; i--) {
      final id = data[i].id;
      if (!uniqueIds.add(id)) {
        data.removeAt(i);
      }
    }
  }
}
