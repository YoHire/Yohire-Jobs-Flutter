import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:openbn/core/widgets/theme_gap.dart';

class GettingJobsForYou extends StatefulWidget {
  final String redirectPath;
  const GettingJobsForYou({super.key,required this.redirectPath});

  @override
  _GettingJobsForYouState createState() => _GettingJobsForYouState();
}

class _GettingJobsForYouState extends State<GettingJobsForYou> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      GoRouter.of(context).go('/${widget.redirectPath}');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/searching.json'),
            Text(
              'Finding the right jobs for you',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const ThemeGap(5),
            Text(
              'takes a few seconds',
              style: textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
