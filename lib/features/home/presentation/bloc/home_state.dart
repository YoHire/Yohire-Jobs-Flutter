part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<JobEntity> jobs;

  HomeLoaded({required this.jobs});
}

class HomeEmpty extends HomeState {}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}
