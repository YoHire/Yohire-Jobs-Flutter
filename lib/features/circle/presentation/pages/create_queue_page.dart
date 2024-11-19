import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/circle/presentation/bloc/queue_bloc/queue_bloc.dart';
import 'package:openbn/features/circle/presentation/widgets/bio_page.dart';
import 'package:openbn/features/circle/presentation/widgets/queue_edit1.dart';
import 'package:openbn/features/circle/presentation/widgets/queue_edit2.dart';
import 'package:openbn/features/circle/presentation/widgets/queue_edit3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class QueueCreationPage extends StatelessWidget {
  final String? id;
  const QueueCreationPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<QueueBloc, QueueState>(
      listener: (context, state) {
        if(state is QueueError){
          showSimpleSnackBar(context: context, text: state.error, position: SnackBarPosition.TOP, isError: true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            id == null ? 'Create Queue' : 'Update Queue Info',
            style: textTheme.bodyMedium,
          ),
        ),
        body: Column(
          children: [
            const ThemeGap(30),
            SmoothPageIndicator(
                controller: context.read<QueueBloc>().pageController,
                count: 4,
                effect: WormEffect(
                    activeDotColor: Colors.black,
                    radius: 10,
                    dotHeight: 5,
                    dotWidth: MediaQuery.of(context).size.width / 7.3),
                onDotClicked: (index) {}),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: context.read<QueueBloc>().pageController,
                children: const <Widget>[
                  QueueEdit1(),
                  QueueEdit2(),
                  QueueEdit3(),
                  BioPage()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
