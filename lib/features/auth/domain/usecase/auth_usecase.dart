import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/auth/domain/entity/auth_entity.dart';
import 'package:openbn/features/auth/domain/repository/auth_repository.dart';

class AuthUsecase implements Usecase<AuthEntity, dynamic> {
  final AuthRepository authRepository;

  AuthUsecase(this.authRepository);
  @override
  Future<Either<Faliure, AuthEntity>> call(params) async {
    return await authRepository.signIn();
  }
}
