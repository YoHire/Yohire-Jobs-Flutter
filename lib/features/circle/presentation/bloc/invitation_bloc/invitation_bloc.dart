import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/features/circle/domain/entities/queue_invitation_entity.dart';
import 'package:openbn/features/circle/domain/usecases/get_all_invitation_usecase.dart';

part 'invitation_event.dart';
part 'invitation_state.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  final GetAllInvitationUsecase _getAllInvitationUsecase;
  InvitationBloc({required GetAllInvitationUsecase getAllInvitationUsecase})
      : _getAllInvitationUsecase = getAllInvitationUsecase,
        super(InvitationInitial()) {
    on<FetchInvitation>(_handleFetchInvitation);
  }
  Future<void> _handleFetchInvitation(
    FetchInvitation event,
    Emitter<InvitationState> emit,
  ) async {
    emit(InvitationLoading());
    try {
      final result = await _getAllInvitationUsecase(event.queueId);

      result.fold(
        (failure) {
          emit(InvitationError(message: failure.message));
        },
        (success) {
          if (success.isEmpty) {
            emit(InvitationEmpty());
          } else {
            emit(InvitationLoaded(data: success));
          }
        },
      );
    } catch (e) {
      emit(InvitationError(message: e.toString()));
    }
  }
}
