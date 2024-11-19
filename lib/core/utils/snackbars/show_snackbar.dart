import 'package:flutter/material.dart';
import 'package:openbn/core/theme/app_text_styles.dart';
import 'package:openbn/core/utils/constants/constants.dart';

void showSimpleSnackBar({
  required BuildContext context,
  required String text,
  required SnackBarPosition position,
  required bool isError,
}) {
  final textTheme = Theme.of(context).textTheme;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(0),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: position == SnackBarPosition.BOTTOM
                ? 10
                : position == SnackBarPosition.TOP
                    ? MediaQuery.of(context).size.height - 100
                    : 1,
            top: 10),
        content: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              constraints: BoxConstraints(
                minHeight: 40,
                maxWidth: constraints.maxWidth,
              ),
              color: isError
                  ? const Color.fromARGB(255, 247, 241, 233)
                  : const Color.fromARGB(255, 234, 247, 233),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 10,
                      decoration: BoxDecoration(
                        color: isError ? Colors.red : Colors.green,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          text,
                          style: textTheme.labelMedium,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
}
