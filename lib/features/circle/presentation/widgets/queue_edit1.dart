import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/job_roles/jobrole_service.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/single_select_search_field.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/circle/presentation/bloc/queue_bloc/queue_bloc.dart';

class QueueEdit1 extends StatefulWidget {
  const QueueEdit1({super.key});

  @override
  State<QueueEdit1> createState() => _QueueEdit1State();
}

class _QueueEdit1State extends State<QueueEdit1> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ThemeGap(10),
              leftHeadingWithSub(
                context: context,
                heading: 'Set Interested Job Role',
                subHeading:
                    'The employer can find your profile using the role you selected',
              ),
              const ThemeGap(50),
              BlocBuilder<QueueBloc, QueueState>(
                builder: (context, state) {
                  return RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: textTheme.bodyLarge,
                      children: [
                        const TextSpan(
                          text: '''I'm looking for the job role of ''',
                        ),
                        TextSpan(
                          text: context.read<QueueBloc>().jobRole == null
                              ? '___________'
                              : context.read<QueueBloc>().jobRole!.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorTheme.onSurface,
                          ),
                        ),
                        TextSpan(
                          text: ' to explore my professional career',
                          style: textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const ThemeGap(40),
              SingleSearchSelectField(
                fetchData: JobroleService().searchJobRoles,
                displayText: (job) {
                  context.read<QueueBloc>().add(SelectJobRole(jobRole: job));
                  return job.name!;
                },
                validator: (cal) {
                  return null;
                },
                hint: 'Search Job Role',
                prefixIcon: const Icon(Icons.work),
                controller: TextEditingController(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (context.read<QueueBloc>().jobRole == null) {
            showSimpleSnackBar(
                context: context,
                text: 'You must select a job role',
                position: SnackBarPosition.BOTTOM,
                isError: true);
          } else {
            context.read<QueueBloc>().pageController.nextPage(
                duration: const Duration(seconds: 1), curve: Curves.decelerate);
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
      ),
    );
  }
}
