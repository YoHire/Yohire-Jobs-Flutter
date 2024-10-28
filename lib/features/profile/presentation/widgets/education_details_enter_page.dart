import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/text_field.dart';
import 'package:openbn/core/widgets/theme_gap.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({
    super.key,
  });

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    leftHeadingWithSub(
                        context: context,
                        heading: 'Education Details',
                        subHeading:
                            'Please fill out the form to provide your education details.'),
                    const ThemeGap(20),
                    SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          CustomTextField(
                            prefixIcon: const Icon(Icons.apartment),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(width: 0.0)),
                            hint: 'Institution Name',
                            controller: TextEditingController(),
                            maxLines: 1,
                            maxLength: 50,
                            keyboardType: TextInputType.name,
                          ),

                          //Date of completion

                          //Certificate Upload
                          InkWell(
                              onTap: () async {},
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      hint: '',
                                      controller: TextEditingController(),
                                      maxLines: 1,
                                      maxLength: 50,
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/icon/attach.png',
                                    width: 50,
                                  )
                                ],
                              )),
                          const ThemeGap(20),
                          // BlackButton('Save', () {
                          //   if (isUpdation) {
                          //     educationController.updateEducation(id!,
                          //         refresh: refreshFunction);
                          //     if (isNeedToUpdate!) {
                          //       controller!.getEducationAndExperience();
                          //     }
                          //   } else if (isAdding) {
                          //     educationController.addSingleEducation(
                          //         refresh: refreshFunction);
                          //   } else if (isIntermediateEditing) {
                          //     educationController.intermediateSaving(
                          //         index: isIntermediateListIndex!,
                          //         refresh: refreshFunction);
                          //   } else {
                          //     educationController.save(
                          //         refresh: refreshFunction);
                          //   }
                          // })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
              visible: false,
              child: Positioned(
                  child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(107, 255, 255, 255),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Lottie.asset('assets/lottie/uploading.json',
                      width: 300, height: 300),
                ),
              )))
        ],
      ),
    );
  }
}
