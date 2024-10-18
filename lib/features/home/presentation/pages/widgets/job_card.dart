import 'package:flutter/material.dart';
import 'package:openbn/core/services/date_services.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/features/home/presentation/pages/widgets/save_button.dart';

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
          // Get.to(() => JobDetailsScreen(
          //       index: index,
          //       clipArtPath: '',
          //       data: job,
          //       isApplied: false,
          //       heroTag: 'Home',
          //     ));
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
                      job.title,
                      style: textTheme.labelLarge,
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
                  Wrap(
                    children: List.generate(job.hilights.length, (index1) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 5, top: 5),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(64, 0, 255, 8)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 5, bottom: 5),
                            child: Text(
                              job.hilights[index1],
                              style: textTheme.labelSmall,
                            ),
                          ),
                        ),
                      );
                    }),
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
              Positioned(
                  right: 1,
                  top: 35,
                  child: ShareButton(job: job)),
            ]),
          ),
        ),
      ),
    );
  }
}
