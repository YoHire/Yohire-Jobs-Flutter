part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashLoading extends SplashState {}

final class SplashFailedState extends SplashState {}

final class SplashLoggedIn extends SplashState {}

final class SplashLoggedOut extends SplashState {}
