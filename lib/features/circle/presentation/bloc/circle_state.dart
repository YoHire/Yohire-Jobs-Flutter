part of 'circle_bloc.dart';

sealed class CircleState extends Equatable {
  const CircleState();
  
  @override
  List<Object> get props => [];
}

final class CircleInitial extends CircleState {}
