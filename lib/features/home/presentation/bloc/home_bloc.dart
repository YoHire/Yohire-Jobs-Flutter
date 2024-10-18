
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/features/home/domain/usecase/get_jobs_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllJobsUsecase _allJobsUsecase;
  HomeBloc({required GetAllJobsUsecase allJobsUsecase})
      : _allJobsUsecase = allJobsUsecase,
        super(HomeInitial()) {
    on<HomeInitEvent>(_jobsFetch);
  }

  Future<void> _jobsFetch(HomeInitEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    final result = await _allJobsUsecase('');
    result.fold(
      (failure) {
        emit(HomeError(message: 'Failed to fetch jobs'));
      },
      (success) {
        emit(HomeLoaded(jobs: success));
      },
    );
  }
}
