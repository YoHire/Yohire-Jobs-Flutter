part of 'timer_bloc.dart';

sealed class TimerState {}

final class TimerInitial extends TimerState {}

final class TimerRunning extends TimerState {}

final class TimerFinished extends TimerState {}
