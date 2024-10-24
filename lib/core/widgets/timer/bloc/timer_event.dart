part of 'timer_bloc.dart';

sealed class TimerEvent {}

class TimerStopped extends TimerEvent {}
class TimerStarted extends TimerEvent {}