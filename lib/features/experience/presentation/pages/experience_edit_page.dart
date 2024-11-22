import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/functions/date_services.dart';
import 'package:openbn/core/utils/shared_services/job_roles/jobrole_service.dart';
import 'package:openbn/core/utils/shared_services/models/experience/workexperience_model.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/validators/validators.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/single_select_search_field.dart';
import 'package:openbn/core/widgets/text_field.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/experience/presentation/bloc/experience_bloc.dart';

class ExperiencePage extends StatefulWidget {
  final WorkExperienceModel? data;
  const ExperiencePage({
    super.key,
    this.data,
  });

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  // Controllers
  late final TextEditingController _companyNameController;
  late final TextEditingController _jobRoleController;
  late final TextEditingController _startDateController;
  late final TextEditingController _endDateController;
  late final TextEditingController _certificateController;
  JobRoleModel? _selectedItem;

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // State
  bool _isPresent = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    _companyNameController = TextEditingController();
    _jobRoleController = TextEditingController();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    _certificateController = TextEditingController();
    if (widget.data != null) {
      _assignPreviousValues();
    }
  }

  _assignPreviousValues() {
    _companyNameController.text = widget.data!.company;
    _jobRoleController.text = widget.data!.designation!.name!;
    _startDateController.text =
        widget.data!.startDate.toString().substring(0, 10);
    _endDateController.text = widget.data!.endDate == null
        ? ''
        : widget.data!.endDate.toString().substring(0, 10);
    _selectedItem = widget.data!.designation;
    _isPresent = widget.data!.endDate == null ? true : false;
    _certificateController.text = widget.data!.certificateUrl;
  }

  @override
  void dispose() {
    // Cleanup controllers
    _companyNameController.dispose();
    _jobRoleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _certificateController.dispose();
    super.dispose();
  }

  File? _getCertificateFile() {
    final certificatePath = _certificateController.text.trim();
    return certificatePath.isNotEmpty ? File(certificatePath) : null;
  }

  // Method to handle form submission
  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<ExperienceBloc>().add(SaveExperience(
          data: WorkExperienceModel(
              id: widget.data == null ? '' : widget.data!.id,
              designation: _selectedItem,
              company: _companyNameController.text,
              startDate: DateServices.convertStringToDateTime(
                _startDateController.text,
              ),
              endDate: _endDateController.text.isEmpty
                  ? null
                  : DateServices.convertStringToDateTime(
                      _endDateController.text,
                    ),
              userId: '',
              certificateUrl:
                  widget.data == null ? '' : widget.data!.certificateUrl),
          file: _getCertificateFile()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<ExperienceBloc, ExperienceState>(
      listener: (context, state) {
        if (state is ExperienceError) {
          showSimpleSnackBar(
              context: context,
              text: state.message,
              position: SnackBarPosition.BOTTOM,
              isError: true);
        }
        if (state is ExperienceSaved) {
          showSimpleSnackBar(
              context: context,
              text: 'Experience saved successfully!',
              position: SnackBarPosition.BOTTOM,
              isError: false);
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocBuilder<ExperienceBloc, ExperienceState>(
              builder: (context, state) {
                return state is ExperienceSaving
                    ? const SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator())
                    : IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: _handleSubmit,
                      );
              },
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        leftHeadingWithSub(
                          context: context,
                          heading: 'Experience Details',
                          subHeading:
                              'Please fill out the form to provide your experience details.',
                        ),
                        const ThemeGap(10),
                        CustomTextField(
                          validator: TextValidators.companyNameValidator,
                          controller: _companyNameController,
                          maxLines: 1,
                          prefixIcon: const Icon(Icons.work),
                          maxLength: 50,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 0.0),
                          ),
                          hint: 'Company Name',
                          keyboardType: TextInputType.name,
                        ),
                        const ThemeGap(10),
                        SingleSearchSelectField(
                          validator: TextValidators.jobRoleValidator,
                          fetchData: JobroleService().searchJobRoles,
                          displayText: (job) => job.name!,
                          hint: 'Job Role',
                          prefixIcon: const Icon(Icons.smart_button),
                          controller: _jobRoleController,
                          onSelected: (selectedData) {
                            _selectedItem = selectedData;
                          },
                        ),
                        const ThemeGap(10),
                        CustomTextField(
                          prefixIcon: const Icon(Icons.date_range),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 0.0),
                          ),
                          hint: 'Start Date',
                          controller: _startDateController,
                          maxLines: 1,
                          isDatePicker: true,
                          validator: TextValidators.startDateValidator,
                        ),
                        const ThemeGap(10),
                        CustomTextField(
                          isDisabled: _isPresent,
                          prefixIcon: const Icon(Icons.date_range),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 0.0),
                          ),
                          hint: 'End Date',
                          controller: _endDateController,
                          maxLines: 1,
                          isDatePicker: true,
                        ),
                        const ThemeGap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'I currently work here',
                              style: textTheme.bodyMedium,
                            ),
                            Switch(
                              value: _isPresent,
                              onChanged: (val) {
                                setState(() {
                                  _isPresent = val;
                                  if (_isPresent) {
                                    _endDateController.clear();
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        CustomTextField(
                          prefixIcon: const Icon(Icons.document_scanner),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 0.0)),
                          hint: 'Certificate (Optional)',
                          controller: _certificateController,
                          maxLines: 1,
                          isFilePicker: true,
                          keyboardType: TextInputType.name,
                          suffixIcon: const Icon(Icons.upload_file_rounded),
                        ),
                        const ThemeGap(20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
