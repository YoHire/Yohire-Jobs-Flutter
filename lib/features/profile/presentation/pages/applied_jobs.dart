import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/widgets/app_bar.dart';
import 'package:openbn/core/widgets/placeholders.dart';
import 'package:openbn/features/profile/presentation/bloc/profile_bloc.dart';

class AppliedJobspage extends StatelessWidget {
  const AppliedJobspage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Applied Jobs'),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return state is ProfileLoading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : state is AppliedJobsEmpty
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icon/no-data.png'),
                          Text(
                            'Oops...',
                            style: textTheme.bodyMedium,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Nothing over here, apply for jobs to start tracking progress..',
                                style: textTheme.labelMedium,
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),
                    )
                  : state is AppliedJobsLoaded
                      ? ListView.separated(
                          itemCount: state.jobs.length,
                          itemBuilder: (context, index) {
                            final data = state.jobs[index];
                            return ListTile(
                              onTap: () {
                                GoRouter.of(context)
                                    .push('/job-details/${data.id}');
                              },
                              title: Text(
                                data.title,
                                style: textTheme.bodyMedium,
                              ),
                              subtitle: Text(
                                data.location,
                                style: textTheme.labelMedium,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                thickness: 0.3,
                              ),
                            );
                          },
                        )
                      : AnimatedPlaceholders(
                          text: 'Something Went Wrong',
                          subText: 'Please Try again later',
                          isError: true);
        },
      ),
    );
  }
}
