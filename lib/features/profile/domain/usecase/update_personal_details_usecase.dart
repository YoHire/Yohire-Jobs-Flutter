import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/features/profile/domain/entity/personal_details_entity.dart';
import 'package:openbn/features/profile/domain/repository/profile_repository.dart';

class UpdatePersonalDetailsUsecase
    implements Usecase<void, PersonalDetailsEntity> {
  final ProfileRepository profileRepository;

  UpdatePersonalDetailsUsecase(this.profileRepository);
  @override
  Future<Either<Failure, void>> call(params) async {
    return await profileRepository.updatePersonalDetails(
        personalDetails: params.toData());
  }
}
