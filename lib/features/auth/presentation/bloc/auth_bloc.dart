import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/features/auth/domain/entity/auth_entity.dart';
import 'package:openbn/features/auth/domain/usecase/auth_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase _authUsecase;
  AuthBloc({required AuthUsecase authUsecase})
      : _authUsecase = authUsecase,
        super(AuthInitial()) {
    on<AuthInit>(_handleAuthEvent);
  }

  Future<void> _handleAuthEvent(AuthInit event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _authUsecase(null);
    result.fold(
      (failure) {
        emit(AuthError(message: failure.message));
      },
      (success) {
        emit(AuthSuccess(user: success));
      },
    );
  }
}
