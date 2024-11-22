import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/circle/presentation/bloc/circle_bloc/circle_bloc.dart';
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
      listener: (context, state) async{
        if (state is QueueError) {
          if (ModalRoute.of(context)?.isCurrent == false) {
            Navigator.pop(context);
          }
          showSimpleSnackBar(
              context: context,
              text: state.error,
              position: SnackBarPosition.BOTTOM,
              isError: true);
        }
        if (state is QueueJoined) {
          await Future.delayed(const Duration(seconds: 2));
          if (ModalRoute.of(context)?.isCurrent == false) {
            Navigator.pop(context);
          }
          context.read<CircleBloc>().add(FetchQueueEvent());
          Navigator.pop(context);
          showSimpleSnackBar(
              context: context,
              text: 'Joined Queue Successfully',
              position: SnackBarPosition.BOTTOM,
              isError: false);
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
