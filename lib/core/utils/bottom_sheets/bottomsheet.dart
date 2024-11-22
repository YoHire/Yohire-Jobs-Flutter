import 'package:flutter/material.dart';
import 'dart:async';

void showCustomBottomSheet({
  required BuildContext context,
  required Widget content,
  double? heightFactor,
  bool isScrollable = false,
  bool isScrollControlled = false,
}) async {
  final screenHeight = MediaQuery.of(context).size.height;
  final ScrollController scrollController = ScrollController();
  Timer? scrollbarTimer;
  ValueNotifier<bool> showScrollbar = ValueNotifier(true);

  void scheduleScrollbarHide() {
    scrollbarTimer?.cancel();
    scrollbarTimer = Timer(const Duration(seconds: 2), () {
      showScrollbar.value = false;
    });
  }

  scheduleScrollbarHide();

  void toggleScrollbarVisibility() {
    showScrollbar.value = true;
    scheduleScrollbarHide();
  }

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: screenHeight * 0.9,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    builder: (context) {
      // Get the keyboard height
      final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
      final availableHeight = screenHeight - keyboardHeight;

      return AnimatedPadding(
        padding: EdgeInsets.only(bottom: keyboardHeight),
        duration: const Duration(milliseconds: 100),
        child: SizedBox(
          height: availableHeight * (heightFactor ?? 0.75),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollStartNotification ||
                        scrollNotification is ScrollUpdateNotification) {
                      toggleScrollbarVisibility();
                    }
                    return false;
                  },
                  child: ValueListenableBuilder<bool>(
                    valueListenable: showScrollbar,
                    builder: (context, isVisible, child) {
                      return Scrollbar(
                        controller: scrollController,
                        thumbVisibility: isVisible,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: content,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  scrollController.dispose();
  showScrollbar.dispose();
  scrollbarTimer?.cancel();
}
