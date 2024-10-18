import 'package:flutter/material.dart';

class ThemeGap extends StatelessWidget {
  final double height;

  const ThemeGap(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class ThemeDashedLine extends StatelessWidget {
  const ThemeDashedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashCount = (boxWidth / (1.75 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: .1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
              ),
            );
          }),
        );
      },
    );
  }
}
