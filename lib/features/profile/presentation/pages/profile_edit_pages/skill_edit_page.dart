import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/core/utils/shared_services/skills/skills_service.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/search_select_field.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/profile/presentation/bloc/profile_bloc.dart';

class SkillEditPage extends StatefulWidget {
  final List<SkillModel> skill;
  const SkillEditPage({super.key, required this.skill});

  @override
  State<SkillEditPage> createState() => _SkillEditPageState();
}

class _SkillEditPageState extends State<SkillEditPage> {
  @override
  void initState() {
    super.initState();
    _selectedSkills.addAll(widget.skill);
  }

  List<SkillModel> _selectedSkills = [];
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is SkillUpdateSuccess) {
          Navigator.of(context).pop();
          showSimpleSnackBar(
              context: context,
              text: 'Skill updated Successful',
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
            SearchSelectField<SkillModel>(
              hint: 'Search Skills',
              prefixIcon: const Icon(Icons.space_dashboard_rounded),
              fetchData: UserSkillService().searchSkills,
              displayText: (skill) => skill.name,
              selectedData: _selectedSkills,
              onSelectionChanged: (skills) {
                setState(() {
                  _selectedSkills = skills;
                });
              },
            ),
            const ThemeGap(10),
            ThemedButton(
                text: 'Update Skills',
                loading: false,
                onPressed: () {
                  context
                      .read<ProfileBloc>()
                      .add(UpdateSkillEvent(data: _selectedSkills));
                })
          ],
        ),
      ),
    );
  }
}
