import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:openbn/core/utils/bottom_sheets/bottomsheet.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/core/widgets/app_bar.dart';
import 'package:openbn/features/profile/presentation/pages/profile_edit_pages/job_pref_edit_page.dart';
import 'package:openbn/features/profile/presentation/pages/profile_edit_pages/skill_edit_page.dart';
import 'package:openbn/features/profile/presentation/widgets/skill_and_prefs_container.dart';
import 'package:openbn/init_dependencies.dart';

class SkillAndPrefrencesPage extends StatefulWidget {
  const SkillAndPrefrencesPage({super.key});

  @override
  State<SkillAndPrefrencesPage> createState() => _SkillAndPrefrencesPageState();
}

class _SkillAndPrefrencesPageState extends State<SkillAndPrefrencesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimationLeft;
  late Animation<Offset> _slideAnimationRight;
  final List<SkillModel> _userSkills = [];
  final List<JobRoleModel> _jobRoles = [];

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Create fade animation
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Create slide animations for left and right containers
    _slideAnimationLeft = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _slideAnimationRight = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    // Start the animation
    _controller.forward();
    _assignAllData();
  }

  _assignAllData() {
    final ref = serviceLocator<UserStorageService>();
    final data = ref.getUser();
    _userSkills.addAll(data!.skills);
    _jobRoles.addAll(data.prefrences);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Skills and Preferences',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                children: [
                  // Left container with slide and fade animation
                  SlideTransition(
                    position: _slideAnimationLeft,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SkillAndPrefsContainer(
                        title: 'Your Skills',
                        onTap: () {
                          showCustomBottomSheet(
                              heightFactor: 0.45,
                              context: context,
                              content: SkillEditPage(
                                skill: _userSkills,
                              ));
                        },
                        list: const [],
                        subTitle: 'Choose the skills that suit you',
                        icon: const Icon(
                          Icons.engineering,
                          color: ThemeColors.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                  // Right container with slide and fade animation
                  SlideTransition(
                    position: _slideAnimationRight,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SkillAndPrefsContainer(
                        icon: const Icon(
                          Icons.work_history,
                          color: ThemeColors.primaryBlue,
                        ),
                        title: 'Your Job Preferences',
                        onTap: () {
                          showCustomBottomSheet(
                              heightFactor: 0.45,
                              context: context,
                              content: JobPrefEditPage(
                                jobRole: _jobRoles,
                              ));
                        },
                        list: const [],
                        subTitle: 'Set your preferences',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
