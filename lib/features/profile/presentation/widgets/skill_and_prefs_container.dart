import 'package:flutter/material.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';

class SkillAndPrefsContainer extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final Icon icon;
  final String subTitle;
  final List<String> list;

  const SkillAndPrefsContainer(
      {super.key,
      required this.title,
      required this.icon,
      required this.subTitle,
      this.onTap,
      required this.list});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.43,
        height: 200,
        decoration: BoxDecoration(
          color: colorTheme.surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: colorTheme.onSurface.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  leftHeadingWithSub(
                      context: context, heading: title, subHeading: subTitle),
                ],
              ),
              Positioned(bottom: 0, right: 0, child: icon)
            ],
          ),
        ),
      ),
    );
  }
}
