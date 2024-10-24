import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Color backgroundColor;
  final Icon icon;
  final bool loading;
  final void Function()? onPressed;
  final bool isClickable;
  final ShapeBorder? shape;

  const CustomFloatingActionButton(
      {super.key,
      required this.backgroundColor,
      required this.icon,
      required this.loading,
      this.onPressed,
      required this.isClickable,
      this.shape});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: isClickable ? onPressed : () {},
      shape: shape,
      backgroundColor: isClickable||loading ? backgroundColor : Colors.grey,
      child: loading?const CircularProgressIndicator(color: Colors.white,):icon,
    );
  }
}
