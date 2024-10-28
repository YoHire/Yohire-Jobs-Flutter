import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/features/profile/domain/entity/personal_details_entity.dart';
import 'package:openbn/features/profile/domain/usecase/update_personal_details_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdatePersonalDetailsUsecase _updatePersonalDetailsUsecase;
  ProfileBloc(
      {required UpdatePersonalDetailsUsecase updatePersonalDetailsUsecase})
      : _updatePersonalDetailsUsecase = updatePersonalDetailsUsecase,
        super(ProfileInitial()) {
    on<UpdatePersonalDataEvent>(_handlePersonalDetailsUpdate);
  }

  _handlePersonalDetailsUpdate(
      UpdatePersonalDataEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdating());

    final result = await _updatePersonalDetailsUsecase(event.data);

    result.fold(
      (failure) {
        emit(UpdateError(message: 'Failed to update details'));
      },
      (success) async {
        emit(UpdateSuccess());
      },
    );
  }
}
