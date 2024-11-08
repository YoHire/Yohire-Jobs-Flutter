import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:openbn/core/utils/bottom_sheets/bottomsheet.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/features/home/presentation/bloc/job_bloc/job_bloc.dart';
import 'package:openbn/features/home/presentation/pages/widgets/confirmation_bottom_sheet.dart';
import 'package:openbn/init_dependencies.dart';

class IncompleteProfileWarning extends StatefulWidget {
  const IncompleteProfileWarning({super.key});

  @override
  State<IncompleteProfileWarning> createState() =>
      _IncompleteProfileWarningState();
}

class _IncompleteProfileWarningState extends State<IncompleteProfileWarning> {
  List<ProfileStatus> getStatus = [];
  final userStorage = serviceLocator<UserStorageService>();

  @override
  void initState() {
    getStatus.addAll(userStorage.checkCompletionStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leftHeadingWithSub(
                    context: context,
                    heading: 'Incomplete Profile',
                    subHeading: getStatus[0] == ProfileStatus.Incomplete ||
                            getStatus[1] == ProfileStatus.Incomplete
                        ? 'You must atleast complete Personal and Academic details'
                        : 'These incomplete sections are not compulsory, but completing those will help you to stay relevant in applicants list'),
                tile(
                    context: context,
                    icon: const Icon(Icons.account_circle_rounded),
                    heading: 'Personal Details',
                    description: 'your basic details',
                    status: getStatus[0]),
                tile(
                    context: context,
                    icon: const Icon(Icons.book),
                    heading: 'Academic Details',
                    description: 'your education details',
                    status: getStatus[1]),
                tile(
                    context: context,
                    icon: const Icon(Icons.work),
                    heading: 'Experience Details',
                    description: 'your experience details',
                    status: getStatus[2]),
                tile(
                    context: context,
                    heading: 'Skills And Prefrences',
                    icon: const Icon(Icons.space_dashboard_rounded),
                    description: 'your skills and prefrences',
                    status: getStatus[0]),
                tile(
                    context: context,
                    icon: const Icon(Icons.translate),
                    heading: 'Languages',
                    description: 'your language prefrences',
                    status: getStatus[0]),
                tile(
                    context: context,
                    icon: const Icon(Icons.edit_document),
                    heading: 'Documents',
                    description: 'uploaded documents',
                    status: getStatus[0]),
                getStatus[0] == ProfileStatus.Incomplete ||
                        getStatus[1] == ProfileStatus.Incomplete
                    ? const SizedBox()
                    : ThemedButton(
                        text: 'Apply Anyway',
                        loading: false,
                        onPressed: () {
                          _buildConfirmationSheet(context);
                        })
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget tile(
      {required BuildContext context,
      required String heading,
      required Widget icon,
      required String description,
      required ProfileStatus status}) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      leading: icon,
      title: Text(
        heading,
        style: textTheme.labelMedium,
      ),
      subtitle: Text(
        description,
        style: textTheme.labelSmall,
      ),
      trailing: status == ProfileStatus.Incomplete
          ? Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Lottie.asset('assets/lottie/no.json',
                  width: 40, height: 40, repeat: false),
            )
          : status == ProfileStatus.Completed
              ? Lottie.asset('assets/lottie/yes.json', repeat: false)
              : Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Lottie.asset('assets/lottie/warning.json',
                      width: 40, height: 40, repeat: false),
                ),
    );
  }

  _buildConfirmationSheet(BuildContext context) {
    final jobBloc = BlocProvider.of<JobBloc>(context);
    Navigator.of(context).pop();
    return showCustomBottomSheet(
        context: context,
        content: BlocProvider.value(
          value: jobBloc,
          child: const JobApplyConfirmationBottomSheet(),
        ));
  }
}
