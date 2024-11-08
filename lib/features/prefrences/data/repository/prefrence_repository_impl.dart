import 'package:fpdart/fpdart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/utils/shared_services/functions/device_id.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/features/prefrences/data/datasource/jobroles_remote_data_source.dart';
import 'package:openbn/features/prefrences/domain/repository/prefrence_repository.dart';
import 'package:openbn/init_dependencies.dart';

class PrefrenceRepositoryImpl implements PrefrenceRepository {
  final JobrolesRemoteDataSource dataSource;

  PrefrenceRepositoryImpl(this.dataSource);

  final storage = serviceLocator<GetStorage>();

  @override
  Future<Either<Failure, List<JobRoleModel>>> getJobRoles(
      {String industry = 'none'}) async {
    try {
      final data = await dataSource.getJobRoles(industry: industry);
      List<dynamic> results = data['data'];
      return Right(results.map((json) => JobRoleModel.fromJson(json)).toList());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<JobRoleModel>>> searchJobRoles(
      String keyword) async {
    try {
      final data = await dataSource.searchJobRoles(keyword: keyword);
      List<dynamic> results = data['data'];
      return Right(results.map((json) => JobRoleModel.fromJson(json)).toList());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createGuestUser(
      {required List<JobRoleModel> data}) async {
    try {
      Map<String, dynamic> body = {
        "deviceId": await getDeviceId(),
        "job-role": data.map((e) => e.toStringList()).toList(),
      };
      final result = await dataSource.createGuestUser(body);
      storage.write('firstTime', false);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
