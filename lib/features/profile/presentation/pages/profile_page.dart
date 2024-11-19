import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/navigation/app_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton.icon(
          label: const Text('Complete Profile'),
          onPressed: () {
            GoRouter.of(context).push(AppRoutes.profileSection);
          },
          icon: const Icon(Icons.account_balance),
        ),
      ),
    );
  }
}
