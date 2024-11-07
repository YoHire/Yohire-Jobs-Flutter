import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/features/prefrences/domain/usecase/create_guest_user.dart';
import 'package:openbn/features/prefrences/domain/usecase/job_roles_usecase.dart';
import 'package:openbn/features/prefrences/domain/usecase/search_job_roles_usecase.dart';
import 'package:openbn/features/prefrences/presentation/bloc/prefrence_event.dart';
import 'package:openbn/features/prefrences/presentation/bloc/prefrence_state.dart';

class PrefrenceBloc extends Bloc<PrefrenceEvent, PrefrenceState> {
  final JobRolesUseCase _jobRolesUseCase;
  final SearchJobRolesUsecase _searchJobRolesUsecase;
  final CreateGuestUserUsecase _createGuestUserUsecase;
  List<JobRoleModel> allJobRoles = [];
  List<JobRoleModel> selectedJobRoles = [];
  PrefrenceBloc(
      {required JobRolesUseCase jobRolesUseCase,
      required SearchJobRolesUsecase searchJobRolesUsecase,
      required CreateGuestUserUsecase createGuestUserUsecase})
      : _jobRolesUseCase = jobRolesUseCase,
        _searchJobRolesUsecase = searchJobRolesUsecase,
        _createGuestUserUsecase = createGuestUserUsecase,
        super(PrefrenceInitial()) {
    on<PrefrenceFetch>(_onPrefrenceFetch);
    on<SearchJobRoles>(_searchJobRoles);
    on<CreateGuestUser>(_createGuestUser);
  }

  Future<void> _onPrefrenceFetch(
      PrefrenceFetch event, Emitter<PrefrenceState> emit) async {
    if (state is! PrefrenceLoaded) {
      emit(PrefrenceLoading());
    }
    if (event.jobRole != null) {
      checkDuplicateAndAdd(jobRole: event.jobRole!);
    }
    final result = await _jobRolesUseCase(event.industry);
    result.fold(
      (failure) {
        emit(PrefrenceError(message: 'Failed to fetch job roles'));
      },
      (success) async {
        allJobRoles = success;
        removeSelectedFromAll();
        emit(PrefrenceLoaded(
            jobRoles: allJobRoles, selectedJobRoles: selectedJobRoles));
      },
    );
  }

  Future<void> _searchJobRoles(
      SearchJobRoles event, Emitter<PrefrenceState> emit) async {
    emit(PrefrenceLoading());
    if (event.keyword.isNotEmpty) {
      final result = await _searchJobRolesUsecase(event.keyword);
      result.fold(
        (failure) {
          emit(PrefrenceError(message: 'Failed to search job roles'));
        },
        (success) {
          allJobRoles = success;
          emit(SearchedPrefrences(jobRoles: allJobRoles));
        },
      );
    } else {
      emit(PrefrenceLoaded(
          jobRoles: allJobRoles, selectedJobRoles: selectedJobRoles));
    }
  }

  Future<void> _createGuestUser(
      CreateGuestUser event, Emitter<PrefrenceState> emit) async {
    emit(PrefrenceLoading());
    final result = await _createGuestUserUsecase(selectedJobRoles.map((e) {
      return e;
    }).toList());
    result.fold(
      (failure) {
        emit(PrefrenceError(message: 'Failed to create guest user'));
      },
      (success) {
        emit(CreatedGuestUser());
      },
    );
  }

  void checkDuplicateAndAdd({required JobRoleModel jobRole}) {
    final index = selectedJobRoles
        .indexWhere((selectedJob) => selectedJob.id == jobRole.id);

    if (index != -1) {
      selectedJobRoles.removeAt(index);
    } else {
      selectedJobRoles.add(jobRole);
    }
  }

  void removeSelectedFromAll() {
    if (selectedJobRoles.isEmpty) {
      return;
    }
    allJobRoles.removeWhere((jobRole) =>
        selectedJobRoles.any((selected) => selected.id == jobRole.id));
  }
}
