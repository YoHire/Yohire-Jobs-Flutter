import 'package:flutter/material.dart';
import 'package:openbn/core/theme/app_text_styles.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';

class JobSalaryWidget extends StatelessWidget {
  final JobEntity job;
  const JobSalaryWidget({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Est Salary',
          style: MyTextStyle.headLineLargeBlue,
        ),
        Text(
          '${job.salary} ${job.currency}',
          style: textTheme.labelLarge,
        ),
      ],
    );
  }
}
