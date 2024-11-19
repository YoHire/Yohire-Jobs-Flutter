import 'package:flutter/material.dart';
import 'package:openbn/core/theme/app_text_styles.dart';

class ThemedButton extends StatelessWidget {
  final String text;
  final bool loading;
  OutlinedBorder? shape;
  Color? color;
  void Function()? onPressed;
  bool disabled;
  ThemedButton(
      {super.key,
      required this.text,
      required this.loading,
      this.shape,
      this.color,
      this.disabled = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: shape,
        backgroundColor: disabled ? Colors.grey :color?? colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      onPressed: disabled ? () {} : onPressed,
      child: loading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
              ))
          : Text(
              text,
              style: MyTextStyle.chipTextWhite,
            ),
    );
  }
}
