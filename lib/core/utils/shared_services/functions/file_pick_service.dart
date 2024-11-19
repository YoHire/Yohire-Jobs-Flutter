import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';

class FilePickService {
  Future<File?> pickFile({
    required BuildContext context,
    required double maxSizeKB,
    bool allowJPG = false,
    bool allowPNG = false,
    bool allowPDF = false,
    String? dialogTitle,
  }) async {
    try {
      // Prepare allowed extensions based on parameters
      final List<String> allowedExtensions = [];
      if (allowJPG) allowedExtensions.addAll(['jpg', 'jpeg']);
      if (allowPNG) allowedExtensions.add('png');
      if (allowPDF) allowedExtensions.add('pdf');

      // Validate if at least one file type is allowed
      if (allowedExtensions.isEmpty) {
        throw Exception('At least one file type must be allowed');
      }

      // Pick file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
        dialogTitle: dialogTitle ?? 'Select a file',
      );

      // Check if file was picked
      if (result == null || result.files.isEmpty) {
        return null;
      }

      // Get the picked file
      final file = File(result.files.first.path!);

      // Check file size
      final fileSize = await file.length();
      final fileSizeKB = fileSize / 1024; // Convert to KB

      if (fileSizeKB > maxSizeKB) {
        // Show error message for file size
        if (context.mounted) {
          showSimpleSnackBar(
              context: context,
              text: 'File size exceeds ${maxSizeKB.toStringAsFixed(0)}KB limit',
              position: SnackBarPosition.BOTTOM,
              isError: true);
        }
        return null;
      }

      // Check file extension
      final fileExtension = result.files.first.extension?.toLowerCase();
      if (!allowedExtensions.contains(fileExtension)) {
        // Show error message for invalid file type
        if (context.mounted) {
          showSimpleSnackBar(
              context: context,
              text:
                  'Invalid file type. Allowed types: ${allowedExtensions.join(", ")}',
              position: SnackBarPosition.BOTTOM,
              isError: true);
        }
        return null;
      }

      return file;
    } catch (e) {
      // Show error message
      if (context.mounted) {
        showSimpleSnackBar(
            context: context,
            text: 'Error picking file: ${e.toString()}',
            position: SnackBarPosition.BOTTOM,
            isError: true);
      }
      return null;
    }
  }
}
