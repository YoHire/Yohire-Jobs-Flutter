import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  Widget suffixIcon;
  Widget prefixIcon;
  void Function(String)? onChanged;
  String? Function(String?)? validator;

  CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.suffixIcon = const SizedBox(),
    this.prefixIcon = const SizedBox(),
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          label: Text(
            hint,
            style: textTheme.labelMedium,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon),
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      validator: validator,
    );
  }
}

class NoBorderTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  Widget suffixIcon;
  Widget prefixIcon;
  void Function(String)? onChanged;
  String? Function(String?)? validator;

  NoBorderTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.suffixIcon = const SizedBox(),
    this.prefixIcon = const SizedBox(),
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    return TextFormField(
      cursorHeight: 20,
      cursorColor: colorTheme.onSurface,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 17),
          hintText: ' $hint',
          hintStyle: textTheme.labelLarge,
          enabledBorder: InputBorder.none,
          focusedBorder:InputBorder.none,
          disabledBorder: InputBorder.none,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon),
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      validator: validator,
    );
  }
}
