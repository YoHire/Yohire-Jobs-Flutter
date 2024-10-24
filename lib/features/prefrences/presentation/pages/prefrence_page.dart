import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/widgets/floating_action_button.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/skeleton_loader.dart';
import 'package:openbn/core/widgets/text_field.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/home/presentation/bloc/home_bloc.dart';
import 'package:openbn/features/prefrences/presentation/bloc/prefrence_bloc.dart';
import 'package:openbn/features/prefrences/presentation/bloc/prefrence_event.dart';
import 'package:openbn/features/prefrences/presentation/bloc/prefrence_state.dart';
import 'package:openbn/features/prefrences/presentation/models/job_role_model.dart';
import 'package:openbn/features/prefrences/presentation/widgets/chips.dart';

class PrefrencesScreen extends StatefulWidget {
  const PrefrencesScreen({super.key});

  @override
  PrefrencesScreenState createState() => PrefrencesScreenState();
}

class PrefrencesScreenState extends State<PrefrencesScreen> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const ThemeGap(30),
              leftHeadingWithSub(
                context: context,
                heading: 'Set Your Job Preferences',
                subHeading: 'Get customized jobs',
              ),
              const ThemeGap(20),
              CustomTextField(
                hint: 'Search Job Roles',
                controller: textEditingController,
                prefixIcon: const Icon(Icons.search),
                onChanged: (val) {
                  _searchJobRoles(context, val);
                },
              ),
              const ThemeGap(20),
              Expanded(
                child: BlocConsumer<PrefrenceBloc, PrefrenceState>(
                  listener: (context, state) {
                    if (state is CreatedGuestUser) {
                      context.read<HomeBloc>().add(HomeInitEvent());
                      GoRouter.of(context).go('/getting-jobs-loader/navigation_bar');
                    }
                  },
                  builder: (context, state) {
                    if (state is PrefrenceInitial ||
                        state is PrefrenceLoading) {
                      return _buildSkeleton();
                    } else if (state is PrefrenceLoaded) {
                      return _buildJobRoles(
                          context, state.jobRoles, state.selectedJobRoles);
                    } else if (state is SearchedPrefrences) {
                      return _buildJobRoles(context, state.jobRoles, []);
                    } else if (state is PrefrenceError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<PrefrenceBloc, PrefrenceState>(
        builder: (context, state) {
          return CustomFloatingActionButton(
              loading: state is PrefrenceLoading,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: () {
                _createGuestUser(context);
              },
              backgroundColor: ThemeColors.primaryBlue,
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              isClickable: state is PrefrenceLoaded
                  ? state.selectedJobRoles.isNotEmpty
                  : false);
        },
      ),
    );
  }

  // Function to build job roles
  Widget _buildJobRoles(BuildContext context, List<JobRoleViewModel> jobRoles,
      List<JobRoleViewModel> selectedJobRoles) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          ...selectedJobRoles.map(
            (jobRole) => SelectedChip(
              text: jobRole.name!,
              subText: jobRole.industry!,
              onTap: () => _toggleJobRole(context, jobRole),
            ),
          ),
          ...jobRoles.map(
            (jobRole) => UnselectedChip(
              text: jobRole.name!,
              subText: jobRole.industry!,
              onTap: () => _toggleJobRole(context, jobRole),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeleton() {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: List.generate(15, (index) {
        double width = 100 + (70 * (index % 3));

        return SkeletonLoader(
          isJob: false,
          height: 50,
          width: width,
        );
      }),
    );
  }

  void _toggleJobRole(BuildContext context, JobRoleViewModel? jobRole) {
    context
        .read<PrefrenceBloc>()
        .add(PrefrenceFetch(industry: jobRole!.industry!, jobRole: jobRole));
    textEditingController.clear();
  }

  void _searchJobRoles(BuildContext context, String keyword) {
    context.read<PrefrenceBloc>().add(SearchJobRoles(keyword));
  }

  void _createGuestUser(BuildContext context) {
    context.read<PrefrenceBloc>().add(CreateGuestUser());
  }
}
