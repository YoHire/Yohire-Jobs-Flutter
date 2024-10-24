import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/prefrences/domain/entity/job_role_entity.dart';
import 'package:openbn/features/prefrences/domain/repository/prefrence_repository.dart';

class CreateGuestUserUsecase implements Usecase<void, List<JobRoleEntity>> {
  final PrefrenceRepository prefrenceRepository;

  CreateGuestUserUsecase(this.prefrenceRepository);
  @override
  Future<Either<Failure, void>> call(params) async {
    return await prefrenceRepository.createGuestUser(
        data: params.map((e) {
      return e.toData();
    }).toList());
  }
}
