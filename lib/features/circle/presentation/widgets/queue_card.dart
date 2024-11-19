import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:openbn/core/utils/shared_services/functions/date_services.dart';
import 'package:openbn/core/utils/shared_services/models/country/country_model.dart';
import 'package:openbn/features/circle/domain/entities/queue_entity.dart';

class QueueCard extends StatelessWidget {
  final QueueEntity data;
  const QueueCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          GoRouter.of(context).push('/invitation/${data.id}');
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ], borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DateServices.isNotExpired(
                                data.expiryDate.toIso8601String()) ==
                            true
                        ? Row(
                            children: [
                              Lottie.asset('assets/lottie/live.json',
                                  width: 25, height: 25),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Live',
                                style: textTheme.labelMedium,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Lottie.asset('assets/lottie/expired.json',
                                  width: 20, height: 20),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Expired',
                                style: textTheme.labelMedium,
                              ),
                            ],
                          ),
                    PopupMenuButton(
                        surfaceTintColor: Colors.black,
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {},
                                value: 1,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/icon/edit.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Edit",
                                      style: textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {},
                                value: 1,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.logout,
                                      color: Color.fromARGB(255, 216, 64, 53),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Leave queue",
                                      style: textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () async {},
                                value: 1,
                                enabled: !DateServices.isNotExpired(
                                    data.expiryDate.toIso8601String()),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.refresh,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Restore queue",
                                      style: textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              )
                            ])
                  ],
                ),
              ),
              _buildJobTitle(context, data.jobRole.name!),
              _buildSalary(context,
                  '${data.salaryStart.toInt().toString()} to ${data.salaryEnd.toInt().toString()}'),
              _buildCountries(context, CountryModel.toNameList(data.countries)),
              _buildInfoWidget(data, context)
            ],
          ),
        ),
      ),
    );
  }

  _buildJobTitle(BuildContext context, String jobName) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 100,
        child: Text(
          jobName,
          style: textTheme.titleLarge,
        ),
      ),
    );
  }

  _buildSalary(BuildContext context, String salary) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Text(
        'Salary : $salary',
        style: textTheme.labelMedium,
      ),
    );
  }

  _buildCountries(BuildContext context, List<String> countries) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 2),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.7,
        child: Text(
          countries.length > 3
              ? 'Countries : ${countries.sublist(0, 3).join(', ')}...'
              : 'Countries : ${countries.join(', ')}',
          style: textTheme.labelMedium,
        ),
      ),
    );
  }

  _buildInfoWidget(QueueEntity data, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: PhysicalModel(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 0,
        shadowColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          width: double.infinity,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.invitations.length.toString(),
                    style: textTheme.labelMedium,
                  ),
                  Text(
                    'Invitations',
                    style: textTheme.labelMedium,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.viewCount.toString(),
                    style: textTheme.labelMedium,
                  ),
                  Text(
                    'Reach',
                    style: textTheme.labelMedium,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.clickedCount.toString(),
                    style: textTheme.labelMedium,
                  ),
                  Text(
                    'Impressions',
                    style: textTheme.labelMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
