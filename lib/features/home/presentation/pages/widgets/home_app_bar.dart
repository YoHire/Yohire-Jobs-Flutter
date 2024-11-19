import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/navigation/app_router.dart';
import 'package:openbn/core/theme/app_text_styles.dart';
import 'package:openbn/core/utils/bottom_sheets/bottomsheet.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/yohire_logo_widget.dart';
import 'package:openbn/features/home/presentation/pages/widgets/filter_widget.dart';
import 'package:openbn/init_dependencies.dart';
import '../../bloc/home_bloc/home_bloc.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = serviceLocator<GetStorage>();
    final colorTheme = Theme.of(context).colorScheme;
    TextEditingController searchController = TextEditingController();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const YohireLogoWidget(showTagLine: false),
                storage.read('isLogged') == true
                    ? bellIcon(context)
                    : Hero(
                        tag: 'nav-tag',
                        child: ThemedButton(
                          loading: false,
                          onPressed: () {
                            GoRouter.of(context).go(AppRoutes.auth);
                          },
                          text: 'Login/Register',
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                        ),
                      )
              ],
            ),
            Row(
              children: [
                // Expanded(
                //     child: CustomTextField(
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(width: 0.1),
                //         borderRadius: BorderRadius.circular(50)
                //       ),
                //       prefixIcon: const Icon(Icons.search),
                //         hint: '', controller: searchController)),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: colorTheme.onSurface.withOpacity(0.25),
                          ),
                          BoxShadow(
                            color: colorTheme.surface,
                            spreadRadius: -0.3,
                            blurRadius: 4.0,
                          ),
                        ]),
                    // child: ,
                  ),
                ),
                _buildFilterIcon(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

_buildFilterIcon(BuildContext context) {
  final colorTheme = Theme.of(context).colorScheme;
  return Stack(
    children: [
      IconButton(
          onPressed: () {
            showCustomBottomSheet(
                isScrollControlled: true,
                isScrollable: true,
                context: context,
                heightFactor: 0.55,
                content: const JobFilterWidget());
          },
          icon: Image.asset(
            'assets/icon/filter.png',
            width: 25,
            height: 25,
            color: colorTheme.onSurface,
          )),
      BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (context.read<HomeBloc>().isFiltering) {
            int count = 0;
            if (context.read<HomeBloc>().location.isNotEmpty) {
              count++;
            }
            if (context.read<HomeBloc>().skills.isNotEmpty) {
              count++;
            }
            if (context.read<HomeBloc>().jobRoles.isNotEmpty) {
              count++;
            }
            return Positioned(
                bottom: 4,
                right: 4,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 9,
                  child: Center(
                    child: Text(
                      count.toString(),
                      style: MyTextStyle.whiteBold,
                    ),
                  ),
                ));
          } else {
            return const SizedBox.shrink();
          }
        },
      )
    ],
  );
}

Widget bellIcon(BuildContext context) {
  // NotificationController notificationController =
  //     Get.find<NotificationController>();
  return InkWell(
    onTap: () {
      if (GetStorage().read('notiCount') == 0) {
        // notificationController.checkAndGetNotification();
        GetStorage().write('notiCount', 1);
      }

      // Get.to(const NotificationScreen());
    },
    child: Stack(
      children: [
        Image.asset(
          'assets/icon/notification.png',
          width: 25,
          height: 25,
        ),
        const Positioned(
          right: 0,
          child: CircleAvatar(
            radius: 7,
            backgroundColor: Colors.red,
            child: Text(
              '0',
              // style: MyTextStyle.whiteSmallText,
            ),
          ),
        )
      ],
    ),
  );
}
