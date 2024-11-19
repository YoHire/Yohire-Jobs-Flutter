import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:openbn/core/navigation/app_router.dart';

// Core imports
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/models/experience/workexperience_model.dart';
import 'package:openbn/core/utils/shared_services/models/user/user_model.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/core/widgets/app_bar.dart';
import 'package:openbn/core/widgets/floating_action_button.dart';
import 'package:openbn/core/widgets/placeholders.dart';

// Feature imports
import 'package:openbn/features/profile/presentation/widgets/experience_container.dart';
import 'package:openbn/init_dependencies.dart';

class ExperienceEditPage extends StatefulWidget {
  const ExperienceEditPage({super.key});

  @override
  State<ExperienceEditPage> createState() => _ExperienceEditPageState();
}

class _ExperienceEditPageState extends State<ExperienceEditPage> {
  // Constants
  static const double _padding = 15.0;
  static const String _boxName = 'userBox';
  static const String _addExperienceRoute = AppRoutes.workExperienceEdit;

  // State variables
  late final Box<UserModel> _userBox;
  late final Stream<BoxEvent> _boxStream;
  final List<WorkExperienceModel> _experienceData = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await _initHiveBox();
      _setupHiveListener();
      _loadInitialData();
    } catch (e) {
      log('Error initializing data: $e');
    }
  }

  Future<void> _initHiveBox() async {
    _userBox = Hive.box<UserModel>(_boxName);
  }

  void _setupHiveListener() {
    _boxStream = _userBox.watch();
    _boxStream.listen(_onBoxEvent);
  }

  void _onBoxEvent(BoxEvent event) {
    if (mounted) {
      setState(() {
        _experienceData.clear();
        _experienceData.addAll((event.value as UserModel).experience);
      });
    }
  }

  void _loadInitialData() {
    try {
      final userStorage = serviceLocator<UserStorageService>();
      final userData = userStorage.getUser();

      if (userData != null) {
        setState(() {
          _experienceData.clear();
          _experienceData.addAll(userData.experience);
        });
      }
    } catch (e) {
      log('Error loading initial data: $e');
      // Handle error appropriately
    }
  }

  void _navigateToAddExperience(BuildContext context) {
    context.push(_addExperienceRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return customAppBar(
      context: context,
      title: 'Experience Details',
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(_padding),
      child:
          _experienceData.isEmpty ? _buildEmptyState() : _buildExperienceList(),
    );
  }

  Widget _buildEmptyState() {
    return  AnimatedPlaceholders(
        text: ''' Haven't added experience details yet ''',
        subText: 'Click the plus icon and add',
        isError: false);
  }

  Widget _buildExperienceList() {
    return ListView.builder(
      itemCount: _experienceData.length,
      itemBuilder: (context, index) {
        return ExperienceContainer(
          key: ValueKey(_experienceData[index].hashCode),
          data: _experienceData[index],
        );
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return CustomFloatingActionButton(
      onPressed: () => _navigateToAddExperience(context),
      backgroundColor: ThemeColors.primaryBlue,
      icon: const Icon(Icons.add),
      loading: false,
      isClickable: true,
    );
  }

  @override
  void dispose() {
    // Add any cleanup if needed
    super.dispose();
  }
}
