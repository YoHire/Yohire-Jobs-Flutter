import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(TimerInitial()) {
    on<TimerStarted>((event, emit) {
      emit(TimerRunning());
    });
    on<TimerStopped>((event, emit) {
      emit(TimerFinished());
    });
  }
}
