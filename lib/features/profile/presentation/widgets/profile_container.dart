import 'package:flutter/material.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';

class ProfileContainerSection extends StatelessWidget {
  final bool isCompleted;
  final String heading;
  final String subHeading;
  final void Function()? onTap;
   const ProfileContainerSection(
      {super.key,
      required this.isCompleted,
      required this.heading,
      required this.subHeading,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Stack(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: colorTheme.surface,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(width: 0.1)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: leftHeadingWithSub(
                          context: context,
                          heading: heading,
                          subHeading: subHeading),
                    )
                  ],
                ),
              ),
            ),
          ),
          isCompleted
              ? Positioned(
                  right: 4.5,
                  bottom: 4.5,
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 30,
                      )))
              : Positioned(
                  right: 4.5,
                  bottom: 4.5,
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.error,
                        color: Color.fromARGB(255, 170, 153, 1),
                        size: 30,
                      )))
        ],
      ),
    );
  }
}
