import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/home/presentation/bloc/job_bloc/job_bloc.dart';

class JobApplyConfirmationBottomSheet extends StatefulWidget {
  const JobApplyConfirmationBottomSheet({super.key});

  @override
  State<JobApplyConfirmationBottomSheet> createState() =>
      _JobApplyConfirmationBottomSheetState();
}

class _JobApplyConfirmationBottomSheetState
    extends State<JobApplyConfirmationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<JobBloc, JobState>(
      listener: (context, state) {
        if (state is JobApplied) {
          Timer(const Duration(seconds: 3), () {
            Navigator.pop(context);
          });
        }
      },
      builder: (context, state) {
        log(state.toString());
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: screenHeight * 0.3,
                width: screenWidth * 0.6,
                child: state is JobApplying
                    ? Lottie.asset('assets/lottie/apply-loading.json',
                        repeat: true, reverse: true)
                    : state is JobApplied
                        ? Lottie.asset(
                            'assets/lottie/success.json',
                            reverse: true,
                          )
                        : Lottie.asset('assets/lottie/apply-job.json',
                            repeat: false),
              ),
              Text(
                state is JobApplying
                    ? 'Securing Your Application !'
                    : state is JobApplied
                        ? 'Application Successful'
                        : 'You are about to apply for this job',
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  width: 350,
                  child: Text(
                    state is JobApplying
                        ? ''
                        : state is JobApplied
                            ? ''
                            : 'All the details you have added in your profile will be sent to the employer',
                    style: textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  )),
              const ThemeGap(10),
              BlocBuilder<JobBloc, JobState>(
                builder: (context, state) {
                  if (state is JobLoaded) {
                    return ThemedButton(
                        loading: state is JobApplying,
                        text: 'Apply',
                        onPressed: () {
                          BlocProvider.of<JobBloc>(context).add(JobApplyEvent(
                              jobId: state.data.id,
                              recruiterId: state.data.recruiterId));
                        });
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const ThemeGap(30)
            ],
          ),
        );
      },
    );
  }
}
