import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/features/prefrences/domain/repository/prefrence_repository.dart';

class CreateGuestUserUsecase implements Usecase<void, List<JobRoleModel>> {
  final PrefrenceRepository prefrenceRepository;

  CreateGuestUserUsecase(this.prefrenceRepository);
  @override
  Future<Either<Failure, void>> call(params) async {
    return await prefrenceRepository.createGuestUser(
        data: params.map((e) {
      return e;
    }).toList());
  }
}
