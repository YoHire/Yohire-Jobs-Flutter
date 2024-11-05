import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final T? value;
  final String? Function(T?)? validator;
  final String hint;
  const CustomDropdown(
      {super.key,
      required this.validator,
      required this.items,
      required this.onChanged,
      this.value,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DropdownButtonFormField<T>(
      validator: validator,
        hint: Text(
          hint,
          style: textTheme.labelMedium,
        ),
        value: value,
        items: items,
        decoration: const InputDecoration(
          disabledBorder:
              OutlineInputBorder(borderSide: BorderSide(width: 0.0)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.0)),
          border: OutlineInputBorder(borderSide: BorderSide(width: 0.0)),
        ),
        style: textTheme.bodyMedium,
        onChanged: onChanged);
  }
}
