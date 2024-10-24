import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/features/auth/domain/entity/auth_entity.dart';
import 'package:openbn/features/auth/domain/usecase/auth_usecase.dart';
import 'package:openbn/features/auth/domain/usecase/check_phone_usecase.dart';
import 'package:openbn/features/auth/domain/usecase/create_user_usecase.dart';
import 'package:openbn/features/auth/domain/usecase/sent_otp_usecase.dart';
import 'package:openbn/features/auth/domain/usecase/verify_otp_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase _authUsecase;
  final CheckPhoneUsecase _checkPhoneUsecase;
  final SentOtpUsecase _sendOtpUsecase;
  final VerifyOtpUsecase _verifyOtpUsecase;
  final CreateUserUsecase _createUserUsecase;
  AuthBloc(
      {required AuthUsecase authUsecase,
      required CheckPhoneUsecase checkPhoneUsecase,
      required SentOtpUsecase sendOtpUsecase,
      required CreateUserUsecase createUserUsecase,
      required VerifyOtpUsecase verifyOtpUsecase})
      : _authUsecase = authUsecase,
        _checkPhoneUsecase = checkPhoneUsecase,
        _createUserUsecase = createUserUsecase,
        _sendOtpUsecase = sendOtpUsecase,
        _verifyOtpUsecase = verifyOtpUsecase,
        super(AuthInitial()) {
    on<AuthInit>(_handleAuthEvent);
    on<CheckPhoneNumber>(_handleCheckPhoneEvent);
    on<VerifyOtp>(_verifyOtp);
    on<CreateUser>(_createUser);
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

  Future<void> _handleCheckPhoneEvent(
      CheckPhoneNumber event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    if(event.phoneNumber.isEmpty || event.phoneNumber.length<4){
      emit(AuthError(message: 'Invalid Phone Number'));
      return;
    }
    final result = await _checkPhoneUsecase(event.phoneNumber);
    await result.fold(
      (failure) async {
        emit(AuthError(message: failure.message));
      },
      (success) async {
        if (success == false) {
          emit(AuthError(message: 'Phone Number Already Exists'));
        } else {
          final otpResult =
              await _sendOtpUsecase('${event.countryCode}${event.phoneNumber}');
          await otpResult.fold(
            (failure) async {
              emit(
                  AuthError(message: 'Failed to send OTP: ${failure.message}'));
            },
            (success) async {
              emit(OtpSent(
                  verificationId: success,
                  number: event.phoneNumber,
                  countryCode: event.countryCode));
            },
          );
        }
      },
    );
  }

  Future<void> _verifyOtp(VerifyOtp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _verifyOtpUsecase(
        OtpVerifyParams(verificationId: event.verificationId, otp: event.otp));
    result.fold(
      (failure) {
        emit(AuthError(message: failure.message));
      },
      (success) {
        emit(OtpVerified(
            idToken: success,
            phone: event.phone,
            countryCode: event.countryCode));
      },
    );
  }

  Future<void> _createUser(CreateUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _createUserUsecase(CreateUserParams(
        countryCode: event.countryCode,
        idToken: event.idToken,
        phone: event.phone));
    result.fold(
      (failure) {
        log('is a faliure');
        log(failure.message);
        emit(AuthError(message: failure.message));
      },
      (success) {
        log('is a success');
        emit(AuthSuccess(
            user: AuthEntity(isNewUser: false, email: success.email)));
      },
    );
  }
}
