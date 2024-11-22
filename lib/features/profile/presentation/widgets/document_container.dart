import 'package:flutter/material.dart';
import 'package:openbn/core/utils/bottom_sheets/bottomsheet.dart';
import 'package:openbn/core/utils/bottom_sheets/resume_upload_widget.dart';
import 'package:openbn/core/utils/shared_services/models/documents/document_model.dart';
import 'package:openbn/core/widgets/file_viewer.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/features/profile/presentation/pages/profile_edit_pages/document_edit_page.dart';

class DocumentContainer extends StatelessWidget {
  final bool isAdd;
  DocumentModel? data;
  bool isResume;
  DocumentContainer(
      {super.key, required this.isAdd, this.data, this.isResume = false});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return isAdd
        ? Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: colorTheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: TextButton.icon(
                onPressed: () {
                  showCustomBottomSheet(
                      isScrollControlled: true,
                      isScrollable: true,
                      heightFactor: 0.45,
                      context: context,
                      content: const DocumentEditPage());
                },
                label: const Text(
                  'Add new Document',
                  style: TextStyle(color: Colors.blue),
                ),
                icon: const Icon(Icons.add, color: Colors.blue),
              ),
            ),
          )
        : Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: colorTheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: colorTheme.onSurface.withOpacity(0.19),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  leftHeadingWithSub(
                      context: context,
                      heading: data!.name,
                      subHeading: data!.link.isEmpty
                          ? 'No file uploaded'
                          : '1 Document uploaded'),
                  data!.link.isEmpty
                      ? TextButton.icon(
                          onPressed: () {
                            if (isResume) {
                              showCustomBottomSheet(
                                  heightFactor: 0.6,
                                  context: context,
                                  content: const ResumeUploadWidget());
                            }
                          },
                          label: Text(
                            'Upload File',
                            style: textTheme.bodyMedium,
                          ),
                          icon: Icon(
                            Icons.upload,
                            color: colorTheme.onSurface,
                          ),
                        )
                      : Row(
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return FileViewer(
                                          fileUrl: data!.link,
                                          heading: data!.name);
                                    });
                              },
                              label: Text(
                                'View File',
                                style: textTheme.bodyMedium,
                              ),
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: colorTheme.onSurface,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                if (isResume) {
                                  showCustomBottomSheet(
                                      heightFactor: 0.6,
                                      context: context,
                                      content: const ResumeUploadWidget());
                                } else {
                                  showCustomBottomSheet(
                                      isScrollControlled: true,
                                      isScrollable: true,
                                      heightFactor: 0.45,
                                      context: context,
                                      content: DocumentEditPage(
                                        document: data,
                                      ));
                                }
                              },
                              label: Text(
                                'Edit File',
                                style: textTheme.bodyMedium,
                              ),
                              icon: Icon(
                                Icons.edit,
                                color: colorTheme.onSurface,
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          );
  }
}
