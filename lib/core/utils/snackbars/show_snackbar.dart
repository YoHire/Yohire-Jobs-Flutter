import 'package:flutter/material.dart';
import 'package:openbn/core/theme/app_text_styles.dart';

void showSimpleSnackBar(
    {required BuildContext context,
    required String text,
    required Color bgcolor}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: MyTextStyle.chipTextWhite,
      ),
      backgroundColor: bgcolor,
    ));
}
