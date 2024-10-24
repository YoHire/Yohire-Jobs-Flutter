
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/features/splash/domain/usecases/splash_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashUsecase _splashUsecase;

  SplashBloc({required SplashUsecase splashUsecase})
      : _splashUsecase = splashUsecase,
        super(SplashInitial()) {
    on<SplashLoaded>(_onSplashLoaded);
  }

  Future<void> _onSplashLoaded(
      SplashLoaded event, Emitter<SplashState> emit) async {
    emit(SplashLoading());
    await Future.delayed(const Duration(seconds: 5));

    final result = await _splashUsecase('');
    result.fold((failure) {
    }, (success) {
      if (success == false) {
        emit(SplashLoggedOut());
      } else {
        emit(SplashLoggedIn());
      }
    });
  }
}
