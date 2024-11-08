import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/shared_services/job_roles/jobrole_service.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/core/utils/shared_services/skills/skills_service.dart';
import 'package:openbn/core/validators/text_validators.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/search_select_field.dart';
import 'package:openbn/core/widgets/text_field.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/home/presentation/bloc/home_bloc/home_bloc.dart';

class JobFilterWidget extends StatefulWidget {
  const JobFilterWidget({
    super.key,
  });

  @override
  State<JobFilterWidget> createState() => _JobFilterWidgetState();
}

class _JobFilterWidgetState extends State<JobFilterWidget> {
  static const double _padding = 15.0;
  static const double _borderRadius = 9.0;
  static const double _spacing = 20.0;

  final TextEditingController _addressController = TextEditingController();
  List<SkillModel> _selectedSkills = [];
  List<JobRoleModel> _selectedJobRoles = [];

  final JobroleService _jobRoleService = JobroleService();
  final UserSkillService _skillService = UserSkillService();

  bool _hasFilters = false;

  @override
  void initState() {
    super.initState();
    _loadSkillsAndJobRoles();
    if (_addressController.text.isNotEmpty ||
        _selectedSkills.isNotEmpty ||
        _selectedJobRoles.isNotEmpty) {
      _hasFilters = true;
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    context.read<HomeBloc>().add(FilterJobsEvent(
        location: _addressController.text,
        skillIds: _selectedSkills,
        jobRolesIds: _selectedJobRoles));
    Navigator.of(context).pop();
  }

  void _loadSkillsAndJobRoles() {
    _addressController.text = BlocProvider.of<HomeBloc>(context).location;
    _selectedSkills.addAll(BlocProvider.of<HomeBloc>(context).skills);
    _selectedJobRoles.addAll(BlocProvider.of<HomeBloc>(context).jobRoles);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildHeader(context),
          const ThemeGap(10),
          _buildLocationField(),
          const ThemeGap(_spacing),
          _buildSkillsField(),
          const ThemeGap(_spacing),
          _buildJobRolesField(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      'Filter Jobs',
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _buildLocationField() {
    return CustomTextField(
      hint: 'Job Location',
      validator: TextValidators.addressValidator,
      controller: _addressController,
      prefixIcon: const Icon(
        Icons.location_on,
        color: Colors.red,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: const BorderSide(width: 0.4),
      ),
      isLocationPicker: true,
    );
  }

  Widget _buildSkillsField() {
    return SearchSelectField<SkillModel>(
      hint: 'Search Skills',
      prefixIcon: const Icon(Icons.space_dashboard_rounded),
      fetchData: _skillService.searchSkills,
      displayText: (skill) => skill.name,
      selectedData: _selectedSkills,
      onSelectionChanged: (skills) {
        setState(() {
          _selectedSkills = skills; // Simply assign the new list
        });
      },
    );
  }

  Widget _buildJobRolesField() {
    return SearchSelectField<JobRoleModel>(
      hint: 'Search Job Role',
      prefixIcon: const Icon(Icons.work),
      fetchData: _jobRoleService.searchJobRoles,
      displayText: (role) => role.name!,
      selectedData: _selectedJobRoles,
      onSelectionChanged: (roles) {
        setState(() {
          _selectedJobRoles = roles;
        });
      },
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ThemedButton(
          text: 'Clear Filters',
          loading: false,
          onPressed: _hasFilters
              ? () {
                  _hasFilters = false;
                  context.read<HomeBloc>().add(ResetFilter());
                  Navigator.of(context).pop();
                }
              : null,
          disabled: !_hasFilters,
        ),
        ThemedButton(
          text: 'Apply Filters',
          loading: false,
          onPressed: _applyFilters,
        ),
      ],
    );
  }
}
