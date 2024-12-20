import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/utils/shared_services/functions/date_services.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/features/home/presentation/pages/widgets/job_highlights.dart';
import 'package:openbn/features/home/presentation/pages/widgets/save_button.dart';
import 'package:recase/recase.dart';

import 'share_button.dart';

class JobCardWidget extends StatelessWidget {
  final BuildContext context;
  final JobEntity job;
  final int index;
  const JobCardWidget(
      {required this.context,
      required this.job,
      required this.index,
      super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          GoRouter.of(context).push('/job-details/${job.id}');
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: colorTheme.surface,
              boxShadow: [
                BoxShadow(
                  color: colorTheme.onSurface.withOpacity(0.25),
                  blurRadius: 4,
                  spreadRadius: 0.5,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 7),
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      job.title.titleCase,
                      style: textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      job.location,
                      style: textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      'Salary Est : ${job.salary} ${job.currency}',
                      style: textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: JobHighlights(
                      job: job,
                      showHeading: false,
                    ),
                  ),
                  const ThemeGap(20),
                  Text(
                    DateServices.dateDifference(
                        today: DateTime.now(),
                        date: DateTime.parse(job.createdAt)
                            .add(const Duration(hours: 5, minutes: 30)),
                        expiryDate: job.expiryDate),
                    style: textTheme.labelSmall,
                  ),
                  const ThemeGap(10),
                ],
              ),
              Positioned(right: 0, top: 0, child: SaveButton(job: job)),
              Positioned(right: 1, top: 35, child: ShareButton(job: job)),
            ]),
          ),
        ),
      ),
    );
  }
}
