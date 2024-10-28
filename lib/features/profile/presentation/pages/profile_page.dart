import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton.icon(
          label: const Text('Complete Profile'),
          onPressed: () {
            GoRouter.of(context).push('/profile-section');
          },
          icon: const Icon(Icons.account_balance),
        ),
      ),
    );
  }
}
