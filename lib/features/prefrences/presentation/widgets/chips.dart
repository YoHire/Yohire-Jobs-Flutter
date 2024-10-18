import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class UnselectedChip extends StatelessWidget {
  final String text;
  final String subText;
  final void Function()? onTap;

  const UnselectedChip(
      {super.key,
      required this.text,
      required this.subText,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 0.3),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: MyTextStyle.chipTextBlack,
                ),
                Text(
                  subText,
                  style: MyTextStyle.chipSubTextBlack,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectedChip extends StatelessWidget {
  final String text;
  final String subText;
  final void Function()? onTap;

  const SelectedChip(
      {super.key,
      required this.text,
      required this.subText,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.3),
            color: Colors.green),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: MyTextStyle.chipTextWhite,
              ),
              Text(
                subText,
                style: MyTextStyle.chipSubTextWhite,
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}