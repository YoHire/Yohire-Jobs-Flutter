import 'package:flutter/material.dart';

void showCustomBottomSheet({
  required BuildContext context,
  required Widget content,
  bool isScrollable = false,
  bool isScrollControlled = false,
}) async {

  await showModalBottomSheet(
    context: context,
    isScrollControlled: isScrollControlled,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    builder: (context) {
      if (isScrollable) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: content,
            );
          },
        );
      } else {
        return content;
      }
    },
  );
}
