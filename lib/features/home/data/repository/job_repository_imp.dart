import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/features/home/data/datasource/job_api_datasource.dart';
import 'package:openbn/features/home/data/models/job_model.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/features/home/domain/repository/job_repository.dart';
import 'package:openbn/init_dependencies.dart';

class JobRepositoryImpl implements JobRepository {
  final JobApiDatasource datasource;

  JobRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, JobEntity>> getJobById({required String id}) async {
    try {
      final storage = serviceLocator<GetStorage>();
      final data = await datasource.getJobById(id: id,isLogged: storage.read('isLogged') == true ? true : false);

      final results = data['data']['job'];

      return Right(JobModel.fromJson(results,data['data']['isApplied']));
    } catch (e) {
      log(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> applyJob(
      {required String recruiterId,
      required String jobId}) async {
    try {
      final storage = serviceLocator<GetStorage>();
      Map<String, dynamic> body = {
        'jobId': jobId,
        'userId': storage.read('userId'),
        'recruiterId': recruiterId
      };
      await datasource.applyJob(body);

      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
