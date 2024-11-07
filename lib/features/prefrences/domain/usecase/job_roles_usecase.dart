import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/features/prefrences/domain/repository/prefrence_repository.dart';

class JobRolesUseCase implements Usecase<List<JobRoleModel>,String?>{
  final PrefrenceRepository prefrenceRepository;

  JobRolesUseCase(this.prefrenceRepository);
  @override
  Future<Either<Failure, List<JobRoleModel>>> call(params) async{
    return await prefrenceRepository.getJobRoles(industry: params!);
  }

}