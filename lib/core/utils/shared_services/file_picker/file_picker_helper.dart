import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/file_picker/model/file_picker_model.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';

Future<FilePickerModel?> pickFile(
    {int fileSize = 750, required BuildContext context}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowCompression: true,
      allowedExtensions: ['pdf', 'jpg', 'png']);
  if (result != null) {
    final fileSizeInBytes = File(result.files.single.path!).lengthSync();
    if (fileSizeInBytes / 1024 > fileSize) {
      showSimpleSnackBar(
          context: context,
          text: 'Max file size is 750 Kb',
          position: SnackBarPosition.BOTTOM,
          isError: true);
      return null;
    } else {
      return FilePickerModel(
          file: File(result.files.single.path!),
          path: result.files.single.path!.split('/').last);
    }
  }
  return null;
}
