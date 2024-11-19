import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/core/utils/shared_services/models/country/country_model.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/features/circle/domain/repository/circle_repository.dart';

class CreateQueueUsecase implements Usecase<void, CreateQueueParams> {
  final CircleRepository repository;

  CreateQueueUsecase(this.repository);
  @override
  Future<Either<Failure, void>> call(CreateQueueParams params) async {
    return await repository.joinQueue(
        bio: params.bio,
        countries: params.countries,
        jobRole: params.jobRole,
        salaryEnd: params.salaryEnd,
        salaryStart: params.salaryStart);
  }
}

class CreateQueueParams {
  final JobRoleModel jobRole;
  final List<CountryModel> countries;
  final double salaryStart;
  final double salaryEnd;
  final String bio;

  CreateQueueParams(
      {required this.jobRole,
      required this.countries,
      required this.salaryStart,
      required this.salaryEnd,
      required this.bio});
}
