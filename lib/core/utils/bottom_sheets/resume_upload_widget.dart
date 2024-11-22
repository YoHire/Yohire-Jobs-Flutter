import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/file_picker/file_picker_helper.dart';
import 'package:openbn/core/utils/shared_services/file_picker/model/file_picker_model.dart';
import 'package:openbn/core/utils/shared_services/firebase_storage/firebase_storage.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:openbn/init_dependencies.dart';

class ResumeUploadWidget extends StatefulWidget {
  const ResumeUploadWidget({super.key});

  @override
  State<ResumeUploadWidget> createState() => _ResumeUploadWidgetState();
}

class _ResumeUploadWidgetState extends State<ResumeUploadWidget> {
  final ValueNotifier<double> _uploadProgress = ValueNotifier<double>(0.0);
  bool _isUploading = false;
  String? _uploadedFileUrl;

  Future<void> _uploadFile(FilePickerModel fileModel) async {
    setState(() {
      _isUploading = true;
    });

    try {
      final firebaseStorage = serviceLocator<FileUploadService>();
      final getStorage = serviceLocator<GetStorage>();
      final dio = serviceLocator<DioInterceptorHandler>().dio;
      final userStorage = serviceLocator<UserStorageService>();
      String folderName = getStorage.read('userId') ?? 'default_user';
      String fileName = fileModel.file.path.split('/').last;

      _uploadedFileUrl = await firebaseStorage.uploadFile(
        progressNotifier: _uploadProgress,
        file: fileModel.file,
        fileAnnotation: fileName,
        folderName: folderName,
      );

      if (_uploadedFileUrl != null) {
        Map<String, dynamic> body = {'link': _uploadedFileUrl};
        try {
          await dio.post('${URL.UPLOAD_RESUME}${getStorage.read('userId')}',
              data: body);
        } catch (e) {
          throw Exception(e);
        }
        await userStorage.updateUser();
        Navigator.of(context).pop();
              showSimpleSnackBar(
          context: context,
          text: 'Resume Uploaded Successfully',
          position: SnackBarPosition.BOTTOM,
          isError: false);
          context.read<ProfileBloc>().add(EmitBlocDocumentSuccess());
      }
    } catch (e) {
      showSimpleSnackBar(
          context: context,
          text: 'File upload failed: $e',
          position: SnackBarPosition.BOTTOM,
          isError: true);
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Column(
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
              '''Upload Your Resume''',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Text(
              '''To stand out from others''',
              style: textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
            child: ThemedButton(
              text: _isUploading ? 'Uploading...' : 'Upload',
              loading: _isUploading,
              onPressed: () async {
                if (!_isUploading) {
                  final FilePickerModel? file = await pickFile(context: context);
                  if (file != null) {
                    await _uploadFile(file);
                  }
                }
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          if (_isUploading)
            Column(
              children: [
                ValueListenableBuilder<double>(
                  valueListenable: _uploadProgress,
                  builder: (context, progress, child) {
                    return LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: Colors.grey[200],
                      color: Colors.blue,
                    );
                  },
                ),
                Text(
                  '${(_uploadProgress.value * 100).toStringAsFixed(1)}%',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
