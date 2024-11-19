part of 'experience_bloc.dart';

sealed class ExperienceState {}

final class ExperienceInitial extends ExperienceState {}

final class ExperienceSaving extends ExperienceState {}

final class ExperienceSaved extends ExperienceState {}

final class ExperienceError extends ExperienceState {
  final String message;

  ExperienceError({required this.message});
}
