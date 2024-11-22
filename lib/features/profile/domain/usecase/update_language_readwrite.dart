import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/core/utils/shared_services/models/language/language_model.dart';
import 'package:openbn/features/profile/domain/repository/profile_repository.dart';

class UpdateLanguageReadwriteUsecase implements Usecase<void, List<LanguageModel>> {
  final ProfileRepository profileRepository;

  UpdateLanguageReadwriteUsecase(this.profileRepository);
  @override
  Future<Either<Failure, void>> call(params) async {
    return await profileRepository.updateLanguagesReadAndWrite(languages: params);
  }
}
