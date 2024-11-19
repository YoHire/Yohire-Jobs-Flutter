part of 'invitation_bloc.dart';


sealed class InvitationState {}

final class InvitationInitial extends InvitationState {}
final class InvitationLoading extends InvitationState {}

final class InvitationError extends InvitationState {
  final String message;
  InvitationError({required this.message});
}

final class InvitationEmpty extends InvitationState {}

final class InvitationLoaded extends InvitationState {
  final List<InvitationEntity> data;

  InvitationLoaded({required this.data});
}