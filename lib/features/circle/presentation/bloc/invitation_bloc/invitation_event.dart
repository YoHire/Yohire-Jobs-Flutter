part of 'invitation_bloc.dart';


sealed class InvitationEvent {}

class FetchInvitation extends InvitationEvent{
  final String queueId;

  FetchInvitation({required this.queueId});
}
