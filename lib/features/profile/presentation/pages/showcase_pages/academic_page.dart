import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:openbn/core/navigation/app_router.dart';

// Core imports
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/models/education/education_model.dart';
import 'package:openbn/core/utils/shared_services/models/user/user_model.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/core/widgets/app_bar.dart';
import 'package:openbn/core/widgets/floating_action_button.dart';
import 'package:openbn/core/widgets/placeholders.dart';

// Feature imports
import 'package:openbn/features/profile/presentation/widgets/education_container.dart';
import 'package:openbn/init_dependencies.dart';

class AcademicEditPage extends StatefulWidget {
  const AcademicEditPage({super.key});

  @override
  State<AcademicEditPage> createState() => _AcademicEditPageState();
}

class _AcademicEditPageState extends State<AcademicEditPage> {
  // Constants
  static const double _padding = 15.0;
  static const String _boxName = 'userBox';
  static const String _addEducationRoute =AppRoutes.educationEdit;

  // State variables
  late final Box<UserModel> _userBox;
  late final Stream<BoxEvent> _boxStream;
  final List<EducationModel> _educationData = [];

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
        _educationData.clear();
        _educationData.addAll((event.value as UserModel).education);
      });
    }
  }

  void _loadInitialData() {
    try {
      final userStorage = serviceLocator<UserStorageService>();
      final userData = userStorage.getUser();

      if (userData != null) {
        setState(() {
          _educationData.clear();
          _educationData.addAll(userData.education);
        });
      }
    } catch (e) {
      log('Error loading initial data: $e');
      // Handle error appropriately
    }
  }

  void _navigateToAddEducation(BuildContext context) {
    context.push(_addEducationRoute);
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
      title: 'Academic Details',
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(_padding),
      child:
          _educationData.isEmpty ? _buildEmptyState() : _buildEducationList(),
    );
  }

  Widget _buildEmptyState() {
    return  AnimatedPlaceholders(
        text: ''' Haven't added academic details yet ''',
        subText: 'Click the plus icon and add',
        isError: false);
  }

  Widget _buildEducationList() {
    return ListView.builder(
      itemCount: _educationData.length,
      itemBuilder: (context, index) {
        return EducationContainer(
          key: ValueKey(_educationData[index].hashCode),
          data: _educationData[index],
        );
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return CustomFloatingActionButton(
      onPressed: () => _navigateToAddEducation(context),
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
