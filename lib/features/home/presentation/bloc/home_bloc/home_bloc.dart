import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/features/home/domain/usecase/get_jobs_usecase.dart';
import 'package:openbn/features/home/domain/usecase/get_more_jobs_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllJobsUsecase _allJobsUsecase;
  final GetMoreJobsUsecase _moreJobsUsecase;
  HomeBloc(
      {required GetAllJobsUsecase allJobsUsecase,
      required GetMoreJobsUsecase moreJobsUsecase})
      : _allJobsUsecase = allJobsUsecase,
        _moreJobsUsecase = moreJobsUsecase,
        super(HomeInitial()) {
    on<HomeInitEvent>(_jobsFetch);
    on<LoadMoreJobs>(_moreJobsFetch);
  }

  List<JobEntity> allJobs = [];
  int skip = 0;

  Future<void> _jobsFetch(HomeInitEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    skip=0;
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
