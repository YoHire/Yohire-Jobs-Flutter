import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/navigation/app_router.dart';
import 'package:openbn/core/utils/shared_services/functions/logout.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/profile/presentation/widgets/custom_container_builder.dart';
import 'package:openbn/features/profile/presentation/widgets/profile_tile_widget.dart';
import 'package:openbn/init_dependencies.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = serviceLocator<GetStorage>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ProfileTileWidget(),
                const ThemeGap(10),
                storage.read('isLogged') != null
                    ? ThemedButton(
                        text: 'Edit Profile',
                        loading: false,
                        onPressed: () {
                          GoRouter.of(context).push(AppRoutes.profileSection);
                        })
                    : ThemedButton(
                        text: 'Login',
                        loading: false,
                        onPressed: () {
                          GoRouter.of(context).push(AppRoutes.auth);
                        }),
                const ThemeGap(10),

                storage.read('isLogged') != null
                    ? CustomContainerBuilder(title: 'Your Activity', items: [
                        ContainerBuilderItem(
                            icon: const Icon(Icons.bookmark_added_outlined),
                            onTap: () {
                              GoRouter.of(context).push(AppRoutes.saved);
                            },
                            title: 'Saved Jobs'),
                        ContainerBuilderItem(
                            icon: const Icon(Icons.description_outlined),
                            onTap: () {
                              GoRouter.of(context).push(AppRoutes.applied);
                            },
                            title: 'Applied Jobs')
                      ])
                    : const SizedBox.shrink(),
                const ThemeGap(20),
                CustomContainerBuilder(title: 'Prefrences', items: [
                  ContainerBuilderItem(
                    icon: const Icon(Icons.privacy_tip_outlined),
                    onTap: () {
                      GoRouter.of(context).push(AppRoutes.userAgreements);
                    },
                    title: 'User Agreements',
                  ),
                  ContainerBuilderItem(
                    icon: const Icon(Icons.question_answer_outlined),
                    onTap: () {
                      GoRouter.of(context).push(AppRoutes.faq);
                    },
                    title: 'FAQs',
                  ),
                  ContainerBuilderItem(
                    icon: Icon(
                      storage.read('isLogged') != null
                          ? Icons.logout_outlined
                          : Icons.login,
                      color: storage.read('isLogged') != null
                          ? const Color.fromARGB(255, 159, 37, 28)
                          : Colors.green,
                    ),
                    onTap: () async {
                      if (storage.read('isLogged') != null) {
                        await logoutUser(context);
                      } else {
                        GoRouter.of(context).push(AppRoutes.auth);
                      }
                    },
                    title:
                        storage.read('isLogged') != null ? 'Logout' : 'Login',
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
