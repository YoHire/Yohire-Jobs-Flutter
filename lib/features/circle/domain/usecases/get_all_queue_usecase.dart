import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/circle/domain/entities/queue_entity.dart';
import 'package:openbn/features/circle/domain/repository/circle_repository.dart';

class GetAllQueueUsecase implements Usecase<List<QueueEntity>, void> {
  final CircleRepository repository;

  GetAllQueueUsecase(this.repository);
  @override
  Future<Either<Failure, List<QueueEntity>>> call(params) async {
    return await repository.getAllQueues();
  }
}
