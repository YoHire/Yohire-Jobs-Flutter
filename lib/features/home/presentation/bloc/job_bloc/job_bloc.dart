import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  JobBloc() : super(JobInitial()) {
    on<JobEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
