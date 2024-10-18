import 'package:flutter/material.dart';
import 'package:openbn/core/widgets/theme_gap.dart';

Widget leftHeadingWithSub(
    {required BuildContext context,required String heading, required String subHeading}) {
      final textTheme = Theme.of(context).textTheme;
  return Column(
    children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
            heading,
            style: textTheme.titleLarge,
            textAlign: TextAlign.left,
          )),
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
            subHeading,
            style: textTheme.labelMedium,
            textAlign: TextAlign.left,
          )),
          const ThemeGap(0)
    ],
  );
}
