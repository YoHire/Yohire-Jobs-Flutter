part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeInitEvent extends HomeEvent {}

class LoadMoreJobs extends HomeEvent {}