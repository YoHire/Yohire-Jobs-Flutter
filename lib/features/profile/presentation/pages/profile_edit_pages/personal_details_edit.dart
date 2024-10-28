import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/validators/text_validators.dart';
import 'package:openbn/core/widgets/app_bar.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/radio_button.dart';
import 'package:openbn/core/widgets/text_field.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/profile/domain/entity/personal_details_entity.dart';
import 'package:openbn/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:openbn/init_dependencies.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final _formKey = GlobalKey<FormState>();
  GenderType? _selectedGender;
  File? _profileImage;
  String? _profileImageLink;
  late final TextEditingController _firstNameController;
  late final TextEditingController _surnameController;
  late final TextEditingController _addressController;
  late final TextEditingController _bioController;
  late final TextEditingController _dateOfBirthController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _selectedGender = GenderType.Male;
    _firstNameController = TextEditingController();
    _surnameController = TextEditingController();
    _addressController = TextEditingController();
    _bioController = TextEditingController();
    _dateOfBirthController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _assignAllData();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    _addressController.dispose();
    _bioController.dispose();
    _dateOfBirthController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  _assignAllData() {
    final ref = serviceLocator<UserStorageService>();
    final data = ref.getUser();
    _profileImageLink = data!.profileImage;
    _firstNameController.text = data.username ?? '';
    _surnameController.text = data.surname ?? '';
    _bioController.text = data.bio ?? '';
    _heightController.text = data.height ?? '';
    _weightController.text = data.weight ?? '';
    _addressController.text = data.address ?? '';
    _dateOfBirthController.text =
        data.dateOfBirth != null ? arrangeDate(data.dateOfBirth!) : '';
    if (data.gender == 'Male') {
      _selectedGender = GenderType.Male;
    } else if (data.gender == 'Female') {
      _selectedGender = GenderType.Female;
    } else {
      _selectedGender = GenderType.Others;
    }
  }

  String arrangeDate(String date) {
    String slicedDate = date.substring(0, 10);
    return '${slicedDate.substring(8, 10)}/${slicedDate.substring(5, 7)}/${slicedDate.substring(0, 4)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is UpdateError) {
            showSimpleSnackBar(
                context: context,
                text: state.message,
                position: SnackBarPosition.BOTTOM,
                isError: true);
          } else if (state is UpdateSuccess) {
            Navigator.of(context).pop();
            showSimpleSnackBar(
                context: context,
                text: 'Personal Details Updated Successfully',
                position: SnackBarPosition.BOTTOM,
                isError: false);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildProfilePicWidget(_profileImageLink),
                    _buildAllTextFields(context),
                    _buildAllNumberFields(context),
                    _buildLocationPickWidget(),
                    _buildGenderWidget(context),
                    _buildDobPickWidget(),
                    const ThemeGap(24),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        return ThemedButton(
                            text: 'Save',
                            loading: state is ProfileUpdating,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                PersonalDetailsEntity data =
                                    PersonalDetailsEntity(
                                        username: _firstNameController.text,
                                        surname: _surnameController.text,
                                        bio: _bioController.text,
                                        profileImage: _profileImage,
                                        address: _addressController.text,
                                        gender: _selectedGender!.value,
                                        dateOfBirth:
                                            _dateOfBirthController.text,
                                        height: _heightController.text,
                                        weight: _weightController.text);
                                context
                                    .read<ProfileBloc>()
                                    .add(UpdatePersonalDataEvent(data: data));
                              }
                            });
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return customAppBar(
      route: '/profile-section',
      context: context,
      title: 'Personal Details',
    );
  }

  _buildProfilePicWidget(String? imgUrl) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () async {
            final image =
                await ImagePicker().pickImage(source: ImageSource.gallery);

            if (image != null) {
              setState(() {
                _profileImage = File(image.path);
              });
            }
          },
          child: Stack(
            children: [
              PhysicalModel(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  elevation: 7,
                  child: CircleAvatar(
                    maxRadius: 80,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!) as ImageProvider<Object>
                        : imgUrl != null
                            ? CachedNetworkImageProvider(imgUrl)
                            : const AssetImage('assets/images/user.jpeg')
                                as ImageProvider<Object>,
                  )),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/icon/edit.png',
                    width: 45,
                    height: 45,
                  ))
            ],
          ),
        ),
        const ThemeGap(20),
      ],
    );
  }

  _buildAllTextFields(BuildContext context) {
    return Column(
      children: [
        _buildTextField(
          context: context,
          hint: 'FirstName',
          validator: TextValidators.nameValidator,
          controller: _firstNameController,
          icon: const Icon(Icons.person),
        ),
        const ThemeGap(16),
        _buildTextField(
          context: context,
          hint: 'Surname',
          validator: TextValidators.nameValidator,
          controller: _surnameController,
          icon: const Icon(Icons.person),
        ),
        const ThemeGap(16),
        _buildTextField(
          context: context,
          hint: 'Bio',
          maxLines: 3,
          validator: TextValidators.bioValidator,
          controller: _bioController,
          icon: const Icon(Icons.biotech),
        ),
        const ThemeGap(16),
      ],
    );
  }

  _buildAllNumberFields(BuildContext context) {
    return Column(
      children: [
        _buildNumberField(
            onChanged: _heightLogicFunction,
            context: context,
            hint: 'Height (CM)',
            controller: _heightController,
            validator: TextValidators.heightValidator,
            icon: const Icon(Icons.height)),
        const ThemeGap(16),
        _buildNumberField(
            onChanged: _weightLogicFunction,
            context: context,
            hint: 'Weight (KG)',
            controller: _weightController,
            validator: TextValidators.weightValidator,
            icon: const Icon(Icons.fitness_center)),
        const ThemeGap(16),
      ],
    );
  }

  _buildTextField({
    required BuildContext context,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    int? maxLines,
    int? maxLength,
    required Icon icon,
  }) {
    return CustomTextField(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(width: 0.4)),
      prefixIcon: icon,
      hint: hint,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      maxLength: maxLength,
    );
  }

  _buildNumberField({
    required BuildContext context,
    required String hint,
    required void Function(String)? onChanged,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    required Icon icon,
  }) {
    return CustomTextField(
      keyboardType: const TextInputType.numberWithOptions(),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(width: 0.4)),
      prefixIcon: icon,
      hint: hint,
      onChanged: onChanged,
      controller: controller,
      validator: validator,
    );
  }

  _buildLocationPickWidget() {
    return CustomTextField(
      hint: 'Address',
      validator: TextValidators.addressValidator,
      controller: _addressController,
      prefixIcon: const Icon(
        Icons.location_on,
        color: Colors.red,
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(width: 0.4)),
      isLocationPicker: true,
    );
  }

  _buildGenderWidget(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ThemeGap(10),
        Text(
          'Gender',
          style: textTheme.labelMedium,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomRadioButton<GenderType>(
              value: GenderType.Male,
              groupValue: _selectedGender!,
              label: 'Male',
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                  _selectedGender = value;
                });
              },
            ),
            CustomRadioButton<GenderType>(
              value: GenderType.Female,
              groupValue: _selectedGender!,
              label: 'Female',
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            CustomRadioButton<GenderType>(
              value: GenderType.Others,
              groupValue: _selectedGender!,
              label: 'Other',
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
          ],
        ),
        const ThemeGap(10),
      ],
    );
  }

  _buildDobPickWidget() {
    return CustomTextField(
      hint: "Date of Birth",
      validator: TextValidators.dateOfBirthValidator,
      controller: _dateOfBirthController,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(width: 0.4)),
      isDatePicker: true,
      dateFormat: "dd/MM/yyyy",
      onChanged: (value) {
        log("Date of Birth: $value");
      },
    );
  }

  _heightLogicFunction(String value) {
    String filteredValue = value.replaceAll(RegExp(r'[^0-9.]'), '');

    if (filteredValue.contains('.')) {
      List<String> parts = filteredValue.split('.');
      String integerPart = parts[0];
      String decimalPart = parts.length > 1 ? parts[1] : '';

      if (integerPart.length > 3) {
        integerPart = integerPart.substring(0, 3);
      }

      if (decimalPart.length > 2) {
        decimalPart = decimalPart.substring(0, 2);
      }

      filteredValue = '$integerPart.$decimalPart';
    } else {
      if (filteredValue.length > 3) {
        filteredValue = filteredValue.substring(0, 3);
      }
    }

    _heightController.value = TextEditingValue(
      text: filteredValue,
      selection: TextSelection.collapsed(offset: filteredValue.length),
    );
  }

  _weightLogicFunction(String value) {
    String filteredValue = value.replaceAll(RegExp(r'[^0-9.]'), '');

    if (filteredValue.contains('.')) {
      List<String> parts = filteredValue.split('.');
      String integerPart = parts[0];
      String decimalPart = parts.length > 1 ? parts[1] : '';

      if (integerPart.length > 3) {
        integerPart = integerPart.substring(0, 3);
      }

      if (decimalPart.length > 2) {
        decimalPart = decimalPart.substring(0, 2);
      }

      filteredValue = '$integerPart.$decimalPart';
    } else {
      if (filteredValue.length > 3) {
        filteredValue = filteredValue.substring(0, 3);
      }
    }

    _weightController.value = TextEditingValue(
      text: filteredValue,
      selection: TextSelection.collapsed(offset: filteredValue.length),
    );
  }
}
