import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/features/profile/data/models/personal_details_model.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, void>> updatePersonalDetails(
      {required PersonalDetailsModel personalDetails});
}
