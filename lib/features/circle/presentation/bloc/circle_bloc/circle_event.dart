part of 'circle_bloc.dart';

sealed class CircleEvent {}

class FetchQueueEvent extends CircleEvent {}

class DeleteQueueEvent extends CircleEvent {
  final String ququeId;

  DeleteQueueEvent({required this.ququeId});
}
