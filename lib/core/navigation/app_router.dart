import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/widgets/getting_jobs_loader.dart';
import 'package:openbn/features/auth/presentation/pages/google_auth_page.dart';
import 'package:openbn/features/auth/presentation/pages/otp_verify_page.dart';
import 'package:openbn/features/prefrences/presentation/pages/prefrence_page.dart';
import 'package:openbn/features/profile/presentation/pages/profile_edit_pages/academic_edit_page.dart';
import 'package:openbn/features/profile/presentation/pages/profile_edit_pages/personal_details_edit.dart';
import 'package:openbn/features/profile/presentation/pages/profile_edit_pages/profile_section_page.dart';
import 'package:openbn/features/profile/presentation/pages/profile_page.dart';
import 'package:openbn/features/profile/presentation/widgets/education_details_enter_page.dart';
import 'package:openbn/features/splash/presentation/pages/splash_screen.dart';
import 'package:openbn/features/username/presentation/pages/username_enter_page.dart';

import '../../features/main_navigation/presentation/pages/main_navigation_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/getting-jobs-loader/:redirectPath',
        builder: (context, state) {
          final name = state.pathParameters['redirectPath'];
          return GettingJobsForYou(redirectPath: name ?? '');
        },
      ),
      GoRoute(
        path: '/otp-page',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OtpVerifyPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final curveTween = CurveTween(curve: Curves.easeInOut);
            return SlideTransition(
              position: animation.drive(curveTween).drive(tween),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/auth',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const GoogleAuthPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final curveTween = CurveTween(curve: Curves.easeInOut);
            return SlideTransition(
              position: animation.drive(curveTween).drive(tween),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/navigation-bar',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const MainNavigationPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final curveTween = CurveTween(curve: Curves.easeInOut);
            return SlideTransition(
              position: animation.drive(curveTween).drive(tween),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/prefrences',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const PrefrencesScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final curveTween = CurveTween(curve: Curves.easeInOut);
            return SlideTransition(
              position: animation.drive(curveTween).drive(tween),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final curveTween = CurveTween(curve: Curves.easeInOut);
            return SlideTransition(
              position: animation.drive(curveTween).drive(tween),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/username',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const UsernameEnterPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final curveTween = CurveTween(curve: Curves.easeInOut);
            return SlideTransition(
              position: animation.drive(curveTween).drive(tween),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/profile-section',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ProfileSectionPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final curveTween = CurveTween(curve: Curves.easeInOut);
            return SlideTransition(
              position: animation.drive(curveTween).drive(tween),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/profile',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ProfilePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final curveTween = CurveTween(curve: Curves.easeInBack);
            return SlideTransition(
              position: animation.drive(curveTween).drive(tween),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/personal-details',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const PersonalDetails(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final curveTween = CurveTween(curve: Curves.easeInBack);
            return SlideTransition(
              position: animation.drive(curveTween).drive(tween),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/academic-edit',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AcademicEditPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final curveTween = CurveTween(curve: Curves.easeInBack);
            return SlideTransition(
              position: animation.drive(curveTween).drive(tween),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/education-edit',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child:  const EducationPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final curveTween = CurveTween(curve: Curves.easeInBack);
            return SlideTransition(
              position: animation.drive(curveTween).drive(tween),
              child: child,
            );
          },
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
