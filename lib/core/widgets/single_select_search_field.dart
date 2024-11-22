import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openbn/core/widgets/text_field.dart';
import 'package:openbn/core/widgets/theme_gap.dart';

class SingleSearchSelectField<T> extends StatefulWidget {
  final Future<List<T>> Function(String) fetchData;
  final String Function(T) displayText;
  final String hint;
  final Icon prefixIcon;
  String? Function(String?)? validator;
  final TextEditingController controller;
  final void Function(T)? onSelected;

  SingleSearchSelectField({
    super.key,
    required this.fetchData,
    required this.displayText,
    required this.validator,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    this.onSelected,
  });

  @override
  _SingleSearchSelectFieldState<T> createState() =>
      _SingleSearchSelectFieldState<T>();
}

class _SingleSearchSelectFieldState<T>
    extends State<SingleSearchSelectField<T>> {
  List<T> _suggestions = [];
  bool _isLoading = false;
  bool _showDropdown = false;

  void _onChanged(String value) async {
    if (value.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _showDropdown = true;
      });

      final data = await widget.fetchData(value);

      setState(() {
        _suggestions = data;
        _isLoading = false;
      });
    } else {
      setState(() {
        _suggestions = [];
        _showDropdown = false;
      });
    }
  }

  void _selectItem(T item) {
    widget.controller.text = widget.displayText(item);
    // Call the onSelected callback if it exists
    widget.onSelected?.call(item);
    setState(() {
      _showDropdown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          isDebouncer: true,
          debounceDuration: const Duration(milliseconds: 800),
          validator: widget.validator,
          hint: widget.hint,
          controller: widget.controller,
          onChanged: _onChanged,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 0.4)),
          prefixIcon: widget.prefixIcon,
          suffixIcon: _isLoading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CupertinoActivityIndicator(),
                )
              : const SizedBox(),
        ),
        if (_showDropdown && _suggestions.isNotEmpty) ...[
          const ThemeGap(0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            constraints: const BoxConstraints(maxHeight: 200),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final item = _suggestions[index];
                  return InkWell(
                    onTap: () => _selectItem(item),
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
        ],
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
