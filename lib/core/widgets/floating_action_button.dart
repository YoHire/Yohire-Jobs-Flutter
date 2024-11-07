import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Color backgroundColor;
  final Widget icon;
  final bool loading;
  final void Function()? onPressed;
  final bool isClickable;
  final ShapeBorder? shape;
  final bool? isExtended;

  const CustomFloatingActionButton({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.loading,
    this.onPressed,
    required this.isClickable,
    this.shape,
    this.isExtended,
  });

  @override
  Widget build(BuildContext context) {
    if (isExtended != null && isExtended == true) {
      return FloatingActionButton.extended(
        onPressed: isClickable ? onPressed : () {},
        shape: shape,
        backgroundColor: isClickable || loading ? backgroundColor : Colors.grey,
        label: loading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : icon,
      );
    } else {
      return FloatingActionButton(
        onPressed: isClickable ? onPressed : () {},
        shape: shape,
        backgroundColor: isClickable || loading ? backgroundColor : Colors.grey,
        child: loading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : icon,
      );
    }
  }
}
