import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import statements would be organized by type/source
// Core imports
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/functions/date_services.dart';
import 'package:openbn/core/utils/shared_services/user/models/education_model/education_model.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/validators/text_validators.dart';

// Widget imports
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/text_field.dart';
import 'package:openbn/core/widgets/theme_gap.dart';

// Feature imports
import 'package:openbn/features/education/domain/entity/education_entity.dart';
import 'package:openbn/features/education/presentation/bloc/education_bloc.dart';
import 'package:openbn/features/education/presentation/widgets/education_dropdown.dart';

class EducationPage extends StatefulWidget {
  final EducationModel? data;
  const EducationPage({super.key, this.data});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  // Constants
  static const double _padding = 15.0;
  static const double _gapSize = 10.0;
  static const double _largeGapSize = 20.0;
  static const int _maxInstitutionLength = 50;

  // Controllers
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _completionDateController =
      TextEditingController();
  final TextEditingController _certificateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _assignPreviousValues();
    super.initState();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _institutionController.dispose();
    _completionDateController.dispose();
    _certificateController.dispose();
  }

  void _assignPreviousValues(){
    if(widget.data!=null){
      _institutionController.text = widget.data!.institution;
      _completionDateController.text = widget.data!.dateOfCompletion.toString();
      _certificateController.text = widget.data!.certificateUrl;
    }
  }

  void _handleEducationSave() {
    if (!_formKey.currentState!.validate()) return;

    final educationBloc = context.read<EducationBloc>();
    final education = _createEducationEntity(educationBloc);
    final certificate = _getCertificateFile();

    educationBloc.add(SaveEducation(
      file: certificate,
      data: education,
    ));
  }

  EducationEntity _createEducationEntity(EducationBloc bloc) {
    return EducationEntity(
      id: '',
      institution: _institutionController.text.trim(),
      course: bloc.selectedCourse!,
      completionDate: DateServices.convertStringToDateTime(
        _completionDateController.text,
      ),
      certificateUrl: '',
    );
  }

  File? _getCertificateFile() {
    final certificatePath = _certificateController.text.trim();
    return certificatePath.isNotEmpty ? File(certificatePath) : null;
  }

  void _handleStateChanges(BuildContext context, EducationState state) {
    if (state is EducationError) {
      _handleError(context, state);
    } else if (state is EducationSavedState) {
      _handleSuccess(context);
    }
  }

  void _handleError(BuildContext context, EducationError state) {
    context.read<EducationBloc>().add(LoadCategories());
    _showSnackBar(context, state.message, true);
  }

  void _handleSuccess(BuildContext context) {
    Navigator.of(context).pop();
    _showSnackBar(context, 'Education Added', false);
  }

  void _showSnackBar(BuildContext context, String message, bool isError) {
    showSimpleSnackBar(
      context: context,
      text: message,
      position: SnackBarPosition.BOTTOM,
      isError: isError,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EducationBloc, EducationState>(
      listener: _handleStateChanges,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: _buildBody(context),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_padding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const ThemeGap(_gapSize),
            _buildForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return leftHeadingWithSub(
      context: context,
      heading: 'Education Details',
      subHeading: 'Please fill out the form to provide your education details.',
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildInstitutionField(),
            const ThemeGap(_gapSize),
            const CourseDropdownWidget(),
            const ThemeGap(_gapSize),
            _buildCompletionDateField(),
            const ThemeGap(_gapSize),
            _buildCertificateField(),
            const ThemeGap(_largeGapSize),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildInstitutionField() {
    return CustomTextField(
      prefixIcon: const Icon(Icons.apartment),
      border: const OutlineInputBorder(borderSide: BorderSide(width: 0.0)),
      hint: 'Institution Name',
      controller: _institutionController,
      maxLines: 1,
      validator: TextValidators.institutionNameValidator,
      maxLength: _maxInstitutionLength,
      keyboardType: TextInputType.name,
    );
  }

  Widget _buildCompletionDateField() {
    return CustomTextField(
      prefixIcon: const Icon(Icons.date_range),
      border: const OutlineInputBorder(borderSide: BorderSide(width: 0.0)),
      hint: 'Completion Date',
      controller: _completionDateController,
      maxLines: 1,
      isDatePicker: true,
      validator: TextValidators.completionDateValidator,
    );
  }

  Widget _buildCertificateField() {
    return CustomTextField(
      prefixIcon: const Icon(Icons.document_scanner),
      border: const OutlineInputBorder(borderSide: BorderSide(width: 0.0)),
      hint: 'Certificate (Optional)',
      controller: _certificateController,
      maxLines: 1,
      isFilePicker: true,
      keyboardType: TextInputType.name,
      suffixIcon: const Icon(Icons.upload_file_rounded),
    );
  }

  Widget _buildSubmitButton() {
    return ThemedButton(
      text: 'Add',
      loading: false,
      onPressed: _handleEducationSave,
    );
  }
}
