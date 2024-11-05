import 'dart:developer';

import 'package:intl/intl.dart';

class TextValidators {
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

    // if (value.contains(RegExp(r'[^\w\s.,!?()-]'))) {
    //   return 'Bio contains invalid characters';
    // }

    return null;
  }

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

  static String? dateOfBirthValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'DOB cannot be empty';
    }
    if (!isAtLeast18YearsOld(value)) {
      return 'Please select an age greater than 18 years old';
    }

    return null;
  }

  static String? completionDateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Completion date cannot be empty';
    }
    // if (!isAtLeast18YearsOld(value)) {
    //   return 'Please select an age greater than 18 years old';
    // }

    return null;
  }

  static bool isAtLeast18YearsOld(String dateString) {
    try {
      DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(dateString);
      DateTime date18YearsAgo =
          DateTime.now().subtract(const Duration(days: 18 * 365));
      return parsedDate.isBefore(date18YearsAgo) ||
          parsedDate.isAtSameMomentAs(date18YearsAgo);
    } catch (e) {
      log('Invalid date format: $e');
      return false;
    }
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
}
