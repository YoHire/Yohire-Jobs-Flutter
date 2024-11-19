import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/remote_config/remote_config_service.dart';

class YohireLogoWidget extends StatelessWidget {
  final bool showTagLine;
  const YohireLogoWidget({super.key, required this.showTagLine});

  @override
  Widget build(BuildContext context) {
    final remoteConfig = FirebaseRemoteConfigService();
    return CachedNetworkImage(
      imageUrl: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? remoteConfig.getString(FirebaseRemoteConfigKeys.home_icon_dark)
          : remoteConfig.getString(FirebaseRemoteConfigKeys.home_icon),
      width: showTagLine ? 250 : 150,
      errorWidget: (context, url, error) {
        return Image.asset(
          !showTagLine
              ? 'assets/icon/logo-notag.png'
              : MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? 'assets/icon/logo-main-dark.png'
                  : 'assets/icon/logo-main.png',
          width: showTagLine ? 250 : 100,
        );
      },
      placeholder: (BuildContext ctx, String str) {
        return Image.asset(
            !showTagLine
                ? 'assets/icon/logo-notag.png'
                : MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? 'assets/icon/logo-main-dark.png'
                    : 'assets/icon/logo-main.png',
            width: showTagLine ? 250 : 100);
      },
    );
  }
}
