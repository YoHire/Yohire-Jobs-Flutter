import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/widgets/placeholders.dart';
import 'package:openbn/core/widgets/skeleton_loader.dart';
import 'package:openbn/features/home/presentation/bloc/home_bloc.dart';
import 'package:openbn/features/home/presentation/pages/widgets/home_app_bar.dart';
import 'package:openbn/features/home/presentation/pages/widgets/job_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeLoading) {
          return _buildSkeleton();
        } else if (state is HomeLoaded) {
          return _buildJobs(state: state, context: context);
        } else if (state is HomeError) {
          return  AnimatedPlaceholders(text: state.message,isError: true,subText: 'We are trying our best to fix this soon, please try again after sometime.',);
        } else if (state is HomeEmpty) {
          return  AnimatedPlaceholders(text: state.message,isError: false,subText: 'Try changing your job prefrences or search keywords.',);
        } else {
          return const SizedBox();
        }
      }),
    );
  }

  Widget _buildJobs(
      {required HomeLoaded state, required BuildContext context}) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
        context.read<HomeBloc>().add(HomeInitEvent());
      },
      child: ListView.builder(
          itemCount: state.jobs.length,
          itemBuilder: (context, index) {
            return JobCardWidget(
                context: context, job: state.jobs[index], index: index);
          }),
    );
  }

  Widget _buildSkeleton() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          double height = 100 + (40 * (index % 2));

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SkeletonLoader(
              isJob: true,
              height: height,
              width: 0,
            ),
          );
        });
  }
}
