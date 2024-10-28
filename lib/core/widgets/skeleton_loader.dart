import 'package:flutter/material.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader extends StatelessWidget {
  final double height;
  final double width;
  final bool isJob;
  const SkeletonLoader(
      {super.key,
      required this.height,
      required this.width,
      required this.isJob});

  @override
  Widget build(BuildContext context) {
    return isJob
        ? jobSkeleton(context)
        : Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.white,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Container(
                  height: height * 0.8,
                  width: width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          );
  }

  Widget jobSkeleton(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: colorTheme.surface,
          boxShadow: [
            BoxShadow(
              color: colorTheme.onSurface.withOpacity(0.25),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.white,
                child: Container(
                  height: 10,
                  width: MediaQuery.of(context).size.width *0.75,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                )),
            const ThemeGap(10),
            Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.white,
                child: Container(
                  height: 10,
                  width: MediaQuery.of(context).size.width - 250,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                )),
            const ThemeGap(10),
            Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.white,
                child: Container(
                  height: 10,
                  width: MediaQuery.of(context).size.width - 300,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
