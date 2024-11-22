import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/language/language_services.dart';
import 'package:openbn/core/utils/shared_services/models/language/language_model.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/search_select_field.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/profile/presentation/bloc/profile_bloc.dart';

class LanguageEditWidget extends StatefulWidget {
  final List<LanguageModel> languageList;
  final bool isReadWrite;
  const LanguageEditWidget(
      {super.key, required this.languageList, required this.isReadWrite});

  @override
  State<LanguageEditWidget> createState() => _LanguageEditWidgetState();
}

class _LanguageEditWidgetState extends State<LanguageEditWidget> {
  @override
  void initState() {
    super.initState();
    _selectedLanguage.addAll(widget.languageList);
  }

  List<LanguageModel> _selectedLanguage = [];
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is LanguageReadWriteUpdateSuccess ||
            state is LanguageSpeakUpdateSuccess) {
          Navigator.of(context).pop();
          showSimpleSnackBar(
              context: context,
              text: 'Language Prefrences updated Successfully',
              position: SnackBarPosition.BOTTOM,
              isError: false);
        }
        if (state is UpdateError) {
          Navigator.of(context).pop();
          showSimpleSnackBar(
              context: context,
              text: 'Something went wrong please try again later',
              position: SnackBarPosition.BOTTOM,
              isError: true);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SearchSelectField<LanguageModel>(
              hint: 'Search Languages',
              prefixIcon: const Icon(Icons.work),
              fetchData: LanguageService().searchLanguages,
              displayText: (language) => language.name,
              selectedData: _selectedLanguage,
              onSelectionChanged: (language) {
                setState(() {
                  _selectedLanguage = language;
                });
              },
            ),
            const ThemeGap(10),
            ThemedButton(
                text: 'Update',
                loading: false,
                onPressed: () {
                  if (widget.isReadWrite) {
                    context
                        .read<ProfileBloc>()
                        .add(UpdateLanguageReadwrite(data: _selectedLanguage));
                  } else {
                    context
                        .read<ProfileBloc>()
                        .add(UpdateLanguageSpeak(data: _selectedLanguage));
                  }
                })
          ],
        ),
      ),
    );
  }
}
