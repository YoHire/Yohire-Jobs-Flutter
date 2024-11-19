import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/features/profile/domain/repository/profile_repository.dart';

class UpdateSkillUsecase implements Usecase<void, List<SkillModel>> {
  final ProfileRepository profileRepository;

  UpdateSkillUsecase(this.profileRepository);
  @override
  Future<Either<Failure, void>> call(params) async {
    return await profileRepository.updateSkills(skillIds: params);
  }
}
