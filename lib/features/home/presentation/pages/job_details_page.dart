import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/theme/app_text_styles.dart';
import 'package:openbn/core/utils/bottom_sheets/bottomsheet.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/core/widgets/app_bar.dart';
import 'package:openbn/core/widgets/description_heading.dart';
import 'package:openbn/core/widgets/floating_action_button.dart';
import 'package:openbn/core/widgets/loader.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/placeholders.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/features/home/presentation/bloc/job_bloc/job_bloc.dart';
import 'package:openbn/features/home/presentation/pages/widgets/confirmation_bottom_sheet.dart';
import 'package:openbn/features/home/presentation/pages/widgets/incomplete_profile_warning.dart';
import 'package:openbn/features/home/presentation/pages/widgets/job_highlights.dart';
import 'package:openbn/init_dependencies.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  JobEntity? _cachedData; // Caches JobLoaded data

  @override
  Widget build(BuildContext context) {
    final userStorage = serviceLocator<UserStorageService>();

    return Scaffold(
      appBar: customAppBar(context: context),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<JobBloc, JobState>(
          builder: (context, state) {
            if (state is JobLoaded) {
              _cachedData = state.data; // Update cache with new data
              return _buildBody(_cachedData!, context);
            } else if (state is JobLoading) {
              return _buildLoader();
            } else if (state is JobError) {
              return _cachedData != null
                  ? _buildBody(_cachedData!, context) // Fallback to cached data
                  : _buildError(state);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          // Use cached data if available to display the FAB
          if (state is JobLoaded || _cachedData != null) {
            return CustomFloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              isExtended: true,
              onPressed: () {
                if (userStorage.checkCompleted()) {
                  _buildConfirmationSheet(context);
                } else {
                  _buildRequiredProfileWarning(context);
                }
              },
              backgroundColor: ThemeColors.primaryBlue,
              icon: Text(
                'Apply',
                style: MyTextStyle.chipTextWhite,
              ),
              loading: false,
              isClickable: true,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  _buildBody(JobEntity data, BuildContext context) {
    return ListView(
      children: [
        leftHeadingWithSub(
          context: context,
          heading: data.title,
          subHeading: data.location,
        ),
        const ThemeGap(30),
        DescriptionHeadingWidget(
          heading: 'Job Description',
          description: data.description,
        ),
        const ThemeGap(10),
        data.hilights.isNotEmpty ? JobHighlights(job: data) : const SizedBox(),
      ],
    );
  }

  _buildLoader() {
    return const Center(child: Loader(loaderType: LoaderType.normalLoader));
  }

  _buildError(JobError state) {
    return AnimatedPlaceholders(
      text: state.message,
      subText: 'We are trying our best to fix this please try again later',
      isError: true,
    );
  }

  _buildRequiredProfileWarning(BuildContext context) {
    final jobBloc = BlocProvider.of<JobBloc>(context);
    return showCustomBottomSheet(
      context: context,
      content: BlocProvider.value(
        value: jobBloc,
        child: const IncompleteProfileWarning(),
      ),
      isScrollControlled: true,
      isScrollable: true,
    );
  }

  _buildConfirmationSheet(BuildContext context) {
    final jobBloc = BlocProvider.of<JobBloc>(context);
    return showCustomBottomSheet(
      context: context,
      content: BlocProvider.value(
        value: jobBloc,
        child: const JobApplyConfirmationBottomSheet(),
      ),
    );
  }
}
