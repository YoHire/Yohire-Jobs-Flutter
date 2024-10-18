import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Color backgroundColor;
  final Icon icon;
  final void Function()? onPressed;
  final bool isClickable;
  final ShapeBorder? shape;

  const CustomFloatingActionButton(
      {super.key,
      required this.backgroundColor,
      required this.icon,
      this.onPressed,
      required this.isClickable,
      this.shape});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: isClickable ? onPressed : () {},
      shape: shape,
      backgroundColor: isClickable ? backgroundColor : Colors.grey,
      child: icon,
    );
  }
}
