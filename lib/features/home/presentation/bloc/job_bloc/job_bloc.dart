import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/features/home/domain/usecase/apply_job_usecase.dart';
import 'package:openbn/features/home/domain/usecase/get_single_job_usecase.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final GetSingleJobUsecase _singleJobsUsecase;
  final ApplyJobUsecase _applyJobUsecase;

  JobBloc(
      {required GetSingleJobUsecase singleJobsUsecase,
      required ApplyJobUsecase applyJobUsecase})
      : _singleJobsUsecase = singleJobsUsecase,
        _applyJobUsecase = applyJobUsecase,
        super(JobInitial()) {
    on<JobInitEvent>(_jobsFetch);
    on<JobApplyEvent>(_jobApply);
  }
  Future<void> _jobsFetch(JobInitEvent event, Emitter<JobState> emit) async {
    emit(JobLoading());
    final result = await _singleJobsUsecase(event.id);
    result.fold(
      (failure) {
        emit(JobError(message: 'Failed to fetch job data'));
      },
      (success) {
        emit(JobLoaded(data: success));
      },
    );
  }

  Future<void> _jobApply(JobApplyEvent event, Emitter<JobState> emit) async {
    emit(JobApplying());
    final result = await _applyJobUsecase(
        JobApplyParams(jobId: event.jobId, recruiterId: event.recruiterId));
    result.fold(
      (failure) {
        log(failure.message);
        emit(JobError(message: 'Failed to fetch job data'));
      },
      (success) {
        emit(JobApplied());
      },
    );
  }
}
