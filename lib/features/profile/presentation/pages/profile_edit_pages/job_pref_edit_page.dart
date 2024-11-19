import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/job_roles/jobrole_service.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/search_select_field.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/profile/presentation/bloc/profile_bloc.dart';

class JobPrefEditPage extends StatefulWidget {
  final List<JobRoleModel> jobRole;
  const JobPrefEditPage({super.key, required this.jobRole});

  @override
  State<JobPrefEditPage> createState() => _JobPrefEditPageState();
}

class _JobPrefEditPageState extends State<JobPrefEditPage> {
  @override
  void initState() {
    super.initState();
    _selectedjobRoles.addAll(widget.jobRole);
  }

  List<JobRoleModel> _selectedjobRoles = [];
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is JobPrefUpdateSuccess) {
          Navigator.of(context).pop();
          showSimpleSnackBar(
              context: context,
              text: 'Job Prefrences updated Successfully',
              position: SnackBarPosition.BOTTOM,
              isError: false);
        }
        if (state is UpdateError) {
          Navigator.of(context).pop();
          showSimpleSnackBar(
              context: context,
              text: 'Something went wrong please try again later',
              position: SnackBarPosition.BOTTOM,
              isError: true);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SearchSelectField<JobRoleModel>(
              hint: 'Search JobRoles',
              prefixIcon: const Icon(Icons.work),
              fetchData: JobroleService().searchJobRoles,
              displayText: (jobRole) => jobRole.name!,
              selectedData: _selectedjobRoles,
              onSelectionChanged: (jobRoles) {
                setState(() {
                  _selectedjobRoles = jobRoles;
                });
              },
            ),
            const ThemeGap(10),
            ThemedButton(
                text: 'Update',
                loading: false,
                onPressed: () {
                  context
                      .read<ProfileBloc>()
                      .add(UpdateJobPrefs(data: _selectedjobRoles));
                })
          ],
        ),
      ),
    );
  }
}
