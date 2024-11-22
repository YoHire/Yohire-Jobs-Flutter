import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/bottom_sheets/bottomsheet.dart';
import 'package:openbn/core/utils/shared_services/models/language/language_model.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/core/widgets/app_bar.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:openbn/features/profile/presentation/pages/profile_edit_pages/language_edit_widget.dart';
import 'package:openbn/init_dependencies.dart';

class LanguageWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const LanguageWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            onTap!();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Updated LanguagesShowcasePage
class LanguagesShowcasePage extends StatefulWidget {
  const LanguagesShowcasePage({super.key});

  @override
  State<LanguagesShowcasePage> createState() => _LanguagesShowcasePageState();
}

class _LanguagesShowcasePageState extends State<LanguagesShowcasePage> {
  final List<LanguageModel> _languagesReadWrite = [];
  final List<LanguageModel> _languagesSpeak = [];

  @override
  void initState() {
    super.initState();
    _assignAllData();
  }

  _assignAllData() async {
    final ref = serviceLocator<UserStorageService>();
    await ref.updateUser();
    final data = ref.getUser();
    _languagesReadWrite.clear();
    _languagesSpeak.clear();
    _languagesReadWrite.addAll(data!.languagesReadAndWrite);
    _languagesSpeak.addAll(data.languagesSpeak);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
       if(state is LanguageReadWriteUpdateSuccess || state is LanguageSpeakUpdateSuccess){
        _assignAllData();
       }
      },
      child: Scaffold(
        appBar: customAppBar(context: context, title: 'Languages'),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              LanguageWidget(
                onTap: () {
                  showCustomBottomSheet(
                      heightFactor: 0.4,
                      context: context,
                      content: LanguageEditWidget(
                          isReadWrite: true,
                          languageList: _languagesReadWrite));
                },
                title: 'Languages Read and Write',
              ),
              const ThemeGap(10),
              LanguageWidget(
                onTap: () {
                  showCustomBottomSheet(
                      heightFactor: 0.4,
                      context: context,
                      content: LanguageEditWidget(
                          isReadWrite: false, languageList: _languagesSpeak));
                },
                title: 'Languages Speak',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
