import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/widgets/app_bar.dart';
import 'package:openbn/core/widgets/floating_action_button.dart';
import 'package:openbn/features/profile/presentation/widgets/education_container.dart';

class AcademicEditPage extends StatelessWidget {
  const AcademicEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: const Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            EducationContainer(),
            EducationContainer(),
            EducationContainer(),
            EducationContainer(),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
          onPressed: () {
            GoRouter.of(context).push('/education-edit');
          },
          backgroundColor: ThemeColors.primaryBlue,
          icon: const Icon(Icons.add),
          loading: false,
          isClickable: true),
    );
  }

  _buildAppBar(BuildContext context) {
    return customAppBar(
      route: '/profile-section',
      context: context,
      title: 'Academic Details',
    );
  }
}
