import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/features/home/data/datasource/home_api_datasource.dart';
import 'package:openbn/features/home/data/models/job_model.dart';
import 'package:openbn/features/home/domain/repository/home_repository.dart';
import 'package:openbn/init_dependencies.dart';

import '../../../../core/utils/constants/constants.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeApiDatasource dataSource;

  HomeRepositoryImpl(this.dataSource);

  final storage = serviceLocator<GetStorage>();

  @override
  Future<Either<Failure, List<JobModel>>> getAllJobs() async {
    try {
      final data = await dataSource.getAllJobs(
          isLogged: storage.read('isLogged') == true ? true : false);

      List<dynamic> results = data['data'];

      return Right(results
          .where((json) => json['status'] == Status.active)
          .map((json) => JobModel.fromJson(json))
          .toList());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<JobModel>>> getMoreJobs(
      {required int skip}) async {
    try {
      final data = await dataSource.getMoreJobs(
          isLogged: storage.read('isLogged') == true ? true : false,
          skipCount: skip);

      List<dynamic> results = data['data'];

      return Right(results
          .where((json) => json['status'] == Status.active)
          .map((json) => JobModel.fromJson(json))
          .toList());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<JobModel>>> getFilteredJobs(
      {required String location,
      required List<SkillModel> skillIds,
      required List<JobRoleModel> jobRoleIds}) async {
    try {
      Map<String, dynamic> filterData = {
        "location": location,
        "skills": skillIds.isEmpty
            ? []
            : skillIds.map((e) => SkillModel.getId(e)).toList(),
        "jobRoles": jobRoleIds.isEmpty
            ? []
            : jobRoleIds.map((e) => JobRoleModel.getId(e)).toList(),
      };
      final data = await dataSource.filterJobs(
          isLogged: storage.read('isLogged') == true ? true : false,
          filterData: filterData);
      List<dynamic> results = data['data'];
          

      return Right(results
          .where((json) => json['status'] == Status.active)
          .map((json) => JobModel.fromJson(json))
          .toList());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
