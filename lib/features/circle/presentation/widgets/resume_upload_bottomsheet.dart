import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/widgets/button.dart';

class ResumeUploadBottomsheet extends StatelessWidget {
  const ResumeUploadBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: screenHeight * 0.3,
        width: screenWidth * 0.6,
        child: Lottie.asset('assets/lottie/resume.json'),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Text(
          '''Looks like you''',
          style: textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Text(
          '''haven't added a resume yet''',
          style: textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(height: screenHeight * 0.02),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Text(
          '''Add a resume to make your profile stand out''',
          style: textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(height: screenHeight * 0.02),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
        child: ThemedButton(
         text:  'Upload',
       onPressed:  () async {

          },
          loading: false,
        ),
      ),
      SizedBox(height: screenHeight * 0.01),
    ],
  );
  }
    Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      int fileSize = await file.length();
      if (fileSize <= 750 * 1024) {
       
      } else {
        // showSimpleSnackBar(
        //     context: context,
        //     text: 'File size must be less than 750KB',
        //     position: SnackBarPosition.BOTTOM,
        //     isError: true);
      }
    }
  }
}