import 'package:flutter/material.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/theme_gap.dart';

class EducationContainer extends StatelessWidget {
  const EducationContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Stack(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: colorTheme.surface,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(width: 0.1)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    leftHeadingWithSub(
                        context: context,
                        heading: 'WMO ARTS AND SCIENCE COLLEGE',
                        subHeading: 'Bachelors In Computer Application'),
                        const ThemeGap(10),
                        Text('Completed on : ')
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
