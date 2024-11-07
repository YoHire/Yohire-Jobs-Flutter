import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/theme_gap.dart';

class JobApplyConfirmationBottomSheet extends StatefulWidget {
  const JobApplyConfirmationBottomSheet({super.key});

  @override
  State<JobApplyConfirmationBottomSheet> createState() =>
      _JobApplyConfirmationBottomSheetState();
}

class _JobApplyConfirmationBottomSheetState
    extends State<JobApplyConfirmationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: 1 + 1 == 3
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: screenHeight * 0.3,
                  width: screenWidth * 0.6,
                  child: 1 + 1 == 3
                      ? Lottie.asset(
                          'assets/lottie/success.json',
                          reverse: true,
                        )
                      : Lottie.asset('assets/lottie/loading.json',
                          repeat: true, reverse: true),
                ),
                Text(
                  1 + 1 == 3
                      ? 'Application Successful'
                      : 'Securing Your Application !',
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    width: 350,
                    child: Text(
                      1 + 1 == 3 ? '' : 'Please wait',
                      style: textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    )),
                const ThemeGap(60),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: screenHeight * 0.3,
                  width: screenWidth * 0.6,
                  child: Lottie.asset('assets/lottie/apply-job.json',
                      repeat: false),
                ),
                Text(
                  'You are about to apply for this job',
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    width: 350,
                    child: Text(
                      'All the details you have added in your profile will be sent to the employer',
                      style: textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    )),
                const ThemeGap(10),
                ThemedButton(loading: false, text: 'Apply', onPressed: () {}),
                const ThemeGap(30)
              ],
            ),
    );
  }
}
