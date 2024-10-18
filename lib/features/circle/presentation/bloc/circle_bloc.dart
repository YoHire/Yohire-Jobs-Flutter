import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'circle_event.dart';
part 'circle_state.dart';

class CircleBloc extends Bloc<CircleEvent, CircleState> {
  CircleBloc() : super(CircleInitial()) {
    on<CircleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
