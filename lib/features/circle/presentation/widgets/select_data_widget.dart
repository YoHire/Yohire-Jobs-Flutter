import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:openbn/core/theme/app_text_styles.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/check_box.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/init_dependencies.dart';

class SelectDataWidget extends StatefulWidget {
  const SelectDataWidget({super.key});

  @override
  State<SelectDataWidget> createState() => _SelectDataWidgetState();
}

class _SelectDataWidgetState extends State<SelectDataWidget> {
  final List<MultiSelectItem> items = [];
  List<String> selectedItems = [];
  String? resumeUrl;
  @override
  void initState() {
    super.initState();
    resumeUrl = serviceLocator<UserStorageService>().getUser()?.resume;
    items.addAll([
      MultiSelectItem(id: '1', label: 'Phone Number'),
      MultiSelectItem(
          id: '2',
          label: 'Uploaded Resume',
          isEnabled: resumeUrl == null || resumeUrl!.isEmpty ? false : true),
      MultiSelectItem(id: '3', label: 'Email Address'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          leftHeadingWithSub(
              context: context,
              heading: 'Information Sharing',
              subHeading:
                  '''We care about your data privacy and let you decide which sensitive information to share. Any unselected items will be hidden from the employer.'''),
          const ThemeGap(10),
          resumeUrl == null || resumeUrl!.isEmpty
              ? _noResumeWarning()
              : const SizedBox(),
          MultiSelectCheckbox(
            items: items,
            checkboxColor: ThemeColors.primaryBlue,
            selectedTextColor: ThemeColors.primaryBlue,
            onSelectionChanged: (selectedIds) {
              selectedItems = selectedIds;
              log(selectedItems.toString());
            },
          ),
          Align(
              alignment: Alignment.center,
              child:
                  ThemedButton(text: 'Next', loading: false, onPressed: () {})),
          const ThemeGap(20)
        ],
      ),
    );
  }

  _noResumeWarning() {
    return RichText(
      text: TextSpan(
        style: MyTextStyle.smallRedText,
        children: [
          const TextSpan(
            text:
                "You haven't uploaded a resume yet. If you'd like to upload one, ",
          ),
          TextSpan(
            text: "navigate to Profile > Edit Profile > Documents",
            style: MyTextStyle.smallBlueText,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(
            text:
                ". Otherwise, we'll generate a resume based on the information you've provided for submission.",
          ),
        ],
      ),
    );
  }
}
