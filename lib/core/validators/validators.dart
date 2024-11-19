import 'package:openbn/core/utils/shared_services/functions/date_services.dart';
import 'package:openbn/core/utils/shared_services/models/user/user_model.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/init_dependencies.dart';

class TextValidators {
  //personal profile related
  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }

    final regex = RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$');
    if (!regex.hasMatch(value)) {
      return 'Only alphabets and single spaces are allowed';
    }

    return null;
  }

  static String? addressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address cannot be empty';
    }

    return null;
  }

  static String? bioValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bio cannot be empty';
    }

    final wordCount = value
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .length;

    if (wordCount < 10) {
      return 'Bio must be at least 10 words (currently: $wordCount words)';
    }

    if (wordCount > 100) {
      return 'Bio cannot exceed 100 words (currently: $wordCount words)';
    }

    return null;
  }

  static String? dateOfBirthValidator(String? value) {
    final userStorage = serviceLocator<UserStorageService>();
    UserModel? userData = userStorage.getUser();
    if (value == null || value.isEmpty) {
      return 'DOB cannot be empty';
    }

    if (!DateServices.isAtLeast18YearsOld(value)) {
      return 'Please select an age greater than 18 years old';
    }
    if (userData!.experience.isNotEmpty) {
      List<DateTime> dates = [];
      for (var exp in userData.experience) {
        dates.add(exp.startDate);
      }
      if (!DateServices.checkExpStartDateWithDob(
          expStartDate: DateServices.getEarliestDate(dates),
          currentValue: value)) {
        return 'One of the experience dates dosent match with your date of birth';
      }
    }

    if (userData.education.isNotEmpty) {
      List<DateTime> dates = [];
      for (var exp in userData.education) {
        dates.add(exp.dateOfCompletion);
      }
      if (!DateServices.educationIsAfterDob(
          eduCompleteDate: DateServices.getEarliestDate(dates),
          currentValue: value)) {
        return 'One of the education dates dosent match with your date of birth';
      }
    }

    return null;
  }

  static String? heightValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Height cannot be empty';
    }
    return null;
  }

  static String? weightValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Weight cannot be empty';
    }
    return null;
  }

  //Education edit related

  static String? institutionNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Institution name cannot be empty';
    }

    final regex = RegExp(r'^[a-zA-Z0-9\s]+$');
    if (!regex.hasMatch(value)) {
      return 'Only letters, numbers and spaces are allowed';
    }

    if (value.length < 2) {
      return 'Institution name is too short';
    }

    if (value.length > 100) {
      return 'Institution name is too long';
    }

    if (value.contains(RegExp(r'\s{2,}'))) {
      return 'Multiple consecutive spaces are not allowed';
    }

    if (value.startsWith(' ') || value.endsWith(' ')) {
      return 'Institution name cannot start or end with spaces';
    }

    return null;
  }

  static String? completionDateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Completion date cannot be empty';
    }

    return null;
  }

  static String? eduLevelValidator(dynamic value) {
    if (value == null) {
      return 'Education level must be selected';
    }

    return null;
  }

  static String? courseValidator(dynamic value) {
    if (value == null) {
      return 'Please Select a Course';
    }
    return null;
  }

  static String? specializationValidator(dynamic value) {
    if (value == null) {
      return 'Please Select a Speicalization';
    }

    return null;
  }

  //Experience edit related

  static String? companyNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Company name cannot be empty';
    }

    final regex = RegExp(r'^[a-zA-Z0-9\s]+$');
    if (!regex.hasMatch(value)) {
      return 'Only letters, numbers and spaces are allowed';
    }

    if (value.contains(RegExp(r'\s{2,}'))) {
      return 'Multiple consecutive spaces are not allowed';
    }

    if (value.startsWith(' ') || value.endsWith(' ')) {
      return 'Company name cannot start or end with spaces';
    }

    return null;
  }

  static String? jobRoleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'You must select a role from the suggestion';
    }

    return null;
  }

  static String? startDateValidator(String? value) {
    final userStorage = serviceLocator<UserStorageService>();
    UserModel? userData = userStorage.getUser();
    if (value == null || value.isEmpty) {
      return 'Start date cannot be empty';
    }

    if (userData!.dateOfBirth != null) {
      if (!DateServices.isAtLeast15YearsOld(
          dateOfBirth: userData.dateOfBirth!, currentValue: value)) {
        return 'You must be 15 years old This date does not match with your DOB';
      }
    }

    return null;
  }
}
