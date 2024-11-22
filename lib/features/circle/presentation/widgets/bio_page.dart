import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/bottom_sheets/bottomsheet.dart';
import 'package:openbn/core/utils/bottom_sheets/resume_upload_widget.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/text_field.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/circle/presentation/bloc/queue_bloc/queue_bloc.dart';
import 'package:openbn/features/circle/presentation/widgets/join_queue_bottomsheet.dart';
import 'package:openbn/init_dependencies.dart';

class BioPage extends StatefulWidget {
  const BioPage({super.key});

  @override
  State<BioPage> createState() => _BioPageState();
}

class _BioPageState extends State<BioPage> {
  late TextEditingController _bioController;
  late final TextTheme textTheme;
  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            leftHeadingWithSub(
                context: context,
                heading: 'Bio',
                subHeading:
                    'You can format your bio as per the job role you have selected'),
            const ThemeGap(20),
            CustomTextField(
              hint: 'Your Bio',
              maxLength: 500,
              prefixIcon: const Icon(Icons.biotech),
              controller: _bioController,
              border:
                  const OutlineInputBorder(borderSide: BorderSide(width: 0.2)),
            ),
            const Spacer(),
            ThemedButton(
                text: 'Join Queue',
                loading: false,
                onPressed: () {
                  if (_isResumeUploaded()) {
                    _showQueueJoinBottomSheet(context: context);
                  } else {
                    showCustomBottomSheet(
                        heightFactor: 0.6,
                        context: context,
                        content: const ResumeUploadWidget());
                  }
                }),
            const ThemeGap(50)
          ],
        ),
      ),
    );
  }

  bool _isResumeUploaded() {
    final userStorage = serviceLocator<UserStorageService>();
    final userData = userStorage.getUser();
    if (userData!.resume == null || userData.resume!.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  // Bottom sheets
  void _showQueueJoinBottomSheet({required BuildContext context}) {
    final queueBloc = BlocProvider.of<QueueBloc>(context);
    showCustomBottomSheet(
      heightFactor: 0.5,
      context: context,
      content: BlocProvider.value(
        value: queueBloc,
        child:  JoinQueueBottomsheet(bio: _bioController.text,),
      ),
      isScrollControlled: true,
      isScrollable: true,
    );
  }
}
