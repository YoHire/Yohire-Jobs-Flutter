import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/circle/domain/entities/queue_invitation_entity.dart';
import 'package:openbn/features/circle/domain/repository/circle_repository.dart';

class GetAllInvitationUsecase
    implements Usecase<List<InvitationEntity>, String> {
  final CircleRepository repository;

  GetAllInvitationUsecase(this.repository);
  @override
  Future<Either<Failure, List<InvitationEntity>>> call(String params) async {
    return await repository.getAllInvitations(queueId: params);
  }
}
