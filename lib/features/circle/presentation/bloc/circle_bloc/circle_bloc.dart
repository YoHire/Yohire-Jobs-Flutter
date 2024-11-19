import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/features/circle/domain/entities/queue_entity.dart';
import 'package:openbn/features/circle/domain/usecases/get_all_queue_usecase.dart';

part 'circle_event.dart';
part 'circle_state.dart';

class CircleBloc extends Bloc<CircleEvent, CircleState> {
  final GetAllQueueUsecase _getAllQueueUsecase;
  CircleBloc({required GetAllQueueUsecase getAllQueueUsecase})
      : _getAllQueueUsecase = getAllQueueUsecase,
        super(CircleInitial()) {
    on<FetchQueueEvent>(_getAllQueue);
  }

  Future<void> _getAllQueue(
    FetchQueueEvent event,
    Emitter<CircleState> emit,
  ) async {
    emit(CircleLoading());
    try {
      final result = await _getAllQueueUsecase('');

      result.fold(
        (failure) {
          emit(CircleError(message: failure.message));
        },
        (success) {
          if (success.isEmpty) {
            emit(CircleEmpty());
          } else {
            emit(CircleLoaded(data: success));
          }
        },
      );
    } catch (e) {
      emit(CircleError(message: e.toString()));
    }
  }
}
