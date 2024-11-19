import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/features/home/domain/usecase/filter_jobs_usecase.dart';
import 'package:openbn/features/home/domain/usecase/get_jobs_usecase.dart';
import 'package:openbn/features/home/domain/usecase/get_more_jobs_usecase.dart';
import 'package:openbn/features/home/domain/usecase/save_job_usecase.dart';
import 'package:openbn/features/home/domain/usecase/unsave_job_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllJobsUsecase _allJobsUsecase;
  final GetMoreJobsUsecase _moreJobsUsecase;
  final FilterJobsUsecase _filterJobsUsecase;
  final SaveJobUsecase _saveJobUsecase;
  final UnSaveJobUsecase _unsaveJobUsecase;
  HomeBloc({
    required GetAllJobsUsecase allJobsUsecase,
    required GetMoreJobsUsecase moreJobsUsecase,
    required FilterJobsUsecase filterJobsUsecase,
    required SaveJobUsecase saveJobUsecase,
    required final UnSaveJobUsecase unsaveJobUsecase,
  })  : _allJobsUsecase = allJobsUsecase,
        _moreJobsUsecase = moreJobsUsecase,
        _filterJobsUsecase = filterJobsUsecase,
        _saveJobUsecase = saveJobUsecase,
        _unsaveJobUsecase = unsaveJobUsecase,
        super(HomeInitial()) {
    on<HomeInitEvent>(_jobsFetch);
    on<LoadMoreJobs>(_moreJobsFetch);
    on<FilterJobsEvent>(_filterJobs);
    on<ResetFilter>(_resetFilter);
    on<SaveJob>(_handleSaveJob);
    on<UnsaveJob>(_handleUnsaveJob);
  }

  List<JobEntity> allJobs = [];
  List<SkillModel> skills = [];
  List<JobRoleModel> jobRoles = [];
  List<String> savedJobsCache = [];
  List<String> unSavedJobsCache = [];
  String location = '';
  bool isFiltering = false;
  int skip = 0;

  Future<void> _jobsFetch(HomeInitEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    skip = 0;
    savedJobsCache.clear();
    unSavedJobsCache.clear();
    _clearFilter();
    final result = await _allJobsUsecase('');
    result.fold(
      (failure) {
        emit(HomeError(message: 'Failed to fetch jobs'));
      },
      (success) {
        if (success.isEmpty) {
          emit(HomeEmpty(message: 'No jobs were found'));
        } else {
          allJobs = success;
          emit(HomeLoaded(jobs: allJobs));
        }
      },
    );
  }

  Future<void> _moreJobsFetch(
      LoadMoreJobs event, Emitter<HomeState> emit) async {
    if (isFiltering == false) {
      emit(MoreJobsLoading());
      await Future.delayed(const Duration(seconds: 2));
      skip = skip + 10;
      final result = await _moreJobsUsecase(skip);
      result.fold(
        (failure) {
          emit(HomeError(message: 'Failed to fetch jobs'));
        },
        (success) {
          allJobs.addAll(success);
          emit(HomeLoaded(jobs: allJobs));
        },
      );
    }
  }

  Future<void> _filterJobs(
      FilterJobsEvent event, Emitter<HomeState> emit) async {
    if (event.jobRolesIds.isEmpty &&
        event.location.isEmpty &&
        event.skillIds.isEmpty) {
      return;
    }
    emit(HomeLoading());
    _clearFilter();
    isFiltering = true;
    skills.addAll(event.skillIds);
    jobRoles.addAll(event.jobRolesIds);
    location = event.location;
    final result = await _filterJobsUsecase(FilterJobParams(
        skillIds: event.skillIds,
        jobRoleIds: event.jobRolesIds,
        location: event.location));
    result.fold(
      (failure) {
        emit(HomeError(message: 'Failed to fetch jobs'));
      },
      (success) {
        if (success.isEmpty) {
          emit(HomeEmpty(message: 'No jobs were found'));
        } else {
          allJobs.clear();
          allJobs.addAll(success);
          emit(HomeLoaded(jobs: allJobs));
        }
      },
    );
  }

  Future<void> _resetFilter(ResetFilter event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    skip = 0;
    _clearFilter();
    final result = await _allJobsUsecase('');
    result.fold(
      (failure) {
        emit(HomeError(message: 'Failed to fetch jobs'));
      },
      (success) {
        if (success.isEmpty) {
          emit(HomeEmpty(message: 'No jobs were found'));
        } else {
          allJobs = success;
          emit(HomeLoaded(jobs: allJobs));
        }
      },
    );
  }

  Future<void> _handleSaveJob(SaveJob event, Emitter<HomeState> emit) async {
    savedJobsCache.add(event.jobId);
    unSavedJobsCache.remove(event.jobId);
    await _saveJobUsecase(event.jobId);
  }

  Future<void> _handleUnsaveJob(
      UnsaveJob event, Emitter<HomeState> emit) async {
    unSavedJobsCache.add(event.jobId);
    savedJobsCache.remove(event.jobId);
    await _unsaveJobUsecase(event.jobId);
  }

  _clearFilter() {
    skills.clear();
    jobRoles.clear();
    location = '';
    isFiltering = false;
  }
}
