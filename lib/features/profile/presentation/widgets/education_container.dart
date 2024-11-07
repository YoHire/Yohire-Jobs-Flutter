import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/shared_services/models/education/education_model.dart';
import 'package:openbn/core/widgets/file_viewer.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/education/presentation/bloc/education_bloc.dart';
import 'package:openbn/features/education/presentation/pages/education_edit_page.dart';
import 'package:openbn/init_dependencies.dart';

class EducationContainer extends StatelessWidget {
  final EducationModel data;

  const EducationContainer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Stack(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: colorTheme.surface,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(width: 0.1)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    leftHeadingWithSub(
                        context: context,
                        heading: data.institution,
                        subHeading:
                            '${data.courseData!.category} ${data.courseData!.subCategory} ${data.courseData!.course}'),
                    const ThemeGap(10),
                    Text(
                        'Completed on : ${data.dateOfCompletion.toString().substring(0, 10)}'),
                    data.certificateUrl.isNotEmpty
                        ? TextButton.icon(
                            style: const ButtonStyle(
                                padding:
                                    WidgetStatePropertyAll(EdgeInsets.all(0))),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return FileViewer(
                                        fileUrl: data.certificateUrl,
                                        heading: 'Education Cerificate');
                                  });
                            },
                            label: Text(
                              'View Certificate',
                              style: textTheme.bodyMedium,
                            ))
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ),
          Positioned(right: 0, child: _buildPopUpMenu(context, data))
        ],
      ),
    );
  }

  Widget _buildPopUpMenu(BuildContext context, EducationModel data) {
    return PopupMenuButton(itemBuilder: (context) {
      return [
        PopupMenuItem(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => BlocProvider(
                      create: (context) => serviceLocator<EducationBloc>(),
                      child: EducationPage(
                        data: data,
                      ),
                    )));
          },
          value: 1,
          child: Row(
            children: [
              Image.asset(
                'assets/icon/edit.png',
                width: 25,
                height: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Edit",
              )
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {},
          value: 1,
          child: Row(
            children: [
              Image.asset(
                'assets/icon/delete.png',
                width: 25,
                height: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Delete",
              )
            ],
          ),
        ),
      ];
    });
  }
}
