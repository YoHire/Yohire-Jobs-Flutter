import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/models/documents/document_model.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/text_field.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/profile/presentation/bloc/profile_bloc.dart';

class DocumentEditPage extends StatefulWidget {
  final DocumentModel? document;
  const DocumentEditPage({super.key, this.document});

  @override
  State<DocumentEditPage> createState() => _DocumentEditPageState();
}

class _DocumentEditPageState extends State<DocumentEditPage> {
  late TextEditingController _documentNameController;
  late TextEditingController _documentController;

  @override
  void initState() {
    super.initState();
    if (widget.document != null) {
      _documentNameController =
          TextEditingController(text: widget.document!.name);
      _documentController = TextEditingController(text: widget.document!.link);
    } else {
      _documentNameController = TextEditingController();
      _documentController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final ValueNotifier<double> uploadProgress = ValueNotifier<double>(0.0);
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is DocumentUpdateSuccess) {
          Navigator.of(context).pop();
          showSimpleSnackBar(
              context: context,
              text: 'Document Uploaded Successfully',
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
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is DocumentUploading) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/uploading.json',
                      width: 250, height: 250),
                  Text(
                    'Uploading file please wait',
                    style: textTheme.labelMedium,
                  ),
                  const ThemeGap(10),
                  ValueListenableBuilder<double>(
                    valueListenable: uploadProgress,
                    builder: (context, progress, child) {
                      return Column(
                        children: [
                          LinearProgressIndicator(
                            backgroundColor:
                                const Color.fromARGB(255, 151, 208, 153),
                            color: Colors.green,
                            value: progress,
                            minHeight: 15,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          Text('${(progress * 100).toStringAsFixed(1)}%'),
                        ],
                      );
                    },
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextField(
                      prefixIcon: const Icon(Icons.label),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 0.0)),
                      hint: 'Name of the Document',
                      controller: _documentNameController),
                  const ThemeGap(10),
                  CustomTextField(
                    prefixIcon: const Icon(Icons.document_scanner),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 0.0)),
                    hint: 'Select Document',
                    controller: _documentController,
                    maxLines: 1,
                    isFilePicker: true,
                    keyboardType: TextInputType.name,
                    suffixIcon: const Icon(Icons.upload_file_rounded),
                  ),
                  const ThemeGap(10),
                  ThemedButton(
                      text: 'Upload',
                      loading: false,
                      onPressed: () {
                        context.read<ProfileBloc>().add(UpdateDocument(
                            progressTracker: uploadProgress,
                            file: File(_documentController.text.trim()),
                            data: DocumentModel(
                                id: widget.document?.id,
                                name: _documentNameController.text,
                                link: widget.document == null
                                    ? ''
                                    : widget.document!.link)));
                      })
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
