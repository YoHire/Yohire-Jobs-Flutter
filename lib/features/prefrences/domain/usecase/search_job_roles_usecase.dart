
import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/prefrences/domain/entity/job_role_entity.dart';
import 'package:openbn/features/prefrences/domain/repository/prefrence_repository.dart';

class SearchJobRolesUsecase implements Usecase<List<JobRoleEntity>,String>{
  final PrefrenceRepository prefrenceRepository;

  SearchJobRolesUsecase(this.prefrenceRepository);
  @override
  Future<Either<Failure, List<JobRoleEntity>>> call(String params) async{
    return await prefrenceRepository.searchJobRoles(keyword: params);
  }

}