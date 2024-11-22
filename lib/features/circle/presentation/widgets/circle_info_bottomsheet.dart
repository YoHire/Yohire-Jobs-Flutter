import 'package:flutter/material.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/widgets/theme_gap.dart';

class CircleInfoBottomsheet extends StatelessWidget {
  const CircleInfoBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const ThemeGap(20),
          Image.asset(
            'assets/icon/yohire_circle.png',
            width: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Join the Circle and Get Noticed!',
                      style: textTheme.bodyMedium!
                          .copyWith(color: ThemeColors.primaryBlue),
                      textAlign: TextAlign.center,
                    )),
                const ThemeGap(10),
                Text(
                  '''Circle is your shortut to dream jobs. Here's how it works ''',
                  style: textTheme.bodyMedium!
                      .copyWith(color: ThemeColors.primaryBlue),
                  textAlign: TextAlign.center,
                ),
                const ThemeGap(10),
                bulletPoints('Choose Your Circle',
                    '''Pick the job role you're looking for.''', context),
                bulletPoints('Join the queue',
                    '''Become part of the Circle for that job.''', context),
                bulletPoints(
                    'Get Seen by Employers',
                    '''We'll highlight your profile to potential employers worldwide.''',
                    context),
                bulletPoints('Check Your Progress',
                    '''See how your Circle is performing.''', context),
                bulletPoints(
                    'Receive Invitations',
                    '''Employers will contact you directly if they're interested..''',
                    context),
                const ThemeGap(20),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Ready to join the Circle and start your job search journey?',
                      style: textTheme.bodyMedium!
                          .copyWith(color: ThemeColors.primaryBlue),
                      textAlign: TextAlign.center,
                    )),
                const ThemeGap(20),
                // Align(
                //     alignment: Alignment.center,
                //     child: blueDepthButton(
                //         text: GetStorage().read('isLogged') == null
                //             ? 'Register and join queues'
                //             : 'Join queues',
                //         disabled: false,
                //         onPressed: () {
                //           GetStorage().read('isLogged') == null
                //               ? Get.to(() => GoogleAuthScreen())
                //               : yohireCircleController
                //                   .checkAndStartQueueCreation();
                //         }))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget bulletPoints(String point, String explaination, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Image.asset(
              'assets/icon/dot.png',
              width: 5,
              height: 5,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: '$point : ',
                    style: textTheme.bodyMedium,
                    children: <TextSpan>[
                      TextSpan(
                        text: explaination,
                        style: textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
