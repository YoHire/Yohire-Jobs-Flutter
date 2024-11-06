part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}
final class MoreJobsLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<JobEntity> jobs;

  HomeLoaded({required this.jobs});
}

class HomeEmpty extends HomeState {
  final String message;
  HomeEmpty({required this.message});
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}
