import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/username/domain/repository/username_repository.dart';

class UsernameUpdateUsecase implements Usecase<void, String> {
  final UsernameRepository usernameRepository;

  UsernameUpdateUsecase(this.usernameRepository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await usernameRepository.saveUsername(username: params);
  }
}
