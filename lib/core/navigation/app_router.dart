import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/features/auth/presentation/pages/google_auth_page.dart';
import 'package:openbn/features/auth/presentation/pages/otp_verify_page.dart';
import 'package:openbn/features/prefrences/presentation/pages/prefrence_page.dart';
import 'package:openbn/features/splash/presentation/pages/splash_screen.dart';

import '../../features/main_navigation/presentation/pages/main_navigation_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/prefrences',
        builder: (context, state) => const PrefrencesScreen(),
      ),
      GoRoute(
        path: '/navigation_bar',
        builder: (context, state) => const MainNavigationPage(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const GoogleAuthPage(),
      ),
      GoRoute(
        path: '/otp_page',
        builder: (context, state) => const OtpVerifyPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.error.toString()}'),
      ),
    ),
  );
}
