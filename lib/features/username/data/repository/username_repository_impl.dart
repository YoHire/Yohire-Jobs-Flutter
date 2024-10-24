import 'package:fpdart/fpdart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/features/username/data/datasource/username_datasource.dart';
import 'package:openbn/features/username/domain/repository/username_repository.dart';
import 'package:openbn/init_dependencies.dart';

class UsernameRepositoryImpl implements UsernameRepository {
  final UsernameRemoteDatasource dataSource;

  UsernameRepositoryImpl(this.dataSource);

  final storage = serviceLocator<GetStorage>();

  @override
  Future<Either<Failure, void>> saveUsername({required String username}) async {
    try {
      Map<String, dynamic> body = {
        "username": username,
        "userId": storage.read('userId')
      };
      await dataSource.saveUsername(body: body);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
