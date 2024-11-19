part of 'circle_bloc.dart';

sealed class CircleState {}

final class CircleInitial extends CircleState {}

final class CircleLoading extends CircleState {}

final class CircleEmpty extends CircleState {}

final class CircleLoaded extends CircleState {
  final List<QueueEntity> data;

  CircleLoaded({required this.data});
}

final class CircleError extends CircleState {
  final String message;
  CircleError({required this.message});
}
