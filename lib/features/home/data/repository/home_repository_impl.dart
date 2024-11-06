import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/features/home/data/datasource/job_api_datasource.dart';
import 'package:openbn/features/home/data/models/job_model.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/features/home/domain/repository/home_repository.dart';
import 'package:openbn/init_dependencies.dart';

import '../../../../core/utils/constants/constants.dart';

class HomeRepositoryImpl implements HomeRepository {
  final JobRemoteDataSource dataSource;

  HomeRepositoryImpl(this.dataSource);

  final storage = serviceLocator<GetStorage>();

  @override
  Future<Either<Failure, List<JobEntity>>> getAllJobs() async {
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
  Future<Either<Failure, List<JobEntity>>> getMoreJobs(
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
}
