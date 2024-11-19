import 'package:flutter/material.dart';

class YohireCircleAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const YohireCircleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset(
            'assets/icon/circle2.png',
            width: 120,
            height: 60,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
