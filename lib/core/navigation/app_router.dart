import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/widgets/getting_jobs_loader.dart';
import 'package:openbn/features/auth/presentation/pages/google_auth_page.dart';
import 'package:openbn/features/auth/presentation/pages/otp_verify_page.dart';
import 'package:openbn/features/circle/presentation/bloc/invitation_bloc/invitation_bloc.dart';
import 'package:openbn/features/circle/presentation/bloc/queue_bloc/queue_bloc.dart';
import 'package:openbn/features/circle/presentation/pages/create_queue_page.dart';
import 'package:openbn/features/circle/presentation/pages/invitation_page.dart';
import 'package:openbn/features/education/presentation/bloc/education_bloc.dart';
import 'package:openbn/features/experience/presentation/bloc/experience_bloc.dart';
import 'package:openbn/features/experience/presentation/pages/experience_edit_page.dart';
import 'package:openbn/features/home/presentation/bloc/job_bloc/job_bloc.dart';
import 'package:openbn/features/home/presentation/pages/job_details_page.dart';
import 'package:openbn/features/prefrences/presentation/bloc/prefrence_bloc.dart';
import 'package:openbn/features/prefrences/presentation/bloc/prefrence_event.dart';
import 'package:openbn/features/prefrences/presentation/pages/prefrence_page.dart';
import 'package:openbn/features/profile/presentation/pages/profile_edit_pages/academic_edit_page.dart';
import 'package:openbn/features/profile/presentation/pages/profile_edit_pages/experience_edit_page.dart';
import 'package:openbn/features/profile/presentation/pages/profile_edit_pages/personal_details_edit.dart';
import 'package:openbn/features/profile/presentation/pages/profile_edit_pages/profile_section_page.dart';
import 'package:openbn/features/profile/presentation/pages/profile_edit_pages/skill_and_prefrences_page.dart';
import 'package:openbn/features/profile/presentation/pages/profile_page.dart';
import 'package:openbn/features/education/presentation/pages/education_edit_page.dart';
import 'package:openbn/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:openbn/features/splash/presentation/pages/splash_screen.dart';
import 'package:openbn/features/username/presentation/bloc/username_bloc.dart';
import 'package:openbn/features/username/presentation/pages/username_enter_page.dart';
import 'package:openbn/init_dependencies.dart';

import '../../features/main_navigation/presentation/pages/main_navigation_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String auth = '/auth';
  static const String navigationBar = '/navigation-bar';
  static const String preferences = '/prefrences';
  static const String username = '/username';
  static const String profileSection = '/profile-section';
  static const String profile = '/profile';
  static const String personalDetails = '/personal-details';
  static const String academicEdit = '/academic-edit';
  static const String educationEdit = '/education-edit';
  static const String jobDetails = '/job-details/:id';
  static const String experienceEdit = '/experience-edit';
  static const String workExperienceEdit = '/workexperience-edit';
  static const String invitation = '/invitation/:queueId';
  static const String createQueue = '/create-queue/:queueId';
  static const String skillsAndPreferences = '/skills-and-prefrences';
  static const String gettingJobsLoader = '/getting-jobs-loader/:redirectPath';
  static const String otpPage = '/otp-page';
}

class AppRouter {
  static CustomTransitionPage _buildPageWithSlideTransition({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    Curve curve = Curves.easeInOut,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final curveTween = CurveTween(curve: curve);
        return SlideTransition(
          position: animation.drive(curveTween).drive(tween),
          child: child,
        );
      },
    );
  }

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.gettingJobsLoader,
        builder: (context, state) {
          final name = state.pathParameters['redirectPath'];
          return GettingJobsForYou(redirectPath: name ?? '');
        },
      ),
      GoRoute(
        path: AppRoutes.otpPage,
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context: context,
          state: state,
          child: const OtpVerifyPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.auth,
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context: context,
          state: state,
          child: const GoogleAuthPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.navigationBar,
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context: context,
          state: state,
          child: const MainNavigationPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.preferences,
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (context) => serviceLocator<PrefrenceBloc>()
              ..add(PrefrenceFetch(industry: 'none')),
            child: const PrefrencesScreen(),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (context) => serviceLocator<SplashBloc>(),
            child: const SplashScreen(),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.username,
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (context) => serviceLocator<UsernameBloc>(),
            child: const UsernameEnterPage(),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.profileSection,
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context: context,
          state: state,
          child: const ProfileSectionPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.profile,
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context: context,
          state: state,
          curve: Curves.easeInBack,
          child: const ProfilePage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.personalDetails,
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context: context,
          state: state,
          curve: Curves.easeInBack,
          child: const PersonalDetails(),
        ),
      ),
      GoRoute(
        path: AppRoutes.academicEdit,
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context: context,
          state: state,
          curve: Curves.easeInBack,
          child: const AcademicEditPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.educationEdit,
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context: context,
          state: state,
          curve: Curves.easeInBack,
          child: BlocProvider(
            create: (context) => serviceLocator<EducationBloc>(),
            lazy: false,
            child: const EducationPage(),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.jobDetails,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return _buildPageWithSlideTransition(
            context: context,
            state: state,
            curve: Curves.easeInBack,
            child: BlocProvider(
              create: (context) =>
                  serviceLocator<JobBloc>()..add(JobInitEvent(id: id)),
              child: const JobDetailsScreen(),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.experienceEdit,
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context: context,
          state: state,
          curve: Curves.easeInBack,
          child: const ExperienceEditPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.workExperienceEdit,
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context: context,
          state: state,
          curve: Curves.easeInBack,
          child: BlocProvider(
            create: (context) => serviceLocator<ExperienceBloc>(),
            child: const ExperiencePage(),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.invitation,
        pageBuilder: (context, state) {
          final queueId = state.pathParameters['queueId']!;
          return _buildPageWithSlideTransition(
            context: context,
            state: state,
            child: BlocProvider(
              lazy: false,
              create: (context) => serviceLocator<InvitationBloc>(),
              child: InvitationPage(queueId: queueId),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.createQueue,
        pageBuilder: (context, state) {
          final queueId = state.pathParameters['queueId'] ?? '';
          return _buildPageWithSlideTransition(
            context: context,
            state: state,
            child: BlocProvider(
              create: (context) =>
                  serviceLocator<QueueBloc>()..add(QueueInitEvent()),
              child: QueueCreationPage(id: queueId),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.skillsAndPreferences,
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context: context,
          state: state,
          child: const SkillAndPrefrencesPage(),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.error.toString()}'),
      ),
    ),
  );
}