import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/auth/domain/repository/auth_repository.dart';

class CheckPhoneUsecase implements Usecase<bool, String> {
  final AuthRepository authRepository;

  CheckPhoneUsecase(this.authRepository);
  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await authRepository.checkPhone(phone: params);
  }
}
