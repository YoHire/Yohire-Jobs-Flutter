import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/utils/bottom_sheets/bottomsheet.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/features/home/presentation/pages/widgets/filter_widget.dart';
import 'package:openbn/init_dependencies.dart';
import '../../../../../core/utils/constants/constants.dart';
import '../../../../../core/utils/urls.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = serviceLocator<GetStorage>();
    final colorTheme = Theme.of(context).colorScheme;
    TextEditingController searchController = TextEditingController();
    // Debouncer debouncer = Debouncer(milliseconds: 1000);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CachedNetworkImage(
                  imageUrl: remoteConfig
                      .getString(FirebaseRemoteConfigKeys.home_icon),
                  width: 130,
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      'assets/icon/logo-main.png',
                      width: 130,
                    );
                  },
                  placeholder: (BuildContext ctx, String str) {
                    return Image.asset(
                      'assets/icon/logo-main.png',
                      width: 130,
                    );
                  },
                ),
                storage.read('isLogged') == true
                    ? bellIcon(context)
                    : Hero(
                        tag: 'nav-tag',
                        child: ThemedButton(
                          loading: false,
                          onPressed: () {
                            GoRouter.of(context).go('/auth');
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
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showCustomBottomSheet(
                        isScrollControlled: true,
                        isScrollable: true,
                          context: context, content: const JobFilterWidget());
                    },
                    icon: Image.asset(
                      'assets/icon/filter.png',
                      width: 25,
                      height: 25,
                      color: colorTheme.onSurface,
                    )),
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
