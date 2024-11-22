import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openbn/features/circle/domain/entities/queue_entity.dart';
import 'package:openbn/features/circle/domain/usecases/get_all_queue_usecase.dart';
import 'package:openbn/init_dependencies.dart';

import '../../../domain/usecases/delete_queue_usecase.dart';

part 'circle_event.dart';
part 'circle_state.dart';

class CircleBloc extends Bloc<CircleEvent, CircleState> {
  final GetAllQueueUsecase _getAllQueueUsecase;
  final DeleteQueueUsecase _deleteQueueUsecase;
  CircleBloc(
      {required GetAllQueueUsecase getAllQueueUsecase,
      required DeleteQueueUsecase deleteQueueUsecase})
      : _getAllQueueUsecase = getAllQueueUsecase,
        _deleteQueueUsecase = deleteQueueUsecase,
        super(CircleInitial()) {
    on<FetchQueueEvent>(_getAllQueue);
    on<DeleteQueueEvent>(_deleteQueue);
  }

  Future<void> _getAllQueue(
    FetchQueueEvent event,
    Emitter<CircleState> emit,
  ) async {
    final storage = serviceLocator<GetStorage>();
    if (storage.read('isLogged') == null) {
      emit(CircleNotLoggedIn());
    } else {
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

  Future<void> _deleteQueue(
    DeleteQueueEvent event,
    Emitter<CircleState> emit,
  ) async {
    emit(CircleLoading());
    try {
      final result = await _deleteQueueUsecase(event.ququeId);

      result.fold(
        (failure) {
          emit(CircleError(message: failure.message));
        },
        (success) {
          add(FetchQueueEvent());
        },
      );
    } catch (e) {
      emit(CircleError(message: e.toString()));
    }
  }
}
