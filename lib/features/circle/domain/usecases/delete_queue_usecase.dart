import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/circle/domain/repository/circle_repository.dart';

class DeleteQueueUsecase implements Usecase<void, String> {
  final CircleRepository repository;

  DeleteQueueUsecase(this.repository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteQueue(queueId: params);
  }
}
