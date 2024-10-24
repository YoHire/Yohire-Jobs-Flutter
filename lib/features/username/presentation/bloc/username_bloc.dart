import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/features/username/domain/usecase/username_update_usecase.dart';

part 'username_event.dart';
part 'username_state.dart';

class UsernameBloc extends Bloc<UsernameEvent, UsernameState> {
  final UsernameUpdateUsecase _usernameUpdateUsecase;
  UsernameBloc({required UsernameUpdateUsecase usernameUpdateUsecase})
      : _usernameUpdateUsecase = usernameUpdateUsecase,
        super(UsernameInitial()) {
    on<SaveUserName>(_handleUsernameSaveEvent);
  }

  _handleUsernameSaveEvent(
      SaveUserName event, Emitter<UsernameState> emit) async {
    emit(UsernameLoading());
    final result = await _usernameUpdateUsecase(event.username);
    result.fold(
      (failure) {
        emit(UsernameError(errorMessage: 'Failed to create guest user'));
      },
      (success) {
        emit(UsernameSaved());
      },
    );
  }
}
