import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedPlaceholders extends StatelessWidget {
  final String text;
  final String subText;
  final bool isError;
  const AnimatedPlaceholders(
      {super.key,
      required this.text,
      required this.subText,
      required this.isError});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(40),
            child: isError
                ? Lottie.asset('assets/lottie/error.json')
                : Lottie.asset('assets/lottie/empty-jobs.json'),
          ),
          Positioned(
              bottom: 0,
              right: 50,
              left: 50,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: isError
                    ? Column(
                        children: [
                          Text(
                            text,
                            style: textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            subText,
                            style: textTheme.labelMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Text(
                            text,
                            style: textTheme.bodyLarge,
                             textAlign: TextAlign.center,
                          ),
                          Text(
                            subText,
                            style: textTheme.labelMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
              ))
        ],
      ),
    );
  }
}