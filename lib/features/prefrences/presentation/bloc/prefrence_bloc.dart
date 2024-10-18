import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/features/prefrences/domain/usecase/create_guest_user.dart';
import 'package:openbn/features/prefrences/domain/usecase/job_roles_usecase.dart';
import 'package:openbn/features/prefrences/domain/usecase/search_job_roles_usecase.dart';
import 'package:openbn/features/prefrences/presentation/bloc/prefrence_event.dart';
import 'package:openbn/features/prefrences/presentation/bloc/prefrence_state.dart';
import 'package:openbn/features/prefrences/presentation/models/job_role_model.dart';

class PrefrenceBloc extends Bloc<PrefrenceEvent, PrefrenceState> {
  final JobRolesUseCase _jobRolesUseCase;
  final SearchJobRolesUsecase _searchJobRolesUsecase;
  final CreateGuestUserUsecase _createGuestUserUsecase;
  List<JobRoleViewModel> allJobRoles = [];
  List<JobRoleViewModel> selectedJobRoles = [];
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
      (success) {
        allJobRoles = success
            .map((jobRole) => JobRoleViewModel(
                  id: jobRole.id,
                  name: jobRole.name!,
                  industry: jobRole.industry!,
                ))
            .toList();
        removeSelectedFromAll();
        emit(PrefrenceLoaded(
            jobRoles: allJobRoles, selectedJobRoles: selectedJobRoles));
      },
    );
  }

  Future<void> _searchJobRoles(
      SearchJobRoles event, Emitter<PrefrenceState> emit) async {
    emit(PrefrenceLoading());
    final result = await _searchJobRolesUsecase(event.keyword);
    result.fold(
      (failure) {
        emit(PrefrenceError(message: 'Failed to search job roles'));
      },
      (success) {
        allJobRoles = success
            .map((jobRole) => JobRoleViewModel(
                  id: jobRole.id,
                  name: jobRole.name!,
                  industry: jobRole.industry!,
                ))
            .toList();
        emit(SearchedPrefrences(jobRoles: allJobRoles));
      },
    );
  }

  Future<void> _createGuestUser(
      CreateGuestUser event, Emitter<PrefrenceState> emit) async {
    emit(PrefrenceLoading());
    final result = await _createGuestUserUsecase(selectedJobRoles.map((e) {
      return e.toDomain();
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

  void checkDuplicateAndAdd({required JobRoleViewModel jobRole}) {
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
