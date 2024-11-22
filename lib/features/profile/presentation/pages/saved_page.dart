import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/widgets/app_bar.dart';
import 'package:openbn/core/widgets/placeholders.dart';
import 'package:openbn/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:openbn/features/profile/presentation/bloc/profile_bloc.dart';

class SavedJobsPage extends StatelessWidget {
  const SavedJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: customAppBar(context: context, title: 'Saved Jobs'),
          body: state is SavedJobsEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icon/no-data.png'),
                    Text(
                      'Save it for next time',
                      style: textTheme.bodyMedium,
                    ),
                    Text(
                      'save interested jobs for future references',
                      style: textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : state is ProfileLoading
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : state is SavedJobsLoaded
                      ? ListView.separated(
                          itemCount: state.jobs.length,
                          itemBuilder: (context, index) {
                            final data = state.jobs[index];
                            return Dismissible(
                              key: Key(data.id.toString()),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) async {
                                // Show confirmation dialog
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Unsave Job'),
                                      content: const Text('Are you sure you want to unsave this job?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Trigger unsave job event
                                            context
                                                .read<HomeBloc>()
                                                .add(UnsaveJob(jobId: data.id));
                                            context
                                                .read<ProfileBloc>()
                                                .add(GetSavedJobs());
                                            Navigator.of(context).pop(true);
                                          },
                                          child: const Text('Unsave'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  GoRouter.of(context)
                                      .push('/job-details/${data.id}');
                                },
                                child: ListTile(
                                  title: Text(
                                    data.title,
                                    style: textTheme.bodyMedium,
                                  ),
                                  subtitle: Text(
                                    data.location,
                                    style: textTheme.labelMedium,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Unsave Job'),
                                            content: const Text('Are you sure you want to unsave this job?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.of(context).pop(),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  // Trigger unsave job event
                                                  context
                                                      .read<HomeBloc>()
                                                      .add(UnsaveJob(jobId: data.id));
                                                  context
                                                      .read<ProfileBloc>()
                                                      .add(GetSavedJobs());
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Unsave'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.bookmark_add),
                                  ),
                                ),
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
                          isError: true),
        );
      },
    );
  }
}