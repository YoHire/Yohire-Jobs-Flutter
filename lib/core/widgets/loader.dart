import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:openbn/core/utils/constants/constants.dart';

class Loader extends StatelessWidget {
  final LoaderType loaderType;
  const Loader({super.key, required this.loaderType});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (loaderType == LoaderType.jobLoader) {
      return Stack(
        children: [
          Lottie.asset('assets/lottie/home-loading.json',
              width: 500, height: 500),
          Padding(
            padding: const EdgeInsets.only(top: 320),
            child: Align(
              alignment: Alignment.topCenter,
              child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                TypewriterAnimatedText('Loading Jobs',
                    textStyle: textTheme.labelMedium)
              ]),
            ),
          )
        ],
      );
    } else if (loaderType == LoaderType.fileLoader) {
      return Stack(
        children: [
          Lottie.asset('assets/lottie/file-loading.json',
              width: 500, height: 500),
          Padding(
            padding: const EdgeInsets.only(top: 320),
            child: Align(
              alignment: Alignment.topCenter,
              child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                TypewriterAnimatedText('Loading File',
                    textStyle: textTheme.labelMedium)
              ]),
            ),
          )
        ],
      );
    } else {
      return Lottie.asset('assets/lottie/linear-loading.json',width: 150,height: 80);
    }
  }
}
