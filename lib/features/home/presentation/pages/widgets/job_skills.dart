import 'package:flutter/material.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';

class JobSkills extends StatefulWidget {
  final JobEntity job;
  final bool? showHeading;
  const JobSkills({super.key, required this.job, this.showHeading = true});

  @override
  State<JobSkills> createState() => _JobSkillsState();
}

class _JobSkillsState extends State<JobSkills>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.showHeading!
            ? leftHeadingWithSub(
                context: context,
                heading: 'Required Skills',
              )
            : const SizedBox(),
        Wrap(
          children: List.generate(widget.job.skills.length, (index) {
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 600 + index * 100),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, (1 - value) * 10),
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 5, top: 5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(64, 162, 165, 162),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Text(
                      widget.job.skills[index].name,
                      style: textTheme.labelSmall,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}