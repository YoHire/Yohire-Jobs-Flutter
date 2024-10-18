import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/widgets/loader.dart';
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
          return const Loader(loaderType: LoaderType.jobLoader);
        } else if (state is HomeLoaded) {
         return _buildJobs(state: state,context: context);
        } else if (state is HomeError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is HomeEmpty) {
          return const Center(child: Text('No Jobs'));
        } else {
          return const SizedBox();
        }
      }),
    );
  }

  Widget _buildJobs({required HomeLoaded state, required BuildContext context}) {
    return ListView.builder(
      itemCount: state.jobs.length,
      itemBuilder: (context,index){
        return JobCardWidget(context: context, job: state.jobs[index], index: index);
    });
  }
}
