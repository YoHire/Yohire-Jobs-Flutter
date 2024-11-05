import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class YohireLogoWidget extends StatelessWidget {
  const YohireLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 9,
          child: Center(
            child: CachedNetworkImage(
              imageUrl: '',
              width: 250,
              errorWidget: (context, url, error) {
                return Image.asset(
                  'assets/icon/logo-main.png',
                  width: 250,
                );
              },
              placeholder: (BuildContext ctx, String str) {
                return Image.asset(
                  'assets/icon/logo-main.png',
                  width: 250,
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 90,
          child: Text(
            'Be in good company',
            style: textTheme.bodySmall,
          ),
        )
      ],
    );
  }
}
