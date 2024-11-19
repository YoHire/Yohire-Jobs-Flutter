import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/theme_gap.dart';

import '../bloc/queue_bloc/queue_bloc.dart';

class JoinQueueBottomsheet extends StatelessWidget {
  const JoinQueueBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<QueueBloc, QueueState>(
      builder: (context, state) {
        return Column(
          children: [
            state is QueueJoined
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.3,
                        width: screenWidth,
                        child: Lottie.asset('assets/lottie/plane.json',
                            repeat: true, reverse: true),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                        child: Text(
                          '''Success''',
                          style: textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const ThemeGap(10),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                        child: Text(
                          '''Countdown begins, for your employment jounery''',
                          style: textTheme.labelSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.2,
                        width: screenWidth * 0.6,
                        child: Lottie.asset('assets/lottie/all_set.json'),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                        child: Text(
                          '''All set''',
                          style: textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                        child: Text(
                          '''Let's create a fresh start''',
                          style: textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                        child: Text(
                          '''you are about to send your profile to recruiters and employers worldwide''',
                          style: textTheme.labelMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      state is QueueJoining
                          ? const Padding(
                              padding: EdgeInsets.only(left: 60, right: 60),
                              child: LinearProgressIndicator(),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.15),
                              child: ThemedButton(
                                text: 'Join queue',
                                loading: false,
                                onPressed: () async {
                                  context.read<QueueBloc>().add(JoinQueue());
                                },
                              ),
                            ),
                    ],
                  )
          ],
        );
      },
    );
  }
}
