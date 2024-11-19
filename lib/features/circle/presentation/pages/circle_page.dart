import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/widgets/floating_action_button.dart';
import 'package:openbn/core/widgets/loader.dart';
import 'package:openbn/core/widgets/placeholders.dart';
import 'package:openbn/features/circle/presentation/bloc/circle_bloc/circle_bloc.dart';
import 'package:openbn/features/circle/presentation/widgets/circle_app_bar.dart';
import 'package:openbn/features/circle/presentation/widgets/queue_card.dart';
import 'package:openbn/init_dependencies.dart';
import 'package:showcaseview/showcaseview.dart';

class CirclePage extends StatefulWidget {
  const CirclePage({super.key});

  @override
  State<CirclePage> createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage> {
  final GlobalKey _firstKey = GlobalKey();
  final storage = serviceLocator<GetStorage>();

  @override
  void initState() {
    super.initState();
    context.read<CircleBloc>().add(FetchQueueEvent());
    final int showcaseCount = storage.read('circleDemoCount') ?? 0;

    if (showcaseCount < 2) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([_firstKey]),
      );
      storage.write('circleDemoCount', showcaseCount + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YohireCircleAppBar(),
      body: _buildBody(context),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomFloatingActionButton(
            backgroundColor: ThemeColors.primaryBlue,
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
            loading: false,
            onPressed: () {
              GoRouter.of(context).push('/create-queue/123');
            },
            isClickable: true),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return BlocConsumer<CircleBloc, CircleState>(
      listener: (context, state) {
        if (state is CircleError) {
          showSimpleSnackBar(
              context: context,
              text: state.message,
              position: SnackBarPosition.BOTTOM,
              isError: true);
        }
      },
      builder: (context, state) {
        if (state is CircleLoading) {
          return const Loader(loaderType: LoaderType.normalLoader);
        } else if (state is CircleLoaded) {
          final data = state.data;
          return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Showcase(
                    key: _firstKey,
                    description: 'Tap on the card to view the queue details',
                    child: QueueCard(
                      data: data[index],
                    ),
                  );
                } else {
                  return QueueCard(
                    data: data[index],
                  );
                }
              });
        } else if (state is CircleError) {
          return AnimatedPlaceholders(
              text: state.message,
              subText:
                  'We are trying our best to fix this, please wait patiently',
              isError: true);
        } else if (state is CircleEmpty) {
          return AnimatedPlaceholders(
            text: '''Join a queue''',
            subText: 'and spotlight yourself',
            isError: false,
            isQueue: true,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
