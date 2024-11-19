import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

// Core/Utils imports
import 'package:openbn/core/theme/app_text_styles.dart';
import 'package:openbn/core/utils/bottom_sheets/bottomsheet.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/functions/launch_url.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';

// Widget imports
import 'package:openbn/core/widgets/app_bar.dart';
import 'package:openbn/core/widgets/description_heading.dart';
import 'package:openbn/core/widgets/floating_action_button.dart';
import 'package:openbn/core/widgets/loader.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/pages/employer_info_page.dart';
import 'package:openbn/core/widgets/placeholders.dart';
import 'package:openbn/core/widgets/theme_gap.dart';

// Feature-specific imports
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/features/home/presentation/bloc/job_bloc/job_bloc.dart';
import 'package:openbn/features/home/presentation/pages/widgets/confirmation_bottom_sheet.dart';
import 'package:openbn/features/home/presentation/pages/widgets/incomplete_profile_warning.dart';
import 'package:openbn/features/home/presentation/pages/widgets/job_highlights.dart';
import 'package:openbn/features/home/presentation/pages/widgets/job_salary_widget.dart';
import 'package:openbn/features/home/presentation/pages/widgets/job_skills.dart';

// Service locator
import 'package:openbn/init_dependencies.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  // Constants
  static const double _padding = 15.0;
  static const double _borderRadius = 10.0;

  // State variables
  JobEntity? _cachedData;
  late final UserStorageService _userStorage;

  @override
  void initState() {
    super.initState();
    _userStorage = serviceLocator<UserStorageService>();
  }

  @override
  Widget build(BuildContext context) {
    final storage = serviceLocator<GetStorage>();
    return Scaffold(
      appBar: customAppBar(context: context),
      body: _buildMainContent(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: storage.read('isLogged') == null
          ? const SizedBox()
          : _buildFloatingActionButton(),
    );
  }

  // Main content builders
  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.all(_padding),
      child: BlocBuilder<JobBloc, JobState>(
        builder: _handleJobStateBuilder,
      ),
    );
  }

  Widget _handleJobStateBuilder(BuildContext context, JobState state) {
    if (state is JobLoaded) {
      _cachedData = state.data;
      return _buildJobDetails(_cachedData!);
    }

    if (_cachedData != null) {
      return _buildJobDetails(_cachedData!);
    }

    if (state is JobLoading) {
      return _buildLoader();
    }

    if (state is JobError) {
      return _cachedData != null
          ? _buildJobDetails(_cachedData!)
          : _buildError(state);
    }

    return const SizedBox.shrink();
  }

  Widget _buildJobDetails(JobEntity data) {
    return ListView(
      children: [
        _buildHeader(data),
        const ThemeGap(30),
        _buildDescription(data),
        const ThemeGap(10),
        _buildHighlights(data),
        const ThemeGap(20),
        _buildSkills(data),
        const ThemeGap(20),
        JobSalaryWidget(job: data),
        const ThemeGap(20),
        _buildInterviewDate(data),
        const ThemeGap(20),
        _recruiterInfo(data),
        const ThemeGap(20),
        _fakeInfoWidget(),
        const ThemeGap(100),
      ],
    );
  }

  // Section builders
  Widget _buildHeader(JobEntity data) {
    return leftHeadingWithSub(
      context: context,
      heading: data.title,
      subHeading: data.location,
    );
  }

  Widget _buildDescription(JobEntity data) {
    return DescriptionHeadingWidget(
      heading: 'Description',
      description: data.description,
    );
  }

  Widget _buildHighlights(JobEntity data) {
    return data.hilights.isNotEmpty
        ? JobHighlights(job: data)
        : const SizedBox();
  }

  Widget _buildSkills(JobEntity data) {
    return data.skills.isNotEmpty ? JobSkills(job: data) : const SizedBox();
  }

  Widget _buildInterviewDate(JobEntity data) {
    return data.interviewDate.isNotEmpty
        ? leftHeadingWithSub(
            context: context,
            heading: 'Interview Date',
            subHeading: data.interviewDate,
          )
        : const SizedBox();
  }

  Widget _recruiterInfo(JobEntity data) {
    final textTheme = Theme.of(context).textTheme;
    return data.recruiter != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Posted By', style: textTheme.bodyLarge),
              const SizedBox(height: 10),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) =>
                          EmployerInfoPage(data: data.recruiter!)));
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(data.recruiter!.image),
                  backgroundColor: Colors.white,
                ),
                title: Text(
                  data.recruiter!.name,
                  style: textTheme.labelLarge,
                ),
                subtitle: Text(
                  'Tap for More Info',
                  style: textTheme.labelMedium,
                ),
              ),
            ],
          )
        : const SizedBox();
  }

  Widget _fakeInfoWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(
          color: Colors.grey,
          width: 0.4,
        ),
      ),
      child: _buildSpamWarning(),
    );
  }

  _buildSpamWarning() {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: RichText(
        text: TextSpan(
          style: textTheme.labelMedium,
          children: [
            const TextSpan(
              text:
                  'If this organisation claims to be a “Overseas Recruitment Agency“  from India, verify their authenticity from this website: ',
            ),
            TextSpan(
              text: 'https://www.mea.gov.in/Images/attach/03-List-4-2024.pdf',
              style: textTheme.labelMedium!.copyWith(
                decoration: TextDecoration.underline,
                color: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchURL(
                      'https://www.mea.gov.in/Images/attach/03-List-4-2024.pdf');
                },
            ),
            const TextSpan(
              text:
                  ' And make sure they possess the demand letter and POE certificate for this job before attending the interview.',
            ),
          ],
        ),
      ),
    );
  }

  // Floating Action Button
  Widget _buildFloatingActionButton() {
    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        if (state is JobApplied || state is JobLoaded) {
          if (state is JobLoaded && _cachedData!.isApplied == true) {
            return _buildAppliedButton();
          } else if (state is JobApplied) {
            return _buildAppliedButton();
          } else {
            return _buildApplyButton(context);
          }
        }

        if (state is JobLoaded || _cachedData != null) {
          return _buildApplyButton(context);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildAppliedButton() {
    return CustomFloatingActionButton(
      isExtended: true,
      backgroundColor: ThemeColors.primaryBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      icon: Text(
        'Applied',
        style: MyTextStyle.chipTextWhite,
      ),
      loading: false,
      isClickable: false,
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    return CustomFloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      isExtended: true,
      onPressed: () => _handleApplyButtonPress(context),
      backgroundColor: ThemeColors.primaryBlue,
      icon: Text(
        'Apply',
        style: MyTextStyle.chipTextWhite,
      ),
      loading: false,
      isClickable: true,
    );
  }

  // Helper methods
  void _handleApplyButtonPress(BuildContext context) {
    if (_userStorage.checkCompleted()) {
      _showConfirmationSheet(context);
    } else {
      _showProfileWarning(context);
    }
  }

  // Loading and Error states
  Widget _buildLoader() {
    return const Center(
      child: Loader(loaderType: LoaderType.normalLoader),
    );
  }

  Widget _buildError(JobError state) {
    return AnimatedPlaceholders(
      text: state.message,
      subText: 'We are trying our best to fix this please try again later',
      isError: true,
    );
  }

  // Bottom sheets
  void _showProfileWarning(BuildContext context) {
    final jobBloc = BlocProvider.of<JobBloc>(context);
    showCustomBottomSheet(
      context: context,
      content: BlocProvider.value(
        value: jobBloc,
        child: const IncompleteProfileWarning(),
      ),
      isScrollControlled: true,
      isScrollable: true,
    );
  }

  void _showConfirmationSheet(BuildContext context) {
    final jobBloc = BlocProvider.of<JobBloc>(context);
    showCustomBottomSheet(
      heightFactor: 0.55,
      context: context,
      content: BlocProvider.value(
        value: jobBloc,
        child: const JobApplyConfirmationBottomSheet(),
      ),
    );
  }
}
