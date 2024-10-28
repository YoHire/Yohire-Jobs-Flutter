import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/widgets/app_bar.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/profile/presentation/widgets/profile_container.dart';

class ProfileSectionPage extends StatefulWidget {
  const ProfileSectionPage({super.key});

  @override
  State<ProfileSectionPage> createState() => _ProfileSectionPageState();
}

class _ProfileSectionPageState extends State<ProfileSectionPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<ProfileContainerSection> _sections = [];

  static const _animationDuration = Duration(seconds: 1);
  static const _sectionDelay = 0.2;
  static const _padding = EdgeInsets.all(15);

  @override
  void initState() {
    log('Init state');
    super.initState();
    _initializeAnimationController();
    _loadSections();
  }

  void _initializeAnimationController() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    _controller.forward();
  }

  void _loadSections() {
    Future.delayed(Duration.zero, () {
      setState(() {
        _sections.addAll(_getProfileSections());
      });
    });
  }

  List<ProfileContainerSection> _getProfileSections() {
    return [
      _buildSection(
        isCompleted: true,
        heading: ProfileSections.PersonalDetails.value,
        subHeading: 'Name, Address, Age, Gender, DOB etc...',
      ),
      _buildSection(
        isCompleted: false,
        heading: ProfileSections.AcademicDetails.value,
        subHeading: 'Add your education details',
      ),
      _buildSection(
        isCompleted: true,
        heading: ProfileSections.ExperienceDetails.value,
        subHeading: 'Add your experience (optional)',
      ),
      _buildSection(
        isCompleted: true,
        heading: ProfileSections.SkillsAndPrefrences.value,
        subHeading:
            'For more accurate job recommendations, and early notifications',
      ),
      _buildSection(
        isCompleted: true,
        heading: ProfileSections.Languages.value,
        subHeading: 'You can specify languages that you are proficient in',
      ),
      _buildSection(
        isCompleted: true,
        heading: ProfileSections.Documents.value,
        subHeading: 'Upload documents like resume, certificates etc...',
      ),
    ];
  }

  ProfileContainerSection _buildSection({
    required bool isCompleted,
    required String heading,
    required String subHeading,
  }) {
    return ProfileContainerSection(
      isCompleted: isCompleted,
      heading: heading,
      subHeading: subHeading,
      onTap: () => _handleSectionTap(heading),
    );
  }

  void _handleSectionTap(String section) {
    if (section == ProfileSections.PersonalDetails.value) {
      GoRouter.of(context).push('/personal-details');
    } else if (section == ProfileSections.AcademicDetails.value) {
      GoRouter.of(context).push('/academic-edit');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: _padding,
        child: Column(
          children: [
            _buildHeader(context),
            const ThemeGap(20),
            _buildSectionsList(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return customAppBar(route: '/navigation-bar', context: context);
  }

  Widget _buildHeader(BuildContext context) {
    return leftHeadingWithSub(
      context: context,
      heading: 'Update Your Profile',
      subHeading: 'Tell us more about you',
    );
  }

  Widget _buildSectionsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _sections.length,
        itemBuilder: _buildAnimatedSection,
      ),
    );
  }

  Widget _buildAnimatedSection(BuildContext context, int index) {
    final delay = index * _sectionDelay;
    final slideAnimation = _createSlideAnimation(delay);
    final fadeAnimation = _createFadeAnimation(delay);

    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: _sections[index],
      ),
    );
  }

  Animation<Offset> _createSlideAnimation(double delay) {
    return Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(delay, 1, curve: Curves.easeOut),
      ),
    );
  }

  Animation<double> _createFadeAnimation(double delay) {
    return Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(delay, 1, curve: Curves.easeOut),
      ),
    );
  }
}
