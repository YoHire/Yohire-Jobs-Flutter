import 'package:flutter/material.dart';
import 'package:openbn/core/widgets/app_bar.dart';

class SkillAndPrefrencesPage extends StatelessWidget {
  const SkillAndPrefrencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context),
    );
  }
}